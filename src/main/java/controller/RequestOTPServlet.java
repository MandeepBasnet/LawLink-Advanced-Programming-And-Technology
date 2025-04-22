package controller;

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
import org.json.JSONObject;

/**
 * Servlet to handle OTP requests
 */
@WebServlet("/request-otp")
public class RequestOTPServlet extends HttpServlet {

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
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        JSONObject jsonResponse = new JSONObject();

        if (email == null || email.trim().isEmpty()) {
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Email is required");
            sendJsonResponse(response, jsonResponse);
            return;
        }

        boolean otpRequested = userDAO.requestOTP(email);
        if (otpRequested) {
            // Get user details for session
            User user = userDAO.getUserByEmail(email);
            if (user != null) {
                // Store user ID in session for OTP verification
                HttpSession session = request.getSession(true);
                session.setAttribute("otpUserId", user.getUserId());
                session.setMaxInactiveInterval(30 * 60); // 30 minutes
            }

            jsonResponse.put("success", true);
            jsonResponse.put("message", "OTP has been sent to your email");
        } else {
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Failed to send OTP. Please try again.");
        }

        sendJsonResponse(response, jsonResponse);
    }

    private void sendJsonResponse(HttpServletResponse response, JSONObject jsonResponse) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsonResponse.toString());
    }
}
