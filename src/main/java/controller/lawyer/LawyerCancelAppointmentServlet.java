package controller.lawyer;

import model.Appointment;
import model.User;
import util.SessionUtil;
import dao.AppointmentDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Calendar;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Servlet to handle cancellation of appointments by lawyers
 */
@WebServlet("/lawyer/cancel-appointment")
public class LawyerCancelAppointmentServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(LawyerCancelAppointmentServlet.class.getName());
    private AppointmentDAO appointmentDAO;

    @Override
    public void init() throws ServletException {
        try {
            appointmentDAO = new AppointmentDAO();
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Failed to initialize AppointmentDAO", e);
            throw new ServletException("Failed to initialize AppointmentDAO", e);
        }
    }

    /**
     * Handles POST requests to cancel an appointment
     * @param request  HttpServletRequest containing appointmentId and csrfToken parameters
     * @param response HttpServletResponse to send status
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = SessionUtil.getLoggedInUser(request);

        // Check authentication and role
        if (session == null || user == null || !"LAWYER".equals(user.getRole())) {
            LOGGER.log(Level.WARNING, "Unauthorized access attempt");
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Unauthorized: Please log in as a lawyer.");
            return;
        }

        try {
            // Validate CSRF token
            String requestCsrfToken = request.getParameter("csrfToken");
            String sessionCsrfToken = (String) session.getAttribute("csrfToken");
            if (requestCsrfToken == null || !requestCsrfToken.equals(sessionCsrfToken)) {
                LOGGER.log(Level.WARNING, "Invalid CSRF token for user: {0}", user.getEmail());
                session.setAttribute("error", "Invalid session. Please log in again.");
                response.sendError(HttpServletResponse.SC_FORBIDDEN, "Invalid CSRF token. Please log in again.");
                return;
            }

            // Parse appointmentId
            String appointmentIdStr = request.getParameter("appointmentId");
            if (appointmentIdStr == null || appointmentIdStr.trim().isEmpty()) {
                LOGGER.log(Level.WARNING, "Missing appointmentId parameter for user: {0}", user.getEmail());
                session.setAttribute("error", "Invalid appointment ID.");
                response.sendRedirect(request.getContextPath() + "/lawyer/lawyer-dashboard");
                return;
            }

            int appointmentId;
            try {
                appointmentId = Integer.parseInt(appointmentIdStr);
            } catch (NumberFormatException e) {
                LOGGER.log(Level.WARNING, "Invalid appointmentId format: {0} for user: {1}", new Object[]{appointmentIdStr, user.getEmail()});
                session.setAttribute("error", "Invalid appointment ID format.");
                response.sendRedirect(request.getContextPath() + "/lawyer/lawyer-dashboard");
                return;
            }

            // Fetch appointment
            Appointment appointment = appointmentDAO.getAppointmentById(appointmentId);
            if (appointment == null) {
                LOGGER.log(Level.WARNING, "Appointment not found: {0} for user: {1}", new Object[]{appointmentId, user.getEmail()});
                session.setAttribute("error", "Appointment not found.");
                response.sendRedirect(request.getContextPath() + "/lawyer/lawyer-dashboard");
                return;
            }

            // Verify ownership
            if (appointment.getLawyerId() != user.getUserId()) {
                LOGGER.log(Level.WARNING, "User ID {0} attempted to cancel appointment ID {1} not owned by them", new Object[]{user.getUserId(), appointmentId});
                session.setAttribute("error", "You are not authorized to cancel this appointment.");
                response.sendRedirect(request.getContextPath() + "/lawyer/lawyer-dashboard");
                return;
            }

            // Check status
            if (!"PENDING".equals(appointment.getStatus()) && !"CONFIRMED".equals(appointment.getStatus())) {
                LOGGER.log(Level.WARNING, "Cannot cancel appointment ID {0} with status: {1} for user: {2}", new Object[]{appointmentId, appointment.getStatus(), user.getEmail()});
                session.setAttribute("error", "This appointment cannot be cancelled as it is already " + appointment.getStatus().toLowerCase() + ".");
                response.sendRedirect(request.getContextPath() + "/lawyer/lawyer-dashboard");
                return;
            }

            // Check if appointment is within 24 hours
            java.sql.Date apptDate = appointment.getAppointmentDate();
            java.sql.Time apptTime = appointment.getAppointmentTime();
            Calendar apptDateTime = Calendar.getInstance();
            apptDateTime.setTimeInMillis(apptDate.getTime());
            apptDateTime.set(Calendar.HOUR_OF_DAY, apptTime.getHours());
            apptDateTime.set(Calendar.MINUTE, apptTime.getMinutes());
            apptDateTime.set(Calendar.SECOND, 0);

            Calendar now = Calendar.getInstance();
            long hoursUntilAppt = (apptDateTime.getTimeInMillis() - now.getTimeInMillis()) / (1000 * 60 * 60);
            if (hoursUntilAppt < 24) {
                LOGGER.log(Level.INFO, "Cannot cancel appointment ID {0} within 24 hours of scheduled time for user: {1}", new Object[]{appointmentId, user.getEmail()});
                session.setAttribute("error", "Appointments cannot be cancelled within 24 hours of the scheduled time.");
                response.sendRedirect(request.getContextPath() + "/lawyer/lawyer-dashboard");
                return;
            }

            // Cancel appointment
            boolean success = appointmentDAO.updateAppointmentStatus(appointmentId, "CANCELLED");
            if (success) {
                LOGGER.log(Level.INFO, "Appointment ID {0} cancelled successfully by user ID {1}", new Object[]{appointmentId, user.getUserId()});
                session.setAttribute("success", "Appointment cancelled successfully.");
            } else {
                LOGGER.log(Level.SEVERE, "Failed to cancel appointment: {0} for user: {1}", new Object[]{appointmentId, user.getEmail()});
                session.setAttribute("error", "Failed to cancel appointment due to a server error.");
            }

            response.sendRedirect(request.getContextPath() + "/lawyer/lawyer-dashboard");

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Unexpected error while cancelling appointment for user: {0}", user.getEmail());
            session.setAttribute("error", "An error occurred while cancelling the appointment.");
            response.sendRedirect(request.getContextPath() + "/lawyer/lawyer-dashboard");
        }
    }
}