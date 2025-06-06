package controller.client;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import model.User;
import util.SessionUtil;
import util.ValidationUtil;
import org.json.JSONObject;

import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.SQLException;
import java.util.UUID;
import java.util.logging.Logger;

/**
 * Servlet for handling client profile operations
 */
@WebServlet(name = "ClientProfileServlet", urlPatterns = {"/client/my-profile"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10,      // 10MB
        maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class ClientProfileServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(ClientProfileServlet.class.getName());
    private static final String UPLOAD_DIR = "uploads/users";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || SessionUtil.getLoggedInUser(request) == null) {
            response.sendRedirect(request.getContextPath() + "/log-in");
            return;
        }

        User sessionUser = SessionUtil.getLoggedInUser(request);
        UserDAO userDAO = null;
        try {
            userDAO = new UserDAO();
            User user = userDAO.getUserById(sessionUser.getUserId());
            if (user == null) {
                request.setAttribute("errorMessage", "User not found.");
                response.sendRedirect(request.getContextPath() + "/log-in");
                return;
            }
            request.setAttribute("user", user);
            request.getRequestDispatcher("/WEB-INF/views/client/MyProfile.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Database error occurred while fetching profile.");
            request.getRequestDispatcher("/WEB-INF/views/client/MyProfile.jsp").forward(request, response);
        } finally {
            if (userDAO != null) {
                userDAO.close();
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        LOGGER.info("X-Requested-With header: " + request.getHeader("X-Requested-With"));
        HttpSession session = request.getSession(false);
        if (session == null || SessionUtil.getLoggedInUser(request) == null) {
            if ("XMLHttpRequest".equals(request.getHeader("X-Requested-With"))) {
                sendJsonResponse(response, false, "User not logged in.");
                return;
            }
            response.sendRedirect(request.getContextPath() + "/log-in");
            return;
        }

        User sessionUser = SessionUtil.getLoggedInUser(request);
        UserDAO userDAO = null;
        try {
            userDAO = new UserDAO();
            User user = userDAO.getUserById(sessionUser.getUserId());
            if (user == null) {
                if ("XMLHttpRequest".equals(request.getHeader("X-Requested-With"))) {
                    sendJsonResponse(response, false, "User not found.");
                    return;
                }
                request.setAttribute("errorMessage", "User not found.");
                response.sendRedirect(request.getContextPath() + "/log-in");
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

            // Debug: Log received parameters
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
                if ("XMLHttpRequest".equals(request.getHeader("X-Requested-With"))) {
                    sendJsonResponse(response, false, errorMessage.toString());
                    return;
                }
                request.setAttribute("errorMessage", errorMessage.toString());
                request.setAttribute("user", user);
                request.getRequestDispatcher("/WEB-INF/views/client/MyProfile.jsp").forward(request, response);
                return;
            }

            // Handle profile picture
            String oldProfileImage = user.getProfileImage();
            String newProfileImage = oldProfileImage;
            LOGGER.info("Old profile image: " + oldProfileImage);
            if (profilePicturePart != null && profilePicturePart.getSize() > 0) {
                // Validate file type
                String contentType = profilePicturePart.getContentType();
                if (!contentType.equals("image/jpeg") && !contentType.equals("image/png")) {
                    if ("XMLHttpRequest".equals(request.getHeader("X-Requested-With"))) {
                        sendJsonResponse(response, false, "Only JPEG or PNG images are allowed.");
                        return;
                    }
                    request.setAttribute("errorMessage", "Only JPEG or PNG images are allowed.");
                    request.setAttribute("user", user);
                    request.getRequestDispatcher("/WEB-INF/views/client/MyProfile.jsp").forward(request, response);
                    return;
                }

                // Generate unique filename
                String fileName = getSubmittedFileName(profilePicturePart);
                if (fileName != null && !fileName.isEmpty()) {
                    String extension = fileName.substring(fileName.lastIndexOf("."));
                    String uniqueFileName = UUID.randomUUID().toString() + extension;
                    String uploadPath = getServletContext().getRealPath("") + java.io.File.separator + UPLOAD_DIR;
                    java.io.File uploadDir = new java.io.File(uploadPath);
                    if (!uploadDir.exists()) {
                        uploadDir.mkdirs();
                    }
                    try {
                        Files.copy(profilePicturePart.getInputStream(), Paths.get(uploadPath, uniqueFileName), StandardCopyOption.REPLACE_EXISTING);
                        newProfileImage = UPLOAD_DIR + "/" + uniqueFileName;
                        LOGGER.info("New profile image saved: " + newProfileImage);
                    } catch (IOException e) {
                        LOGGER.severe("Failed to save image: " + e.getMessage());
                        if ("XMLHttpRequest".equals(request.getHeader("X-Requested-With"))) {
                            sendJsonResponse(response, false, "Failed to upload image: " + e.getMessage());
                            return;
                        }
                        request.setAttribute("errorMessage", "Failed to upload image: " + e.getMessage());
                        request.setAttribute("user", user);
                        request.getRequestDispatcher("/WEB-INF/views/client/MyProfile.jsp").forward(request, response);
                        return;
                    }
                }
            }

            // Update user object
            user.setFullName(fullName);
            user.setEmail(email);
            user.setPhone(phone);
            user.setAddress(address);
            user.setGender(gender);
            user.setDateOfBirth(dateOfBirth);
            user.setProfileImage(newProfileImage);

            // Update profile in database
            boolean success = userDAO.updateUserProfile(user);
            if (success) {
                // Delete old profile image if a new one was uploaded
                if (profilePicturePart != null && profilePicturePart.getSize() > 0 && oldProfileImage != null) {
                    String uploadPath = getServletContext().getRealPath("") + java.io.File.separator + oldProfileImage;
                    try {
                        Files.deleteIfExists(Paths.get(uploadPath));
                        LOGGER.info("Old profile image deleted: " + oldProfileImage);
                    } catch (IOException e) {
                        LOGGER.warning("Failed to delete old profile image: " + oldProfileImage);
                    }
                }
                // Update session user
                session.setAttribute("user", user);
                if ("XMLHttpRequest".equals(request.getHeader("X-Requested-With"))) {
                    sendJsonResponse(response, true, "Profile updated successfully.", user);
                    return;
                }
                request.setAttribute("successMessage", "Profile updated successfully.");
            } else {
                // Clean up new profile image if update failed
                if (newProfileImage != null && !newProfileImage.equals(oldProfileImage)) {
                    String uploadPath = getServletContext().getRealPath("") + java.io.File.separator + newProfileImage;
                    try {
                        Files.deleteIfExists(Paths.get(uploadPath));
                        LOGGER.info("Cleaned up new profile image: " + newProfileImage);
                    } catch (IOException e) {
                        LOGGER.warning("Failed to clean up new profile image: " + newProfileImage);
                    }
                }
                if ("XMLHttpRequest".equals(request.getHeader("X-Requested-With"))) {
                    sendJsonResponse(response, false, "Failed to update profile.");
                    return;
                }
                request.setAttribute("errorMessage", "Failed to update profile.");
            }

            request.setAttribute("user", user);
            request.getRequestDispatcher("/WEB-INF/views/client/MyProfile.jsp").forward(request, response);
        } catch (SQLException e) {
            LOGGER.severe("Database error: " + e.getMessage());
            if ("XMLHttpRequest".equals(request.getHeader("X-Requested-With"))) {
                sendJsonResponse(response, false, "Database error occurred while updating profile.");
                return;
            }
            request.setAttribute("errorMessage", "Database error occurred while updating profile.");
            request.setAttribute("user", sessionUser);
            request.getRequestDispatcher("/WEB-INF/views/client/MyProfile.jsp").forward(request, response);
        } finally {
            if (userDAO != null) {
                userDAO.close();
            }
        }
    }

    private void sendJsonResponse(HttpServletResponse response, boolean success, String message) throws IOException {
        sendJsonResponse(response, success, message, null);
    }

    private void sendJsonResponse(HttpServletResponse response, boolean success, String message, User user) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        JSONObject json = new JSONObject();
        json.put("success", success);
        json.put("message", message);
        if (user != null) {
            JSONObject userJson = new JSONObject();
            userJson.put("fullName", user.getFullName());
            userJson.put("email", user.getEmail());
            userJson.put("phone", user.getPhone());
            userJson.put("address", user.getAddress());
            userJson.put("gender", user.getGender());
            userJson.put("dateOfBirth", user.getDateOfBirth() != null ? user.getDateOfBirth() : "");
            userJson.put("profileImage", user.getProfileImage() != null ? user.getProfileImage() : "");
            json.put("user", userJson);
        }
        out.print(json.toString());
        out.flush();
    }

    private String getSubmittedFileName(Part part) {
        for (String content : part.getHeader("content-disposition").split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(content.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }
}