package controller.admin;

import dao.AppointmentDAO;
import model.Appointment;
import util.DBConnectionUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Servlet to handle cancellation of appointments
 */
@WebServlet("/admin/cancel-appointment")
public class CancelAppointmentServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(CancelAppointmentServlet.class.getName());

    /**
     * Handles POST requests to cancel an appointment
     * @param request  HttpServletRequest containing appointmentId parameter
     * @param response HttpServletResponse to send status
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Parse appointmentId from request
            String appointmentIdStr = request.getParameter("appointmentId");
            if (appointmentIdStr == null || appointmentIdStr.trim().isEmpty()) {
                LOGGER.log(Level.WARNING, "Missing appointmentId parameter");
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing appointmentId");
                return;
            }

            int appointmentId;
            try {
                appointmentId = Integer.parseInt(appointmentIdStr);
            } catch (NumberFormatException e) {
                LOGGER.log(Level.WARNING, "Invalid appointmentId format: {0}", appointmentIdStr);
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid appointmentId format");
                return;
            }

            // Initialize DAO
            AppointmentDAO appointmentDAO = new AppointmentDAO();

            // Verify appointment exists and is cancellable
            Appointment appointment = appointmentDAO.getAppointmentById(appointmentId);
            if (appointment == null) {
                LOGGER.log(Level.WARNING, "Appointment not found: {0}", appointmentId);
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Appointment not found");
                return;
            }

            if ("CANCELLED".equals(appointment.getStatus()) || "COMPLETED".equals(appointment.getStatus())) {
                LOGGER.log(Level.WARNING, "Appointment cannot be cancelled, status: {0}", appointment.getStatus());
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Appointment cannot be cancelled");
                return;
            }

            // Update appointment status to CANCELLED
            boolean success = appointmentDAO.updateAppointmentStatus(appointmentId, "CANCELLED");
            if (success) {
                LOGGER.log(Level.INFO, "Appointment cancelled successfully: {0}", appointmentId);
                response.setStatus(HttpServletResponse.SC_OK);
            } else {
                LOGGER.log(Level.SEVERE, "Failed to cancel appointment: {0}", appointmentId);
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to cancel appointment");
            }
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Unexpected error while cancelling appointment", e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Unexpected error");
        }
    }
}