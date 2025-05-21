package controller.admin;

import dao.LawyerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/admin/delete-lawyer")
public class DeleteLawyerServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int lawyerId = Integer.parseInt(request.getParameter("lawyerId"));
            LawyerDAO lawyerDAO = new LawyerDAO();
            boolean deleted = lawyerDAO.deleteLawyer(lawyerId);
            if (deleted) {
                request.getSession().setAttribute("successMessage", "Lawyer deleted successfully.");
            } else {
                request.getSession().setAttribute("errorMessage", "Failed to delete lawyer.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "Database error occurred while deleting lawyer.");
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("errorMessage", "Invalid lawyer ID.");
        }
        response.sendRedirect(request.getContextPath() + "/admin/admin-lawyers");
    }
}