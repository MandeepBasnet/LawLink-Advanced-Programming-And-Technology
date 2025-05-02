package controller.admin;

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
import java.util.logging.Logger;

@WebServlet("/admin/admin-lawyers")
public class AdminLawyersServlet extends HttpServlet {
    private static final Logger logger = Logger.getLogger(AdminLawyersServlet.class.getName());
    private LawyerDAO lawyerDAO;

    @Override
    public void init() throws ServletException {
        try {
            lawyerDAO = new LawyerDAO();
        } catch (SQLException e) {
            logger.severe("Failed to initialize LawyerDAO: " + e.getMessage());
            throw new ServletException("Failed to initialize LawyerDAO", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Lawyer> lawyers = lawyerDAO.getAllLawyers();
        request.setAttribute("lawyers", lawyers);
        request.getRequestDispatcher("/WEB-INF/views/admin/adminDashboardLawyers.jsp").forward(request, response);
    }
}

