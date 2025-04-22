package controller.client;

import model.User;
import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;

/**
 * Servlet to handle user profile operations
 */
@WebServlet("/client/my-profile")
public class ProfileServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        try {
            userDAO = new UserDAO();
        } catch (SQLException e) {
            throw new ServletException("Failed to initialize UserDAO", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        request.setAttribute("user", user);
        request.getRequestDispatcher("/WEB-INF/views/client/profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User currentUser = (User) session.getAttribute("user");
        
        // Update user profile fields
        currentUser.setFullName(request.getParameter("fullName"));
        currentUser.setPhone(request.getParameter("phone"));
        currentUser.setAddress(request.getParameter("address"));
        
        // Handle profile image if needed
        String profileImage = request.getParameter("profileImage");
        if (profileImage != null && !profileImage.trim().isEmpty()) {
            currentUser.setProfileImage(profileImage);
        }

        boolean updated = userDAO.updateUserProfile(currentUser);
        if (updated) {
            session.setAttribute("user", currentUser); // Update session with new user data
            request.setAttribute("message", "Profile updated successfully");
        } else {
            request.setAttribute("error", "Failed to update profile");
        }

        request.getRequestDispatcher("/WEB-INF/views/client/profile.jsp").forward(request, response);
    }
}
