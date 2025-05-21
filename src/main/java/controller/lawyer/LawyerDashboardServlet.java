package controller.lawyer;

import model.Appointment;
import model.Lawyer;
import model.Review;
import model.User;
import dao.AppointmentDAO;
import dao.LawyerDAO;
import dao.ReviewDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.HashMap;
import java.util.Map;
import java.time.LocalDate;
import java.time.ZoneId;

@WebServlet("/lawyer/lawyer-dashboard")
public class LawyerDashboardServlet extends HttpServlet {
    private AppointmentDAO appointmentDAO = new AppointmentDAO();
    private LawyerDAO lawyerDAO = new LawyerDAO();
    private ReviewDAO reviewDAO = new ReviewDAO();

    public LawyerDashboardServlet() throws SQLException {
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("user") : null;

        if (currentUser == null || !"LAWYER".equals(currentUser.getRole())) {
            response.sendRedirect(request.getContextPath() + "/WEB-INF/views/error/access-denied.jsp");
            return;
        }

        try {
            // Fetch lawyer details
            Lawyer lawyer = lawyerDAO.getLawyerById(currentUser.getUserId());
            // Fetch all appointments for the lawyer
            List<Appointment> appointments = appointmentDAO.getAppointmentsByLawyer(currentUser.getUserId());
            // Filter today's appointments
            LocalDate today = LocalDate.now(ZoneId.of("+05:45"));
            long todayAppointmentsCount = appointments.stream()
                    .filter(a -> a.getAppointmentDate() != null && a.getAppointmentDate().toLocalDate().equals(today))
                    .count();

            // Fetch reviews for completed appointments
            Map<Integer, Review> reviewMap = new HashMap<>();
            for (Appointment appointment : appointments) {
                if ("COMPLETED".equals(appointment.getStatus())) {
                    Review review = reviewDAO.getReviewByAppointmentId(appointment.getAppointmentId());
                    if (review != null) {
                        reviewMap.put(appointment.getAppointmentId(), review);
                    }
                }
            }

            // Set attributes
            request.setAttribute("lawyer", lawyer);
            request.setAttribute("appointments", appointments);
            request.setAttribute("todayAppointmentsCount", todayAppointmentsCount);
            request.setAttribute("reviewMap", reviewMap);
            request.setAttribute("currentDate", today); // Pass the current date for JSP comparison
            request.getRequestDispatcher("/WEB-INF/views/lawyer/lawyerDashboard.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/WEB-INF/views/error/error.jsp");
        }
    }
}