package controller.admin;

import dao.AppointmentDAO;
import dao.ClientDAO;
import dao.LawyerDAO;
import dao.UserDAO;
import model.Client;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/admin/admin-clients")
public class AdminClientsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            ClientDAO clientDAO = new ClientDAO();
            LawyerDAO lawyerDAO = new LawyerDAO();
            AppointmentDAO appointmentDAO = new AppointmentDAO();

            int clientCount = clientDAO.getAllClients().size();
            int lawyerCount = lawyerDAO.getAllLawyers().size();
            int appointmentCount = appointmentDAO.getAllAppointments().size();
            List<Client> clients = clientDAO.getAllClients();
            request.setAttribute("clients", clients);
            request.setAttribute("clientCount", clientCount);
            request.setAttribute("lawyerCount", lawyerCount);
            request.setAttribute("appointmentCount", appointmentCount);
            request.getRequestDispatcher("/WEB-INF/views/admin/adminDashboardClients.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
        }
    }
}

