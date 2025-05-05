package controller.admin;

import dao.AppointmentDAO;
import dao.ClientDAO;
import dao.LawyerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Appointment;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/admin/admin-dashboard")
public class AdminDashboardServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            ClientDAO clientDAO = new ClientDAO();
            LawyerDAO lawyerDAO = new LawyerDAO();
            AppointmentDAO appointmentDAO = new AppointmentDAO();

            int clientCount = clientDAO.getAllClients().size();
            int lawyerCount = lawyerDAO.getAllLawyers().size();
            int appointmentCount = appointmentDAO.getAllAppointments().size();
            List<Appointment> recentAppointments = appointmentDAO.getRecentAppointments(5);

            request.setAttribute("clientCount", clientCount);
            request.setAttribute("lawyerCount", lawyerCount);
            request.setAttribute("appointmentCount", appointmentCount);
            request.setAttribute("recentAppointments", recentAppointments);

            request.getRequestDispatcher("/WEB-INF/views/admin/adminDashboard.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
        }
    }
}

