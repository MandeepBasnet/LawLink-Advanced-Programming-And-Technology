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

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.*;

import com.google.gson.Gson;
import util.DBConnectionUtil;

import com.itextpdf.kernel.pdf.PdfDocument;
import com.itextpdf.kernel.pdf.PdfWriter;
import com.itextpdf.layout.Document;
import com.itextpdf.layout.element.Paragraph;
import com.itextpdf.layout.element.Text;
import com.itextpdf.layout.properties.TextAlignment;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@WebServlet({"/client/book-appointment-page", "/client/book-appointment", "/client/download-receipt"})
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
        String servletPath = request.getServletPath();
        if ("/client/download-receipt".equals(servletPath)) {
            handleDownloadReceipt(request, response);
            return;
        }

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
            java.sql.Date sqlDate;
            try {
                java.util.Date utilDate = dateFormat.parse(dateStr);
                sqlDate = new java.sql.Date(utilDate.getTime());
            } catch (Exception e) {
                request.setAttribute("error", "Invalid date format.");
                doGet(request, response);
                return;
            }

            // Validate time format
            SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm:ss");
            timeFormat.setLenient(false);
            Time sqlTime;
            try {
                java.util.Date utilTime = timeFormat.parse(timeStr);
                sqlTime = new Time(utilTime.getTime());
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
            if (!appointmentDAO.isLawyerAvailable(lawyerId, sqlDate, sqlTime)) {
                request.setAttribute("error", "Selected time slot is not available.");
                doGet(request, response);
                return;
            }

            // Check LawyerAvailability for the day of the week
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(sqlDate);
            String dayOfWeek = new SimpleDateFormat("EEEE").format(sqlDate).toUpperCase();
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
            appointment.setAppointmentDate(sqlDate);
            appointment.setAppointmentTime(sqlTime);
            appointment.setDuration(duration);
            appointment.setNotes(notes);
            appointment.setStatus("PENDING");

            boolean success = appointmentDAO.createAppointment(appointment);

            if (success) {
                // Fetch the lawyer details for the PDF
                Lawyer lawyer = lawyerDAO.getLawyerById(lawyerId);
                if (lawyer == null) {
                    request.setAttribute("error", "Failed to retrieve lawyer details for receipt.");
                    doGet(request, response);
                    return;
                }

                // Generate PDF and store in session
                ByteArrayOutputStream pdfStream = generateReceiptPDF(appointment, lawyer, clientName, clientPhone);
                session.setAttribute("receipt_" + appointment.getAppointmentId(), pdfStream.toByteArray());

                // Set success message and appointment ID for JSP
                request.setAttribute("success", "Appointment booked successfully! Your receipt is being downloaded.");
                request.setAttribute("appointmentId", appointment.getAppointmentId());
                doGet(request, response);
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

    private ByteArrayOutputStream generateReceiptPDF(Appointment appointment, Lawyer lawyer, String clientName, String clientPhone) throws IOException {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        try (PdfWriter writer = new PdfWriter(baos);
             PdfDocument pdf = new PdfDocument(writer);
             Document document = new Document(pdf)) {

            // Add title
            document.add(new Paragraph("Appointment Receipt")
                    .setFontSize(20)
                    .setBold()
                    .setTextAlignment(TextAlignment.CENTER));

            // Add timestamp
            LocalDateTime now = LocalDateTime.now();
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MMMM dd, yyyy HH:mm:ss");
            document.add(new Paragraph("Generated on: " + now.format(formatter))
                    .setTextAlignment(TextAlignment.CENTER)
                    .setFontSize(12));

            // Add a blank line
            document.add(new Paragraph(""));

            // Appointment Details
            document.add(new Paragraph("Appointment Details").setFontSize(16).setBold());
            document.add(new Paragraph("Appointment ID: " + appointment.getAppointmentId()));
            document.add(new Paragraph("Date: " + appointment.getAppointmentDate()));
            document.add(new Paragraph("Time: " + appointment.getAppointmentTime()));
            document.add(new Paragraph("Duration: " + appointment.getDuration() + " minutes"));
            document.add(new Paragraph("Status: " + appointment.getStatus()));
            document.add(new Paragraph("Notes: " + (appointment.getNotes() != null ? appointment.getNotes() : "None")));

            // Add a blank line
            document.add(new Paragraph(""));

            // Lawyer Details
            document.add(new Paragraph("Lawyer Details").setFontSize(16).setBold());
            document.add(new Paragraph("Name: " + lawyer.getFullName()));
            document.add(new Paragraph("Specialization: " + lawyer.getSpecialization()));
            document.add(new Paragraph("Consultation Fee: $" + lawyer.getConsultationFee()));
            document.add(new Paragraph("Phone: " + (lawyer.getPhone() != null ? lawyer.getPhone() : "Not provided")));

            // Add a blank line
            document.add(new Paragraph(""));

            // Client Details
            document.add(new Paragraph("Client Details").setFontSize(16).setBold());
            document.add(new Paragraph("Name: " + clientName));
            document.add(new Paragraph("Phone: " + clientPhone));

            // Add a footer
            document.add(new Paragraph("Thank you for booking with Law Link!")
                    .setTextAlignment(TextAlignment.CENTER)
                    .setFontSize(12)
                    .setMarginTop(20));

        } catch (Exception e) {
            e.printStackTrace();
            throw new IOException("Error generating PDF receipt: " + e.getMessage());
        }
        return baos;
    }

    private void handleDownloadReceipt(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        String appointmentId = request.getParameter("appointmentId");
        byte[] pdfBytes = (byte[]) session.getAttribute("receipt_" + appointmentId);

        if (pdfBytes == null) {
            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
            response.getWriter().write("Receipt not found.");
            return;
        }

        // Set response headers for PDF download
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=appointment_receipt_" + appointmentId + ".pdf");
        response.getOutputStream().write(pdfBytes);
        response.getOutputStream().flush();

        // Clean up session
        session.removeAttribute("receipt_" + appointmentId);
    }

    private void handleTimeSlotsRequest(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            int lawyerId = Integer.parseInt(request.getParameter("lawyerId"));
            String dateStr = request.getParameter("date");
            java.sql.Date sqlDate = java.sql.Date.valueOf(dateStr);

            List<Appointment> appointments = appointmentDAO.getAppointmentsByLawyer(lawyerId);
            List<String> bookedSlots = new ArrayList<>();

            for (Appointment appt : appointments) {
                if (appt.getAppointmentDate().equals(sqlDate) && !appt.getStatus().equals("CANCELLED")) {
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