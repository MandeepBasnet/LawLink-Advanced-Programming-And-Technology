package controller;

import dao.LawyerDAO;
import dao.UserDAO;
import model.Appointment;
import model.Lawyer;
import model.User;
import dao.AppointmentDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.*;

import com.google.gson.Gson;
import util.DBConnectionUtil;

@WebServlet({"/client/book-appointment-page", "/client/book-appointment"})
public class BookAppointmentServlet extends HttpServlet {
    private AppointmentDAO appointmentDAO;
    private LawyerDAO lawyerDAO;
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        try {
            appointmentDAO = new AppointmentDAO();
            lawyerDAO = new LawyerDAO();
            userDAO = new UserDAO();
        } catch (SQLException e) {
            throw new ServletException("Failed to initialize DAOs", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("getTimeSlots".equals(action)) {
            handleTimeSlotsRequest(request, response);
            return;
        }

        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null || !"CLIENT".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/log-in");
            return;
        }

        try {
            String lawyerIdStr = request.getParameter("lawyerId");
            if (lawyerIdStr == null || lawyerIdStr.trim().isEmpty()) {
                request.setAttribute("error", "Invalid lawyer selection.");
                request.getRequestDispatcher("/WEB-INF/views/book-appointment.jsp").forward(request, response);
                return;
            }

            int lawyerId = Integer.parseInt(lawyerIdStr);
            Lawyer lawyer = lawyerDAO.getLawyerById(lawyerId);

            if (lawyer == null) {
                request.setAttribute("error", "Lawyer not found.");
                request.getRequestDispatcher("/WEB-INF/views/book-appointment.jsp").forward(request, response);
                return;
            }

            request.setAttribute("lawyer", lawyer);
            request.getRequestDispatcher("/WEB-INF/views/book-appointment.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid lawyer ID format.");
            request.getRequestDispatcher("/WEB-INF/views/book-appointment.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error loading booking page.");
            request.getRequestDispatcher("/WEB-INF/views/book-appointment.jsp").forward(request, response);
        }
    }

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
            String dateStr = request.getParameter("appointmentDate");
            String timeStr = request.getParameter("appointmentTime");
            int duration = Integer.parseInt(request.getParameter("duration"));
            String clientName = request.getParameter("clientName");
            String clientPhone = request.getParameter("clientPhone");
            String notes = request.getParameter("notes");

            // Validate date format
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            dateFormat.setLenient(false);
            Date date;
            try {
                date = new Date(dateFormat.parse(dateStr).getTime());
            } catch (Exception e) {
                request.setAttribute("error", "Invalid date format.");
                doGet(request, response);
                return;
            }

            // Validate time format
            SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm:ss");
            timeFormat.setLenient(false);
            Time time;
            try {
                time = new Time(timeFormat.parse(timeStr).getTime());
            } catch (Exception e) {
                request.setAttribute("error", "Invalid time format.");
                doGet(request, response);
                return;
            }

            // Validate phone number
            if (!clientPhone.matches("\\d{10}")) {
                request.setAttribute("error", "Please provide a valid 10-digit phone number.");
                doGet(request, response);
                return;
            }

            // Verify lawyer availability
            if (!appointmentDAO.isLawyerAvailable(lawyerId, date, time)) {
                request.setAttribute("error", "Selected time slot is not available.");
                doGet(request, response);
                return;
            }

            // Check LawyerAvailability for the day of the week
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(date);
            String dayOfWeek = new SimpleDateFormat("EEEE").format(date).toUpperCase();
            String availabilitySql = "SELECT is_available FROM LawyerAvailability WHERE lawyer_id = ? AND day_of_week = ?";
            try (Connection conn = DBConnectionUtil.getConnection();
                 PreparedStatement stmt = conn.prepareStatement(availabilitySql)) {
                stmt.setInt(1, lawyerId);
                stmt.setString(2, dayOfWeek);
                ResultSet rs = stmt.executeQuery();
                if (rs.next() && !rs.getBoolean("is_available")) {
                    request.setAttribute("error", "Lawyer is not available on " + dayOfWeek + ".");
                    doGet(request, response);
                    return;
                }
            } catch (SQLException e) {
                e.printStackTrace();
                request.setAttribute("error", "Error checking lawyer availability.");
                doGet(request, response);
                return;
            }

            Appointment appointment = new Appointment();
            appointment.setLawyerId(lawyerId);
            appointment.setClientId(user.getUserId());
            appointment.setAppointmentDate(date);
            appointment.setAppointmentTime(time);
            appointment.setDuration(duration);
            appointment.setNotes(notes);
            appointment.setStatus("PENDING");

            boolean success = appointmentDAO.createAppointment(appointment);

            if (success) {
                request.setAttribute("success", "Appointment booked successfully!");
                response.sendRedirect(request.getContextPath() + "/client/my-appointments");
            } else {
                request.setAttribute("error", "Failed to book appointment.");
                doGet(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid input format.");
            doGet(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error while booking appointment.");
            doGet(request, response);
        }
    }

    private void handleTimeSlotsRequest(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            int lawyerId = Integer.parseInt(request.getParameter("lawyerId"));
            String dateStr = request.getParameter("date");
            Date date = Date.valueOf(dateStr);

            List<Appointment> appointments = appointmentDAO.getAppointmentsByLawyer(lawyerId);
            List<String> bookedSlots = new ArrayList<>();

            for (Appointment appt : appointments) {
                if (appt.getAppointmentDate().equals(date) && !appt.getStatus().equals("CANCELLED")) {
                    bookedSlots.add(appt.getAppointmentTime().toString().substring(0, 5));
                }
            }

            Map<String, Object> responseData = new HashMap<>();
            responseData.put("bookedSlots", bookedSlots);

            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            out.print(new Gson().toJson(responseData));
            out.flush();

        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            out.print("{\"error\": \"Failed to fetch time slots.\"}");
            out.flush();
        }
    }
}