package controller.admin;

import dao.ClientDAO;
import dao.AppointmentDAO;
import dao.LawyerDAO;
import model.Lawyer;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/admin/admin-lawyers")
public class AdminLawyersServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            ClientDAO clientDAO = new ClientDAO();
            LawyerDAO lawyerDAO = new LawyerDAO();
            AppointmentDAO appointmentDAO = new AppointmentDAO();

            int clientCount = clientDAO.getAllClients().size();
            int lawyerCount = lawyerDAO.getAllLawyers().size();
            int appointmentCount = appointmentDAO.getAllAppointments().size();
            List<Lawyer> lawyers = lawyerDAO.getAllLawyers();

            request.setAttribute("clientCount", clientCount);
            request.setAttribute("lawyerCount", lawyerCount);
            request.setAttribute("appointmentCount", appointmentCount);
            request.setAttribute("lawyers", lawyers);

            request.getRequestDispatcher("/WEB-INF/views/admin/adminDashboardLawyers.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
        }
    }
}