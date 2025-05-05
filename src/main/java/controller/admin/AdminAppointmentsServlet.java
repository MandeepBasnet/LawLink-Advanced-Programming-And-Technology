package controller.admin;

import dao.AppointmentDAO;
import dao.ClientDAO;
import dao.LawyerDAO;
import model.Appointment;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/admin/admin-appointments")
public class AdminAppointmentsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            ClientDAO clientDAO = new ClientDAO();
            LawyerDAO lawyerDAO = new LawyerDAO();
            AppointmentDAO appointmentDAO = new AppointmentDAO();

            int clientCount = clientDAO.getAllClients().size();
            int lawyerCount = lawyerDAO.getAllLawyers().size();
            int appointmentCount = appointmentDAO.getAllAppointments().size();
            List<Appointment> appointments = appointmentDAO.getAllAppointments();

            request.setAttribute("clientCount", clientCount);
            request.setAttribute("lawyerCount", lawyerCount);
            request.setAttribute("appointmentCount", appointmentCount);
            request.setAttribute("appointments", appointments);

            request.getRequestDispatcher("/WEB-INF/views/admin/adminAppointments.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
        }
    }
}