package controller;

import dao.ReviewDAO;
import model.Review;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/client/reviews")
public class ReviewsServlet extends HttpServlet {
    private ReviewDAO reviewDAO = new ReviewDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Review> reviews = reviewDAO.getRecentReviews(20); // Top 20 recent reviews
        request.setAttribute("reviews", reviews);
        request.getRequestDispatcher("reviews.jsp").forward(request, response);
    }
}
