package controller.lawyer;

import dao.ReviewDAO;
import model.Review;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.User;

import java.io.IOException;
import java.util.List;

@WebServlet("/lawyer/all-reviews")
public class AllReviewsServlet extends HttpServlet {
    private ReviewDAO reviewDAO = new ReviewDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("user") : null;

        if (currentUser == null || !"LAWYER".equals(currentUser.getRole())) {
            response.sendRedirect(request.getContextPath() + "/WEB-INF/views/error/access-denied.jsp");
            return;
        }

        try {
            List<Review> reviews = reviewDAO.getReviewsByLawyer(currentUser.getUserId()); // Updated to specific lawyer
            request.setAttribute("reviews", reviews);
            request.getRequestDispatcher("/WEB-INF/views/lawyer/allReviews.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.getRequestDispatcher("/WEB-INF/views/error/error.jsp").forward(request, response);
        }
    }
}