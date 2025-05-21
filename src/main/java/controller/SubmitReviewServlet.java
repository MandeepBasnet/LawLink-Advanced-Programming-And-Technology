package controller;

import dao.AppointmentDAO;
import dao.ReviewDAO;
import model.Appointment;
import model.Review;
import model.User;
import util.SessionUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/client/submitReview")
public class SubmitReviewServlet extends HttpServlet {
    private ReviewDAO reviewDAO;
    private AppointmentDAO appointmentDAO;

    @Override
    public void init() throws ServletException {
        reviewDAO = new ReviewDAO();
        appointmentDAO = new AppointmentDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = SessionUtil.getLoggedInUser(request);

        if (user == null || !"CLIENT".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/log-in");
            return;
        }

        try {
            int appointmentId = Integer.parseInt(request.getParameter("appointmentId"));
            int rating = Integer.parseInt(request.getParameter("rating"));
            String comment = request.getParameter("comment");
            String csrfToken = request.getParameter("csrfToken");


            // Validate rating
            if (rating < 1 || rating > 5) {
                request.getSession().setAttribute("error", "Rating must be between 1 and 5.");
                response.sendRedirect(request.getContextPath() + "/client/my-appointments");
                return;
            }

            // Check if appointment belongs to the user
            Appointment appointment = appointmentDAO.getAppointmentById(appointmentId);
            if (appointment == null || appointment.getClientId() != user.getUserId()) {
                request.getSession().setAttribute("error", "You are not authorized to review this appointment.");
                response.sendRedirect(request.getContextPath() + "/client/my-appointments");
                return;
            }

            // Check if a review already exists for this appointment
            if (reviewDAO.getReviewByAppointmentId(appointmentId) != null) {
                request.getSession().setAttribute("error", "A review has already been submitted for this appointment.");
                response.sendRedirect(request.getContextPath() + "/client/my-appointments");
                return;
            }

            Review review = new Review();
            review.setAppointmentId(appointmentId);
            review.setRating(rating);
            review.setComment(comment);

            boolean success = reviewDAO.createReview(review);

            if (success) {
                request.getSession().setAttribute("success", "Review submitted successfully!");
            } else {
                request.getSession().setAttribute("error", "Failed to submit review.");
            }
            response.sendRedirect(request.getContextPath() + "/client/my-appointments");
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("error", "Invalid rating or appointment ID.");
            response.sendRedirect(request.getContextPath() + "/client/my-appointments");
        } catch (SQLException e) {
            e.printStackTrace();
            request.getSession().setAttribute("error", "Failed to submit review due to a database error.");
            response.sendRedirect(request.getContextPath() + "/client/my-appointments");
        }
    }
}