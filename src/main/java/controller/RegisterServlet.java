package controller;

import dao.UserDAO;
import model.User;
import util.PasswordUtil;
import util.ValidationUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.UUID;


/**
 * Servlet to handle user registration
 */
@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = ValidationUtil.sanitizeInput(request.getParameter("userName")); // ✅ corrected
        String email = ValidationUtil.sanitizeInput(request.getParameter("email"));
        String fullName = ValidationUtil.sanitizeInput(request.getParameter("fullName"));
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        if (ValidationUtil.isEmpty(username) || ValidationUtil.isEmpty(email) ||
                ValidationUtil.isEmpty(fullName) || ValidationUtil.isEmpty(password) ||
                ValidationUtil.isEmpty(confirmPassword)) {
            request.setAttribute("error", "All fields are required.");
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            return;
        }

        if (!password.equals(confirmPassword)) { // ✅ check if password matches
            request.setAttribute("error", "Passwords do not match.");
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            return;
        }

        try {
            UserDAO userDAO = new UserDAO();
            if (userDAO.getUserByEmail(email) != null) {
                request.setAttribute("error", "Email already registered.");
                request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
                return;
            }

            String hashedPassword = PasswordUtil.hashPassword(password);
            User newUser = new User(username, hashedPassword, email, fullName, "CLIENT");
            boolean success = userDAO.registerUser(newUser);

            if (success) {
                // ✅ Redirect to Home after successful registration
                response.sendRedirect(request.getContextPath() + "/home");
            } else {
                request.setAttribute("error", "Registration failed. Try again.");
                request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Internal server error.");
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
        }
    }
}