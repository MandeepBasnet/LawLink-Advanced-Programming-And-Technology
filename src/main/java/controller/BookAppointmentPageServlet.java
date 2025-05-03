package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/client/book-appointment-page")
public class BookAppointmentPageServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String lawyerId = request.getParameter("lawyerId");
        if (lawyerId == null || lawyerId.trim().isEmpty()) {
            request.setAttribute("error", "Invalid lawyer selection.");
            request.getRequestDispatcher("/WEB-INF/views/error/400.jsp").forward(request, response);
            return;
        }

        request.setAttribute("lawyerId", lawyerId);
        request.getRequestDispatcher("/WEB-INF/views/book-appointment.jsp").forward(request, response);
    }
}