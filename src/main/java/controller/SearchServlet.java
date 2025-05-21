package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import dao.LawyerDAO;
import model.Lawyer;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Logger;

@WebServlet("/search")
public class SearchServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(SearchServlet.class.getName());
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
            String query = request.getParameter("query");
            String practiceArea = request.getParameter("practiceArea");

            // Log the search parameters
            LOGGER.info("Search request: query=" + query + ", practiceArea=" + practiceArea);

            // Prioritize name search if query is provided
            if (query != null && !query.trim().isEmpty()) {
                Lawyer lawyer = lawyerDAO.getLawyerByName(query.trim());
                if (lawyer != null) {
                    LOGGER.info("Found lawyer: " + lawyer.getFullName() + " (ID: " + lawyer.getLawyerId() + ")");
                    // Redirect to the lawyer's book-appointment page
                    response.sendRedirect(request.getContextPath() + "/client/book-appointment-page?lawyerId=" + lawyer.getLawyerId());
                    return;
                } else {
                    LOGGER.info("No lawyer found for name: " + query);
                    // No lawyer found, set error message and forward to search results page
                    request.setAttribute("errorMessage", "No lawyer found with the name: " + query);
                    request.getRequestDispatcher("/WEB-INF/views/search-results.jsp").forward(request, response);
                    return;
                }
            }

            // Handle practice area search
            if (practiceArea != null && !practiceArea.trim().isEmpty()) {
                List<Lawyer> lawyers = lawyerDAO.getLawyersByPracticeArea(practiceArea);
                LOGGER.info("Found " + (lawyers != null ? lawyers.size() : 0) + " lawyers for practice area: " + practiceArea);
                if (lawyers == null || lawyers.isEmpty()) {
                    request.setAttribute("errorMessage", "No lawyers found for practice area: " + practiceArea);
                }
                request.setAttribute("lawyers", lawyers);
                request.setAttribute("practiceArea", practiceArea);
                request.getRequestDispatcher("/WEB-INF/views/search-results.jsp").forward(request, response);
                return;
            }

            // If neither query nor practiceArea is provided, show error
            LOGGER.warning("Empty search request received");
            request.setAttribute("errorMessage", "Please provide a search term or select a practice area.");
            request.getRequestDispatcher("/WEB-INF/views/search-results.jsp").forward(request, response);

        } catch (Exception e) {
            // Log error and forward to error page
            LOGGER.severe("SearchServlet Error: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred while processing your search. Please try again later.");
            request.getRequestDispatcher("/WEB-INF/views/error/500.jsp").forward(request, response);
        }
    }
}