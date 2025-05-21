package controller;

import dao.AppointmentDAO;
import dao.ReviewDAO;
import model.Appointment;
import model.Review;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;

import com.google.gson.Gson;

@WebServlet("/client/reviews")
public class ReviewsServlet extends HttpServlet {
    private ReviewDAO reviewDAO;
    private AppointmentDAO appointmentDAO;

    @Override
    public void init() throws ServletException {
        reviewDAO = new ReviewDAO();
        appointmentDAO = new AppointmentDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String lawyerIdStr = request.getParameter("lawyerId");
        String appointmentIdStr = request.getParameter("appointmentId");

        try {
            if (lawyerIdStr != null && !lawyerIdStr.isEmpty()) {
                // Handle AJAX request for reviews by lawyerId
                int lawyerId = Integer.parseInt(lawyerIdStr);
                List<Review> reviews = reviewDAO.getReviewsByLawyer(lawyerId);

                response.setContentType("application/json");
                PrintWriter out = response.getWriter();
                out.print(new Gson().toJson(reviews));
                out.flush();
            } else if (appointmentIdStr != null && !appointmentIdStr.isEmpty()) {
                // Handle request to display review form for a specific appointment
                int appointmentId = Integer.parseInt(appointmentIdStr);
                Appointment appointment = appointmentDAO.getAppointmentById(appointmentId);

                if (appointment == null) {
                    request.setAttribute("error", "Appointment not found.");
                    response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                    request.getRequestDispatcher("/WEB-INF/views/error/error.jsp").forward(request, response);
                    return;
                }

                // Fetch reviews for the lawyer associated with the appointment
                List<Review> reviews = reviewDAO.getReviewsByLawyer(appointment.getLawyerId());
                request.setAttribute("appointment", appointment);
                request.setAttribute("reviews", reviews);
                request.getRequestDispatcher("/WEB-INF/views/reviews.jsp").forward(request, response);
            } else {
                // Display recent reviews
                List<Review> reviews = reviewDAO.getRecentReviews(20);
                request.setAttribute("reviews", reviews);
                request.getRequestDispatcher("/WEB-INF/views/reviews.jsp").forward(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid lawyer or appointment ID.");
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            request.getRequestDispatcher("/WEB-INF/views/error/error.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Failed to fetch data due to a database error.");
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            request.getRequestDispatcher("/WEB-INF/views/error/error.jsp").forward(request, response);
        }
    }
}