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

@WebServlet("/log-in")
public class LoginServlet extends HttpServlet {



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

        String email = request.getParameter("email").trim(); // 🔥 No sanitizeInput here
        String password = request.getParameter("password");

        if (ValidationUtil.isEmpty(email) || ValidationUtil.isEmpty(password)) {
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
                session.setMaxInactiveInterval(30 * 60);

                System.out.println("✅ Login successful for: " + user.getEmail() + " | Role: " + user.getRole());

                redirectToDashboard(request, response, user);
            } else {
                System.out.println("❌ Login failed: Invalid email or password for email: " + email);

                request.setAttribute("error", "Invalid email or password.");
                request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Internal server error. Please try again later.");
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
        }
    }


    private void redirectToDashboard(HttpServletRequest request, HttpServletResponse response, User user)
            throws IOException {

        String contextPath = request.getContextPath();
        String role = user.getRole();

        System.out.println("🚀 Redirecting user role: " + role);

        if ("ADMIN".equalsIgnoreCase(role)) {
            response.sendRedirect(contextPath + "/admin/admin-dashboard");
        } else if ("LAWYER".equalsIgnoreCase(role)) {
            response.sendRedirect(contextPath + "/lawyer/lawyer-dashboard");
        } else if ("CLIENT".equalsIgnoreCase(role)) {
            response.sendRedirect(contextPath + "/client/my-appointments");
        } else {
            // If role is somehow unknown, redirect safely to home
            response.sendRedirect(contextPath + "/home");
        }
    }

}
