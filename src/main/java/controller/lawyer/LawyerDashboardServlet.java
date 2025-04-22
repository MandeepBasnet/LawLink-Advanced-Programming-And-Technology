package controller.lawyer;

import dao.AppointmentDAO;
import model.Appointment;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/lawyer/lawyer-dashboard")
public class LawyerDashboardServlet extends HttpServlet {
    private AppointmentDAO appointmentDAO = new AppointmentDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("user") : null;

        if (currentUser == null || !"LAWYER".equals(currentUser.getRole())) {
            response.sendRedirect(request.getContextPath() + "/WEB-INF/views/error/access-denied.jsp");
            return;
        }

        try {
            List<Appointment> appointments = appointmentDAO.getAppointmentsByLawyer(currentUser.getUserId());
            request.setAttribute("appointments", appointments);
            request.getRequestDispatcher("/WEB-INF/views/lawyer/lawyerDashboard.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/WEB-INF/views/error/error.jsp");
        }
    }
}

