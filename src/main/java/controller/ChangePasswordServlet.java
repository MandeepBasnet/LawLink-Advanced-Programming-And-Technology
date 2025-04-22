package controller;

import model.User;
import dao.UserDAO;
import util.PasswordUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;

/**
 * Servlet to handle change password requests
 */
@WebServlet("/change-password")
public class ChangePasswordServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        try {
            this.userDAO = new UserDAO();
        } catch (SQLException e) {
            throw new ServletException("Failed to initialize UserDAO", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Forward to the change password page
        request.getRequestDispatcher("/WEB-INF/views/change-password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        int userId = user.getUserId();

        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        // Validate input
        if (currentPassword == null || currentPassword.trim().isEmpty() ||
                newPassword == null || newPassword.trim().isEmpty() ||
                confirmPassword == null || confirmPassword.trim().isEmpty()) {

            request.setAttribute("error", "All fields are required");
            request.getRequestDispatcher("/WEB-INF/views/change-password.jsp").forward(request, response);
            return;
        }

        // Check if passwords match
        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match");
            request.getRequestDispatcher("/WEB-INF/views/change-password.jsp").forward(request, response);
            return;
        }

        try {
            // Get the user to verify current password
            User currentUser = userDAO.getUserById(userId);
            if (currentUser == null) {
                request.setAttribute("error", "User not found");
                request.getRequestDispatcher("/WEB-INF/views/change-password.jsp").forward(request, response);
                return;
            }

            // Verify current password
            if (!PasswordUtil.verifyPassword(currentPassword, currentUser.getPassword())) {
                request.setAttribute("error", "Current password is incorrect");
                request.getRequestDispatcher("/WEB-INF/views/change-password.jsp").forward(request, response);
                return;
            }

            // Hash and update the new password
            String hashedPassword = PasswordUtil.hashPassword(newPassword);
            currentUser.setPassword(hashedPassword);
            boolean changeSuccessful = userDAO.updateUser(currentUser);

            if (changeSuccessful) {
                // Password change successful, redirect to profile page with success message
                request.getSession().setAttribute("message", "Password changed successfully.");
                response.sendRedirect(request.getContextPath() + "/profile");
            } else {
                // Password change failed
                request.setAttribute("error", "Password change failed. Please try again.");
                request.getRequestDispatcher("/WEB-INF/views/change-password.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "An error occurred. Please try again.");
            request.getRequestDispatcher("/WEB-INF/views/change-password.jsp").forward(request, response);
        }
    }
}
