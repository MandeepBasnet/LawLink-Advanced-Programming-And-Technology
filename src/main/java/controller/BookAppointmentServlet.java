package controller;

import dao.AppointmentDAO;
import model.Appointment;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Date;
import java.sql.Time;

@WebServlet("/client/book-appointment")
public class BookAppointmentServlet extends HttpServlet {
    private AppointmentDAO appointmentDAO = new AppointmentDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null || !"CLIENT".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/log-in");
            return;
        }

        try {
            int lawyerId = Integer.parseInt(request.getParameter("lawyerId"));
            Date date = Date.valueOf(request.getParameter("appointmentDate"));
            Time time = Time.valueOf(request.getParameter("appointmentTime"));
            int duration = Integer.parseInt(request.getParameter("duration"));
            String notes = request.getParameter("notes");

            Appointment appointment = new Appointment();
            appointment.setLawyerId(lawyerId);
            appointment.setClientId(user.getUserId());
            appointment.setAppointmentDate(date);
            appointment.setAppointmentTime(time);
            appointment.setDuration(duration);
            appointment.setNotes(notes);

            boolean success = appointmentDAO.createAppointment(appointment);

            if (success) {
                response.sendRedirect("my-appointments");
            } else {
                request.setAttribute("error", "Failed to book appointment.");
                request.getRequestDispatcher("book-appointment.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error while booking appointment.");
            request.getRequestDispatcher("book-appointment.jsp").forward(request, response);
        }
    }
}