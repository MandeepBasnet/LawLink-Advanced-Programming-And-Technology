package controller.client;

import dao.AppointmentDAO;
import model.Appointment;
import model.User;
import util.SessionUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.Date;
import java.util.logging.Logger;
import java.util.logging.Level;

@WebServlet("/client/cancel-appointment")
public class CancelAppointmentServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(CancelAppointmentServlet.class.getName());
    private AppointmentDAO appointmentDAO;

    @Override
    public void init() throws ServletException {
        appointmentDAO = new AppointmentDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get logged-in user
        User user = SessionUtil.getLoggedInUser(request);
        if (user == null || !"CLIENT".equals(user.getRole())) {
            LOGGER.warning("Unauthorized access attempt to cancel appointment");
            request.setAttribute("error", "You must be logged in as a client to cancel appointments.");
            request.getRequestDispatcher("/WEB-INF/views/error/access-denied.jsp").forward(request, response);
            return;
        }

        HttpSession session = request.getSession();
        try {
            // Get appointment ID
            String appointmentIdStr = request.getParameter("appointmentId");
            if (appointmentIdStr == null || appointmentIdStr.trim().isEmpty()) {
                LOGGER.warning("Invalid appointment ID provided");
                session.setAttribute("error", "Invalid appointment ID.");
                response.sendRedirect(request.getContextPath() + "/client/my-appointments");
                return;
            }

            int appointmentId = Integer.parseInt(appointmentIdStr);
            LOGGER.info("Processing cancellation for appointment ID: " + appointmentId + " by user ID: " + user.getUserId());

            // Fetch appointment
            Appointment appointment = appointmentDAO.getAppointmentById(appointmentId);
            if (appointment == null) {
                LOGGER.warning("Appointment not found: " + appointmentId);
                session.setAttribute("error", "Appointment not found.");
                response.sendRedirect(request.getContextPath() + "/client/my-appointments");
                return;
            }

            // Verify ownership
            if (appointment.getClientId() != user.getUserId()) {
                LOGGER.warning("User ID " + user.getUserId() + " attempted to cancel appointment ID " + appointmentId + " not owned by them");
                session.setAttribute("error", "You are not authorized to cancel this appointment.");
                response.sendRedirect(request.getContextPath() + "/client/my-appointments");
                return;
            }

            // Check status
            if (!"PENDING".equals(appointment.getStatus()) && !"CONFIRMED".equals(appointment.getStatus())) {
                LOGGER.info("Cannot cancel appointment ID " + appointmentId + " with status: " + appointment.getStatus());
                session.setAttribute("error", "This appointment cannot be cancelled as it is already " + appointment.getStatus().toLowerCase() + ".");
                response.sendRedirect(request.getContextPath() + "/client/my-appointments");
                return;
            }

            // Check if appointment is within 24 hours
            java.sql.Date apptDate = appointment.getAppointmentDate();
            java.sql.Time apptTime = appointment.getAppointmentTime();
            java.util.Calendar apptDateTime = java.util.Calendar.getInstance();
            apptDateTime.setTimeInMillis(apptDate.getTime());
            apptDateTime.set(java.util.Calendar.HOUR_OF_DAY, apptTime.getHours());
            apptDateTime.set(java.util.Calendar.MINUTE, apptTime.getMinutes());
            apptDateTime.set(java.util.Calendar.SECOND, 0);

            java.util.Calendar now = java.util.Calendar.getInstance();
            long hoursUntilAppt = (apptDateTime.getTimeInMillis() - now.getTimeInMillis()) / (1000 * 60 * 60);
            if (hoursUntilAppt < 24) {
                LOGGER.info("Cannot cancel appointment ID " + appointmentId + " within 24 hours of scheduled time");
                session.setAttribute("error", "Appointments cannot be cancelled within 24 hours of the scheduled time.");
                response.sendRedirect(request.getContextPath() + "/client/my-appointments");
                return;
            }

            // Cancel appointment
            boolean success = appointmentDAO.updateAppointmentStatus(appointmentId, "CANCELLED");
            if (success) {
                LOGGER.info("Appointment ID " + appointmentId + " cancelled successfully by user ID " + user.getUserId());
                session.setAttribute("success", "Appointment cancelled successfully.");
            } else {
                LOGGER.severe("Failed to cancel appointment ID " + appointmentId);
                session.setAttribute("error", "Failed to cancel appointment.");
            }

            response.sendRedirect(request.getContextPath() + "/client/my-appointments");

        } catch (NumberFormatException e) {
            LOGGER.warning("Invalid appointment ID format: " + request.getParameter("appointmentId"));
            session.setAttribute("error", "Invalid appointment ID format.");
            response.sendRedirect(request.getContextPath() + "/client/my-appointments");
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error cancelling appointment", e);
            session.setAttribute("error", "An error occurred while cancelling the appointment.");
            response.sendRedirect(request.getContextPath() + "/client/my-appointments");
        }
    }
}