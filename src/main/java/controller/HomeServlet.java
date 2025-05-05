package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.sql.SQLException;
import dao.PracticeAreaDAO;
import dao.LawyerDAO;
import model.PracticeArea;
import model.Lawyer;
import java.util.List;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {
    private PracticeAreaDAO practiceAreaDAO;
    private LawyerDAO lawyerDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        practiceAreaDAO = new PracticeAreaDAO();
        try {
            lawyerDAO = new LawyerDAO();
        } catch (SQLException e) {
            throw new ServletException("Failed to initialize LawyerDAO", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Set default values
            request.setAttribute("contactPhone", "+977-9812345678");

            // Load practice areas from database
            List<PracticeArea> practiceAreas = practiceAreaDAO.getAllPracticeAreas();
            request.setAttribute("practiceAreas", practiceAreas);

            // Load first 3 lawyers from database
            List<Lawyer> lawyers = lawyerDAO.getFirstLawyers(3);
            if (lawyers == null || lawyers.isEmpty()) {
                System.out.println("No lawyers found in database, will rely on JSP fallback");
            }
            request.setAttribute("attorneys", lawyers);

            // Log the request
            System.out.println("HomeServlet: Processing request for " + request.getRequestURI());

            // Forward to home.jsp
            request.getRequestDispatcher("/WEB-INF/views/home.jsp").forward(request, response);
        } catch (Exception e) {
            // Log the detailed error
            StringWriter sw = new StringWriter();
            PrintWriter pw = new PrintWriter(sw);
            e.printStackTrace(pw);
            String stackTrace = sw.toString();

            System.err.println("HomeServlet Error: " + e.getMessage());
            System.err.println("Stack Trace: " + stackTrace);

            // Set error details in request
            request.setAttribute("errorMessage", "Unable to load homepage. Please try again later.");
            request.setAttribute("stackTrace", stackTrace);

            // Forward to error page
            request.getRequestDispatcher("/WEB-INF/views/error/500.jsp").forward(request, response);
        }
    }
}