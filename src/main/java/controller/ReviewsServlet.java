package controller;

import dao.ReviewDAO;
import model.Review;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.google.gson.Gson;

@WebServlet("/client/reviews")
public class ReviewsServlet extends HttpServlet {
    private ReviewDAO reviewDAO;

    @Override
    public void init() throws ServletException {
        reviewDAO = new ReviewDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String lawyerIdStr = request.getParameter("lawyerId");

        try {
            if (lawyerIdStr != null && !lawyerIdStr.isEmpty()) {
                // Handle AJAX request for reviews by lawyerId
                int lawyerId = Integer.parseInt(lawyerIdStr);
                List<Map<String, Object>> reviews = fetchReviewsByLawyer(lawyerId);

                response.setContentType("application/json");
                PrintWriter out = response.getWriter();
                out.print(new Gson().toJson(reviews));
                out.flush();
            } else {
                // Original functionality: Display recent reviews
                List<Review> reviews = reviewDAO.getRecentReviews(20); // Top 20 recent reviews
                request.setAttribute("reviews", reviews);
                request.getRequestDispatcher("reviews.jsp").forward(request, response);
            }
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            out.print("{\"error\": \"Invalid lawyer ID.\"}");
            out.flush();
        } catch (SQLException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            out.print("{\"error\": \"Failed to fetch reviews.\"}");
            out.flush();
        }
    }

    private List<Map<String, Object>> fetchReviewsByLawyer(int lawyerId) throws SQLException {
        List<Map<String, Object>> reviews = new ArrayList<>();
        String sql = "SELECT r.rating, r.comment, r.review_date, u.full_name AS reviewer_name " +
                "FROM Reviews r " +
                "JOIN Appointments a ON r.appointment_id = a.appointment_id " +
                "JOIN Users u ON a.client_id = u.user_id " +
                "WHERE a.lawyer_id = ? " +
                "ORDER BY r.review_date DESC LIMIT 2";

        try (Connection conn = util.DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, lawyerId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> review = new HashMap<>();
                    review.put("rating", rs.getInt("rating"));
                    review.put("comment", rs.getString("comment"));
                    review.put("reviewDate", rs.getTimestamp("review_date").toString());
                    review.put("reviewerName", rs.getString("reviewer_name"));
                    reviews.add(review);
                }
            }
        }
        return reviews;
    }
}