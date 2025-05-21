package controller.lawyer;

import dao.LawyerDAO;
import model.Lawyer;
import model.User;
import util.FileStorageUtil;
import util.ImageUtil;
import util.SessionUtil;
import util.ValidationUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.json.JSONObject;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Logger;

@WebServlet(name = "LawyerProfileServlet", urlPatterns = {"/lawyer/lawyer-profile"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10,      // 10MB
        maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class LawyerProfileServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(LawyerProfileServlet.class.getName());
    private LawyerDAO lawyerDAO;

    @Override
    public void init() throws ServletException {
        try {
            lawyerDAO = new LawyerDAO();
        } catch (SQLException e) {
            LOGGER.severe("Failed to initialize LawyerDAO: " + e.getMessage());
            throw new ServletException("Failed to initialize LawyerDAO", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = SessionUtil.getLoggedInUser(request);

        if (user == null || !"LAWYER".equals(user.getRole())) {
            LOGGER.warning("Unauthorized access attempt: user=" + (user != null ? user.getUserId() : "null"));
            request.getRequestDispatcher("/WEB-INF/views/error/access-denied.jsp").forward(request, response);
            return;
        }

        Lawyer lawyer = lawyerDAO.getLawyerById(user.getUserId());
        if (lawyer != null) {
            request.setAttribute("lawyer", lawyer);
            request.getRequestDispatcher("/WEB-INF/views/lawyer/lawyerProfile.jsp").forward(request, response);
        } else {
            LOGGER.warning("Lawyer not found for userId: " + user.getUserId());
            request.setAttribute("errorMessage", "Lawyer profile not found.");
            request.getRequestDispatcher("/WEB-INF/views/error/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        String xhrHeader = request.getHeader("X-Requested-With");
        LOGGER.info("X-Requested-With header: " + xhrHeader);

        if (session == null || SessionUtil.getLoggedInUser(request) == null || !"LAWYER".equals(SessionUtil.getLoggedInUser(request).getRole())) {
            LOGGER.warning("Unauthorized POST attempt: session=" + (session != null ? "exists" : "null"));
            if ("XMLHttpRequest".equals(xhrHeader)) {
                sendJsonResponse(response, false, "User not logged in or not authorized.");
                return;
            }
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User sessionUser = SessionUtil.getLoggedInUser(request);
        try {
            Lawyer lawyer = lawyerDAO.getLawyerById(sessionUser.getUserId());
            if (lawyer == null) {
                LOGGER.warning("Lawyer not found for userId: " + sessionUser.getUserId());
                if ("XMLHttpRequest".equals(xhrHeader)) {
                    sendJsonResponse(response, false, "Lawyer not found.");
                    return;
                }
                request.setAttribute("errorMessage", "Lawyer not found.");
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }

            // Retrieve form parameters
            String fullName = ValidationUtil.sanitizeInput(request.getParameter("fullName"));
            String email = ValidationUtil.sanitizeInput(request.getParameter("email"));
            String phone = ValidationUtil.sanitizeInput(request.getParameter("phone"));
            String address = ValidationUtil.sanitizeInput(request.getParameter("address"));
            String gender = ValidationUtil.sanitizeInput(request.getParameter("gender"));
            String dateOfBirth = ValidationUtil.sanitizeInput(request.getParameter("dateOfBirth"));
            Part profilePicturePart = request.getPart("profilePicture");

            // Log received parameters
            LOGGER.info("Received parameters: fullName=" + fullName + ", email=" + email + ", phone=" + phone +
                    ", address=" + address + ", gender=" + gender + ", dateOfBirth=" + dateOfBirth +
                    ", profilePicturePart=" + (profilePicturePart != null ? profilePicturePart.getSize() : "null"));

            // Validate inputs
            StringBuilder errorMessage = new StringBuilder();
            if (ValidationUtil.isEmpty(fullName)) {
                errorMessage.append("Full name is required. ");
            }
            if (ValidationUtil.isEmpty(email)) {
                errorMessage.append("Email is required. ");
            } else if (!ValidationUtil.isValidEmail(email)) {
                errorMessage.append("Invalid email format. ");
            }
            if (ValidationUtil.isEmpty(phone)) {
                errorMessage.append("Phone number is required. ");
            } else if (!ValidationUtil.isValidPhone(phone)) {
                errorMessage.append("Invalid phone number format. ");
            }
            if (ValidationUtil.isEmpty(address)) {
                errorMessage.append("Address is required. ");
            }
            if (ValidationUtil.isEmpty(gender)) {
                errorMessage.append("Gender is required. ");
            }
            if (dateOfBirth != null && !dateOfBirth.matches("\\d{4}-\\d{2}-\\d{2}")) {
                errorMessage.append("Invalid date of birth format (YYYY-MM-DD). ");
            }

            if (errorMessage.length() > 0) {
                LOGGER.warning("Validation failed: " + errorMessage.toString());
                if ("XMLHttpRequest".equals(xhrHeader)) {
                    sendJsonResponse(response, false, errorMessage.toString());
                    return;
                }
                request.setAttribute("errorMessage", errorMessage.toString());
                request.setAttribute("lawyer", lawyer);
                request.getRequestDispatcher("/WEB-INF/views/lawyer/lawyerProfile.jsp").forward(request, response);
                return;
            }

            // Handle profile picture
            String oldProfileImage = lawyer.getProfileImage();
            String newProfileImage = oldProfileImage;
            if (profilePicturePart != null && profilePicturePart.getSize() > 0) {
                String contentType = profilePicturePart.getContentType();
                if (!contentType.equals("image/jpeg") && !contentType.equals("image/png")) {
                    LOGGER.warning("Invalid file type: " + contentType);
                    if ("XMLHttpRequest".equals(xhrHeader)) {
                        sendJsonResponse(response, false, "Only JPEG or PNG images are allowed.");
                        return;
                    }
                    request.setAttribute("errorMessage", "Only JPEG or PNG images are allowed.");
                    request.setAttribute("lawyer", lawyer);
                    request.getRequestDispatcher("/WEB-INF/views/lawyer/lawyerProfile.jsp").forward(request, response);
                    return;
                }
                newProfileImage = ImageUtil.resizeAndSaveProfileImage(profilePicturePart, lawyer.getUserId(), getServletContext());
                LOGGER.info("New profile image saved: " + newProfileImage);
            }

            // Update lawyer object
            lawyer.setFullName(fullName);
            lawyer.setEmail(email);
            lawyer.setPhone(phone);
            lawyer.setAddress(address);
            lawyer.setGender(gender);
            lawyer.setDateOfBirth(dateOfBirth);
            lawyer.setProfileImage(newProfileImage);

            // Update profile in database
            try {
                boolean success = lawyerDAO.updateLawyer(lawyer);
                if (success) {
                    // Delete old profile image if a new one was uploaded
                    if (profilePicturePart != null && profilePicturePart.getSize() > 0 && oldProfileImage != null) {
                        FileStorageUtil.deleteProfileImage(oldProfileImage, getServletContext());
                        LOGGER.info("Deleted old profile image: " + oldProfileImage);
                    }
                    // Update session user
                    session.setAttribute("user", lawyer);
                    if ("XMLHttpRequest".equals(xhrHeader)) {
                        sendJsonResponse(response, true, "Profile updated successfully.", lawyer);
                        return;
                    }
                    request.setAttribute("successMessage", "Profile updated successfully.");
                } else {
                    // Clean up new profile image if update failed
                    if (newProfileImage != null && !newProfileImage.equals(oldProfileImage)) {
                        FileStorageUtil.deleteProfileImage(newProfileImage, getServletContext());
                        LOGGER.info("Cleaned up new profile image due to update failure: " + newProfileImage);
                    }
                    LOGGER.warning("Failed to update lawyer profile in database for userId: " + lawyer.getUserId());
                    if ("XMLHttpRequest".equals(xhrHeader)) {
                        sendJsonResponse(response, false, "Failed to update profile in database.");
                        return;
                    }
                    request.setAttribute("errorMessage", "Failed to update profile in database.");
                }
            } catch (SQLException e) {
                LOGGER.severe("Database error updating lawyer profile: " + e.getMessage());
                // Clean up new profile image if update failed
                if (newProfileImage != null && !newProfileImage.equals(oldProfileImage)) {
                    FileStorageUtil.deleteProfileImage(newProfileImage, getServletContext());
                    LOGGER.info("Cleaned up new profile image due to database error: " + newProfileImage);
                }
                if ("XMLHttpRequest".equals(xhrHeader)) {
                    sendJsonResponse(response, false, "Database error: " + e.getMessage());
                    return;
                }
                request.setAttribute("errorMessage", "Database error occurred while updating profile.");
            }

            request.setAttribute("lawyer", lawyer);
            request.getRequestDispatcher("/WEB-INF/views/lawyer/lawyerProfile.jsp").forward(request, response);
        } catch (IOException e) {
            LOGGER.severe("IO error processing profile picture: " + e.getMessage());
            if ("XMLHttpRequest".equals(xhrHeader)) {
                sendJsonResponse(response, false, "Error processing profile picture.");
                return;
            }
            request.setAttribute("errorMessage", "Error processing profile picture.");
            request.setAttribute("lawyer", sessionUser);
            request.getRequestDispatcher("/WEB-INF/views/lawyer/lawyerProfile.jsp").forward(request, response);
        }
    }

    private void sendJsonResponse(HttpServletResponse response, boolean success, String message) throws IOException {
        sendJsonResponse(response, success, message, null);
    }

    private void sendJsonResponse(HttpServletResponse response, boolean success, String message, Lawyer lawyer) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.setStatus(success ? HttpServletResponse.SC_OK : HttpServletResponse.SC_BAD_REQUEST);
        PrintWriter out = response.getWriter();
        JSONObject json = new JSONObject();
        json.put("success", success);
        json.put("message", message);
        if (lawyer != null) {
            JSONObject lawyerJson = new JSONObject();
            lawyerJson.put("fullName", lawyer.getFullName());
            lawyerJson.put("email", lawyer.getEmail());
            lawyerJson.put("phone", lawyer.getPhone());
            lawyerJson.put("address", lawyer.getAddress());
            lawyerJson.put("gender", lawyer.getGender());
            lawyerJson.put("dateOfBirth", lawyer.getDateOfBirth() != null ? lawyer.getDateOfBirth() : "");
            lawyerJson.put("profileImage", lawyer.getProfileImage() != null ? lawyer.getProfileImage() : "");
            json.put("lawyer", lawyerJson);
        }
        out.print(json.toString());
        out.flush();
    }
}
