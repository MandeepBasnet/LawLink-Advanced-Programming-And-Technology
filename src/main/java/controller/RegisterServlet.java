package controller;

import dao.UserDAO;
import dao.ClientDAO;
import model.User;
import model.Client;
import util.ValidationUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Servlet to handle user registration
 */
@WebServlet("/register")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024, // 1MB
        maxFileSize = 1024 * 1024 * 5,  // 5MB
        maxRequestSize = 1024 * 1024 * 10 // 10MB
)
public class RegisterServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(RegisterServlet.class.getName());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        LOGGER.info("Processing GET request for /register");
        request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        LOGGER.info("Processing POST request for /register");

        // Check content type
        String contentType = request.getContentType();
        if (contentType == null || !contentType.toLowerCase().contains("multipart/form-data")) {
            LOGGER.warning("Invalid content type: " + contentType);
            request.setAttribute("error", "Form must be submitted with file upload support.");
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            return;
        }

        String username = ValidationUtil.sanitizeInput(request.getParameter("userName"));
        String email = ValidationUtil.sanitizeInput(request.getParameter("email"));
        String fullName = ValidationUtil.sanitizeInput(request.getParameter("fullName"));
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String dateOfBirth = ValidationUtil.sanitizeInput(request.getParameter("dateOfBirth"));
        String gender = ValidationUtil.sanitizeInput(request.getParameter("gender"));
        Part profilePicturePart = null;

        try {
            profilePicturePart = request.getPart("profilePicture");
        } catch (IllegalStateException e) {
            LOGGER.log(Level.SEVERE, "File size exceeds configured limits", e);
            request.setAttribute("error", "Profile picture is too large. Maximum size is 5MB.");
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            return;
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "Error retrieving profile picture part", e);
            // Continue without profile picture
        }

        // Validate required fields
        if (ValidationUtil.isEmpty(username) || ValidationUtil.isEmpty(email) ||
                ValidationUtil.isEmpty(fullName) || ValidationUtil.isEmpty(password) ||
                ValidationUtil.isEmpty(confirmPassword)) {
            LOGGER.warning("Validation failed: Missing required fields");
            request.setAttribute("error", "All fields are required.");
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            return;
        }

        // Validate password match
        if (!password.equals(confirmPassword)) {
            LOGGER.warning("Validation failed: Passwords do not match");
            request.setAttribute("error", "Passwords do not match.");
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            return;
        }

        // Validate gender (if provided, must match ENUM values)
        if (!ValidationUtil.isEmpty(gender) && !gender.matches("MALE|FEMALE|OTHER")) {
            LOGGER.warning("Validation failed: Invalid gender value: " + gender);
            request.setAttribute("error", "Invalid gender value.");
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            return;
        }

        UserDAO userDAO = null;
        ClientDAO clientDAO = null;
        try {
            userDAO = new UserDAO();
            clientDAO = new ClientDAO();

            // Check if email is already registered
            if (userDAO.getUserByEmail(email) != null) {
                LOGGER.warning("Validation failed: Email already registered: " + email);
                request.setAttribute("error", "Email already registered.");
                request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
                return;
            }

            // Create new user
            User newUser = new User(username, password, email, fullName, "CLIENT");
            if (!ValidationUtil.isEmpty(dateOfBirth)) {
                try {
                    newUser.setDateOfBirth(dateOfBirth);
                } catch (IllegalArgumentException e) {
                    LOGGER.warning("Invalid date format for dateOfBirth: " + dateOfBirth);
                    request.setAttribute("error", "Invalid date of birth format.");
                    request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
                    return;
                }
            }
            if (!ValidationUtil.isEmpty(gender)) {
                newUser.setGender(gender);
            }

            // Register user with profile picture
            boolean userSuccess = userDAO.registerUser(newUser, profilePicturePart, getServletContext());

            if (userSuccess) {
                // Create client object
                Client newClient = new Client(username, password, email, fullName);
                newClient.setUserId(newUser.getUserId()); // Set user ID from created user
                if (!ValidationUtil.isEmpty(gender)) {
                    newClient.setGender(gender); // Set gender if provided
                } else {
                    newClient.setGender(null); // Nullable in Clients table
                }

                // Register client
                boolean clientSuccess = clientDAO.registerClient(newClient);

                if (clientSuccess) {
                    LOGGER.info("User and client registered successfully: " + email);
                    response.sendRedirect(request.getContextPath() + "/home");
                } else {
                    LOGGER.warning("Client registration failed for user: " + email);
                    // Clean up user record if client registration fails
                    userDAO.deleteUser(newUser.getUserId());
                    request.setAttribute("error", "Registration failed. Try again.");
                    request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
                }
            } else {
                LOGGER.warning("User registration failed for user: " + email);
                request.setAttribute("error", "Registration failed. Try again.");
                request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Database error during registration", e);
            request.setAttribute("error", "Internal server error. Please try again later.");
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Unexpected error during registration", e);
            request.setAttribute("error", "Internal server error. Please try again later.");
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
        } finally {
            if (userDAO != null) {
                userDAO.close();
            }
        }
    }
}