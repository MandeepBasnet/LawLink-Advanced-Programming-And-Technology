package controller.admin;

import dao.UserDAO;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Logger;

@WebServlet("/admin/admin-clients")
public class AdminClientsServlet extends HttpServlet {
    private static final Logger logger = Logger.getLogger(AdminClientsServlet.class.getName());
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        try {
            userDAO = new UserDAO();
        } catch (SQLException e) {
            logger.severe("Failed to initialize UserDAO: " + e.getMessage());
            throw new ServletException("Failed to initialize UserDAO", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            List<User> clients = userDAO.getAllClients();
            request.setAttribute("clients", clients);
            request.getRequestDispatcher("/WEB-INF/views/admin/adminDashboardClients.jsp").forward(request, response);
        } catch (SQLException e) {
            logger.severe("Error retrieving clients: " + e.getMessage());
            request.setAttribute("error", "Error retrieving clients. Please try again.");
            request.getRequestDispatcher("/WEB-INF/views/admin/adminDashboardClients.jsp").forward(request, response);
        }
    }
}

