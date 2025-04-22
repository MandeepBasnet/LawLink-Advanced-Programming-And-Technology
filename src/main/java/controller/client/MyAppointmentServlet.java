package controller.client;

import dao.AppointmentDAO;
import model.Appointment;
import model.User;
import util.SessionUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/client/my-appointments")
public class MyAppointmentServlet extends HttpServlet {
    private AppointmentDAO appointmentDAO = new AppointmentDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = SessionUtil.getLoggedInUser(request);

        if (user == null || !"CLIENT".equals(user.getRole())) {
            request.getRequestDispatcher("/WEB-INF/views/error/access-denied.jsp").forward(request, response);
            return;
        }

        try {
            List<Appointment> appointments = appointmentDAO.getAppointmentsByClient(user.getUserId());
            request.setAttribute("appointments", appointments);
            request.getRequestDispatcher("/WEB-INF/views/client/MyAppointments.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Unable to load your appointments.");
            request.getRequestDispatcher("/WEB-INF/views/client/MyAppointments.jsp").forward(request, response);
        }
    }
}