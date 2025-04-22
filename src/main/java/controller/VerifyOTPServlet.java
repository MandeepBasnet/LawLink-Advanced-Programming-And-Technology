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
 * Servlet to handle OTP verification
 */
@WebServlet("/verify-otp")
public class VerifyOTPServlet extends HttpServlet {

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

        HttpSession session = request.getSession(false);
        JSONObject jsonResponse = new JSONObject();

        if (session == null || session.getAttribute("otpUserId") == null) {
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Session expired. Please request a new OTP.");
            sendJsonResponse(response, jsonResponse);
            return;
        }

        String otp = request.getParameter("otp");
        if (otp == null || otp.trim().isEmpty()) {
            jsonResponse.put("success", false);
            jsonResponse.put("message", "OTP is required");
            sendJsonResponse(response, jsonResponse);
            return;
        }

        int userId = (int) session.getAttribute("otpUserId");
        boolean otpVerified = userDAO.verifyOTP(userId, otp);

        if (otpVerified) {
            // Generate reset token for password reset
            String resetToken = generateResetToken();
            if (userDAO.setResetToken(userId, resetToken, 1)) { // 1 hour expiry
                jsonResponse.put("success", true);
                jsonResponse.put("resetToken", resetToken);
                jsonResponse.put("message", "OTP verified successfully");
            } else {
                jsonResponse.put("success", false);
                jsonResponse.put("message", "Failed to generate reset token");
            }
        } else {
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Invalid OTP");
        }

        sendJsonResponse(response, jsonResponse);
    }

    private void sendJsonResponse(HttpServletResponse response, JSONObject jsonResponse) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsonResponse.toString());
    }

    private String generateResetToken() {
        return java.util.UUID.randomUUID().toString();
    }
}
