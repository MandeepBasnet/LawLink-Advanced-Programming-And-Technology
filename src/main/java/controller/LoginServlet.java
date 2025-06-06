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
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/log-in")
public class LoginServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(LoginServlet.class.getName());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            User user = (User) session.getAttribute("user");
            redirectToDashboard(request, response, user);
            return;
        }

        request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = ValidationUtil.sanitizeInput(request.getParameter("email"));
        String password = request.getParameter("password");

        if (ValidationUtil.isEmpty(email) || ValidationUtil.isEmpty(password)) {
            LOGGER.log(Level.WARNING, "Login failed: Missing email or password");
            request.setAttribute("error", "Email and password are required.");
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
            return;
        }

        try {
            UserDAO userDAO = new UserDAO();
            User user = userDAO.getUserByEmail(email);

            if (user != null && PasswordUtil.verifyPassword(password, user.getPassword())) {
                HttpSession session = request.getSession(true);
                session.setAttribute("user", user);
                // Generate and store CSRF token
                String csrfToken = UUID.randomUUID().toString();
                session.setAttribute("csrfToken", csrfToken);
                session.setMaxInactiveInterval(30 * 60);

                LOGGER.log(Level.INFO, "Login successful for: {0} | Role: {1}", new Object[]{user.getEmail(), user.getRole()});
                redirectToDashboard(request, response, user);
            } else {
                LOGGER.log(Level.WARNING, "Login failed: Invalid email or password for email: {0}", email);
                request.setAttribute("error", "Invalid email or password.");
                request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Database error during login", e);
            request.setAttribute("error", "Internal server error. Please try again later.");
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
        }
    }

    private void redirectToDashboard(HttpServletRequest request, HttpServletResponse response, User user)
            throws IOException {
        String contextPath = request.getContextPath();
        String role = user.getRole();

        LOGGER.log(Level.INFO, "Redirecting user role: {0}", role);

        if ("ADMIN".equalsIgnoreCase(role)) {
            response.sendRedirect(contextPath + "/admin/admin-dashboard");
        } else if ("LAWYER".equalsIgnoreCase(role)) {
            response.sendRedirect(contextPath + "/lawyer/lawyer-dashboard");
        } else if ("CLIENT".equalsIgnoreCase(role)) {
            response.sendRedirect(contextPath + "/client/my-appointments");
        } else {
            response.sendRedirect(contextPath + "/home");
        }
    }
}