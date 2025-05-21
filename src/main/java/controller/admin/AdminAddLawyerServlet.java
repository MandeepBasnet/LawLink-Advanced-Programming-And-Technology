package controller.admin;

import dao.LawyerDAO;
import model.Lawyer;
import util.PasswordUtil;
import util.StringUtil;
import util.ValidationUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.SQLException;
import java.util.UUID;
import java.util.logging.Logger;
import java.math.BigDecimal;

@WebServlet("/admin/admin-add-lawyer")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10,      // 10MB
        maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class AdminAddLawyerServlet extends HttpServlet {
    private static final Logger logger = Logger.getLogger(AdminAddLawyerServlet.class.getName());
    private LawyerDAO lawyerDAO;
    private static final String UPLOAD_DIR = "uploads/users";

    @Override
    public void init() throws ServletException {
        try {
            lawyerDAO = new LawyerDAO();
        } catch (SQLException e) {
            logger.severe("Failed to initialize LawyerDAO: " + e.getMessage());
            throw new ServletException("Failed to initialize LawyerDAO", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Retrieve and sanitize form parameters
            String username = ValidationUtil.sanitizeInput(StringUtil.safeString(request.getParameter("username")));
            String email = ValidationUtil.sanitizeInput(StringUtil.safeString(request.getParameter("email")));
            String fullName = ValidationUtil.sanitizeInput(StringUtil.safeString(request.getParameter("fullName")));
            String password = StringUtil.safeString(request.getParameter("password"));
            String specialization = ValidationUtil.sanitizeInput(StringUtil.safeString(request.getParameter("specialization")));
            String practiceAreas = ValidationUtil.sanitizeInput(StringUtil.safeString(request.getParameter("practiceAreas")));
            String education = ValidationUtil.sanitizeInput(StringUtil.safeString(request.getParameter("education")));
            String licenseNumber = ValidationUtil.sanitizeInput(StringUtil.safeString(request.getParameter("licenseNumber")));
            String consultationFeeStr = StringUtil.safeString(request.getParameter("consultationFee"));
            String experienceStr = StringUtil.safeString(request.getParameter("experience"));
            String phone = ValidationUtil.sanitizeInput(StringUtil.safeString(request.getParameter("phone")));
            String address = ValidationUtil.sanitizeInput(StringUtil.safeString(request.getParameter("address")));
            String aboutMe = ValidationUtil.sanitizeInput(StringUtil.safeString(request.getParameter("aboutMe")));
            Part lawyerImagePart = request.getPart("lawyerImage");

            // Validations
            if (ValidationUtil.isEmpty(username) || ValidationUtil.isEmpty(email) || ValidationUtil.isEmpty(fullName) ||
                    ValidationUtil.isEmpty(password) || ValidationUtil.isEmpty(specialization) || ValidationUtil.isEmpty(practiceAreas) ||
                    ValidationUtil.isEmpty(education) || ValidationUtil.isEmpty(licenseNumber) || ValidationUtil.isEmpty(consultationFeeStr) ||
                    ValidationUtil.isEmpty(experienceStr) || ValidationUtil.isEmpty(phone)) {
                request.setAttribute("error", "All required fields must be filled.");
                request.getRequestDispatcher("/WEB-INF/views/admin/adminAddLawyers.jsp").forward(request, response);
                return;
            }

            if (!ValidationUtil.isValidEmail(email)) {
                request.setAttribute("error", "Invalid email format.");
                request.getRequestDispatcher("/WEB-INF/views/admin/adminAddLawyers.jsp").forward(request, response);
                return;
            }

            if (!ValidationUtil.isValidPhone(phone)) {
                request.setAttribute("error", "Invalid phone number format.");
                request.getRequestDispatcher("/WEB-INF/views/admin/adminAddLawyers.jsp").forward(request, response);
                return;
            }

            if (!ValidationUtil.isValidPassword(password)) {
                request.setAttribute("error", "Password must be at least 8 characters long and contain at least one digit and one letter.");
                request.getRequestDispatcher("/WEB-INF/views/admin/adminAddLawyers.jsp").forward(request, response);
                return;
            }

            BigDecimal consultationFee;
            try {
                consultationFee = new BigDecimal(consultationFeeStr);
                if (consultationFee.compareTo(BigDecimal.ZERO) <= 0) {
                    request.setAttribute("error", "Consultation fee must be greater than zero.");
                    request.getRequestDispatcher("/WEB-INF/views/admin/adminAddLawyers.jsp").forward(request, response);
                    return;
                }
            } catch (NumberFormatException e) {
                logger.warning("Invalid consultation fee format: " + consultationFeeStr);
                request.setAttribute("error", "Invalid consultation fee format.");
                request.getRequestDispatcher("/WEB-INF/views/admin/adminAddLawyers.jsp").forward(request, response);
                return;
            }

            int experienceYears;
            try {
                experienceYears = Integer.parseInt(experienceStr);
            } catch (NumberFormatException e) {
                logger.warning("Invalid experience format: " + experienceStr);
                request.setAttribute("error", "Invalid experience format.");
                request.getRequestDispatcher("/WEB-INF/views/admin/adminAddLawyers.jsp").forward(request, response);
                return;
            }

            // Handle file upload
            String profileImage = null;
            if (lawyerImagePart != null && lawyerImagePart.getSize() > 0) {
                String contentType = lawyerImagePart.getContentType();
                if (!contentType.equals("image/jpeg") && !contentType.equals("image/png")) {
                    logger.warning("Invalid file type: " + contentType);
                    request.setAttribute("error", "Only JPEG or PNG images are allowed.");
                    request.getRequestDispatcher("/WEB-INF/views/admin/adminAddLawyers.jsp").forward(request, response);
                    return;
                }

                String fileName = getSubmittedFileName(lawyerImagePart);
                if (fileName != null && !fileName.isEmpty()) {
                    String extension = fileName.substring(fileName.lastIndexOf("."));
                    String uniqueFileName = UUID.randomUUID().toString() + extension;
                    String uploadPath = getServletContext().getRealPath("") + java.io.File.separator + UPLOAD_DIR;
                    java.io.File uploadDir = new java.io.File(uploadPath);
                    if (!uploadDir.exists()) {
                        uploadDir.mkdirs();
                    }
                    try {
                        Files.copy(lawyerImagePart.getInputStream(), Paths.get(uploadPath, uniqueFileName), StandardCopyOption.REPLACE_EXISTING);
                        profileImage = UPLOAD_DIR + "/" + uniqueFileName;
                        logger.info("New profile image saved: " + profileImage);
                    } catch (IOException e) {
                        logger.severe("Failed to save image: " + e.getMessage());
                        request.setAttribute("error", "Failed to upload lawyer image.");
                        request.getRequestDispatcher("/WEB-INF/views/admin/adminAddLawyers.jsp").forward(request, response);
                        return;
                    }
                }
            }

            String hashedPassword = PasswordUtil.hashPassword(password);

            Lawyer lawyer = new Lawyer();
            lawyer.setUsername(username);
            lawyer.setEmail(email);
            lawyer.setFullName(fullName);
            lawyer.setPassword(hashedPassword);
            lawyer.setRole("LAWYER");
            lawyer.setSpecialization(specialization);
            lawyer.setPracticeAreas(practiceAreas);
            lawyer.setEducation(education);
            lawyer.setLicenseNumber(licenseNumber);
            lawyer.setConsultationFee(consultationFee);
            lawyer.setExperienceYears(experienceYears);
            lawyer.setPhone(phone);
            lawyer.setAddress(address);
            lawyer.setAboutMe(aboutMe);
            lawyer.setProfileImage(profileImage);
            lawyer.setVerified(true);
            lawyer.setAvailable(true);

            boolean created = lawyerDAO.createLawyer(lawyer);

            if (!created && profileImage != null) {
                String uploadPath = getServletContext().getRealPath("") + java.io.File.separator + profileImage;
                try {
                    Files.deleteIfExists(Paths.get(uploadPath));
                    logger.info("Cleaned up profile image: " + profileImage);
                } catch (IOException e) {
                    logger.warning("Failed to clean up profile image: " + profileImage);
                }
            }

            if (created) {
                request.getSession().setAttribute("successMessage", "Lawyer added successfully!");
                response.sendRedirect(request.getContextPath() + "/admin/admin-lawyers");
            } else {
                request.setAttribute("error", "Failed to add lawyer. Try again.");
                request.getRequestDispatcher("/WEB-INF/views/admin/adminAddLawyers.jsp").forward(request, response);
            }

        } catch (Exception e) {
            logger.severe("Unexpected error while adding lawyer: " + e.getMessage());
            request.setAttribute("error", "An unexpected error occurred. Please try again.");
            request.getRequestDispatcher("/WEB-INF/views/admin/adminAddLawyers.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/admin/adminAddLawyers.jsp").forward(request, response);
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