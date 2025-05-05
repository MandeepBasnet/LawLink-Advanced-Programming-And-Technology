package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;
import dao.LawyerDAO;
import model.Lawyer;
import java.util.List;
import java.sql.SQLException;

@WebServlet("/lawyers")
public class LawyersServlet extends HttpServlet {
    private LawyerDAO lawyerDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        try {
            lawyerDAO = new LawyerDAO();
        } catch (SQLException e) {
            throw new ServletException("Failed to initialize LawyerDAO", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Load lawyers from database
            List<Lawyer> lawyers = lawyerDAO.getAllLawyers();
            if (lawyers == null || lawyers.isEmpty()) {
                System.out.println("No lawyers found in database, will rely on JSP fallback");
            }
            request.setAttribute("lawyers", lawyers);

            // Log the request
            System.out.println("LawyersServlet: Processing request for " + request.getRequestURI());

            // Forward to lawyers.jsp
            request.getRequestDispatcher("/WEB-INF/views/lawyers.jsp").forward(request, response);
        } catch (Exception e) {
            // Log the detailed error
            StringWriter sw = new StringWriter();
            PrintWriter pw = new PrintWriter(sw);
            e.printStackTrace(pw);
            String stackTrace = sw.toString();

            System.err.println("LawyersServlet Error: " + e.getMessage());
            System.err.println("Stack Trace: " + stackTrace);

            // Set error details in request
            request.setAttribute("errorMessage", "Unable to load lawyers page. Please try again later.");
            request.setAttribute("stackTrace", stackTrace);

            // Forward to error page
            request.getRequestDispatcher("/WEB-INF/views/error/500.jsp").forward(request, response);
        }
    }
}