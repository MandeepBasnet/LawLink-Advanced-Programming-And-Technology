package controller.lawyer;

import dao.ReviewDAO;
import model.Review;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/lawyer/all-reviews")
public class AllReviewsServlet extends HttpServlet {
    private ReviewDAO reviewDAO = new ReviewDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            List<Review> reviews = reviewDAO.getRecentReviews(100); // Show up to 100 recent reviews
            request.setAttribute("reviews", reviews);
            request.getRequestDispatcher("/WEB-INF/views/lawyer/allReviews.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.getRequestDispatcher("/WEB-INF/views/error/error.jsp").forward(request, response);
        }
    }
}
