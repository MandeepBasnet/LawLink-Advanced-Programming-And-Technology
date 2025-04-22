package dao;

import model.Review;
import util.DBConnectionUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object for Review entity
 * This class handles database operations related to reviews
 */
public class ReviewDAO {

    /**
     * Create a new review in the database
     * @param review Review object to create
     * @return true if successful, false otherwise
     */
    public boolean createReview(Review review) {
        String sql = "INSERT INTO Reviews (appointment_id, rating, comment) VALUES (?, ?, ?)";

        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setInt(1, review.getAppointmentId());
            stmt.setInt(2, review.getRating());
            stmt.setString(3, review.getComment());

            int rowsAffected = stmt.executeUpdate();

            if (rowsAffected > 0) {
                // Get the generated review_id
                try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        review.setReviewId(generatedKeys.getInt(1));

                        // Update lawyer's rating
                        updateLawyerRating(conn, getLawyerIdFromAppointment(conn, review.getAppointmentId()));

                        return true;
                    }
                }
            }

            return false;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Get a review by its ID
     * @param reviewId ID of the review to retrieve
     * @return Review object if found, null otherwise
     */
    public Review getReviewById(int reviewId) {
        String sql = "SELECT r.*, u1.full_name AS client_name, u2.full_name AS lawyer_name " +
                "FROM Reviews r " +
                "JOIN Appointments a ON r.appointment_id = a.appointment_id " +
                "JOIN Clients c ON a.client_id = c.client_id " +
                "JOIN Users u1 ON c.client_id = u1.user_id " +
                "JOIN Lawyers l ON a.lawyer_id = l.lawyer_id " +
                "JOIN Users u2 ON l.lawyer_id = u2.user_id " +
                "WHERE r.review_id = ?";

        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, reviewId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToReview(rs);
                }
            }

            return null;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * Get a review by appointment ID
     * @param appointmentId ID of the appointment
     * @return Review object if found, null otherwise
     */
    public Review getReviewByAppointmentId(int appointmentId) {
        String sql = "SELECT r.*, u1.full_name AS client_name, u2.full_name AS lawyer_name " +
                "FROM Reviews r " +
                "JOIN Appointments a ON r.appointment_id = a.appointment_id " +
                "JOIN Clients c ON a.client_id = c.client_id " +
                "JOIN Users u1 ON c.client_id = u1.user_id " +
                "JOIN Lawyers l ON a.lawyer_id = l.lawyer_id " +
                "JOIN Users u2 ON l.lawyer_id = u2.user_id " +
                "WHERE r.appointment_id = ?";

        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, appointmentId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToReview(rs);
                }
            }

            return null;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * Get all reviews for a lawyer
     * @param lawyerId ID of the lawyer
     * @return List of Review objects
     */
    public List<Review> getReviewsByLawyer(int lawyerId) {
        String sql = "SELECT r.*, u1.full_name AS client_name, u2.full_name AS lawyer_name " +
                "FROM Reviews r " +
                "JOIN Appointments a ON r.appointment_id = a.appointment_id " +
                "JOIN Clients c ON a.client_id = c.client_id " +
                "JOIN Users u1 ON c.client_id = u1.user_id " +
                "JOIN Lawyers l ON a.lawyer_id = l.lawyer_id " +
                "JOIN Users u2 ON l.lawyer_id = u2.user_id " +
                "WHERE a.lawyer_id = ? " +
                "ORDER BY r.review_date DESC";

        List<Review> reviews = new ArrayList<>();

        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, lawyerId);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    reviews.add(mapResultSetToReview(rs));
                }
            }

            return reviews;
        } catch (SQLException e) {
            e.printStackTrace();
            return reviews;
        }
    }

    /**
     * Get all reviews by a client
     * @param clientId ID of the client
     * @return List of Review objects
     */
    public List<Review> getReviewsByClient(int clientId) {
        String sql = "SELECT r.*, u1.full_name AS client_name, u2.full_name AS lawyer_name " +
                "FROM Reviews r " +
                "JOIN Appointments a ON r.appointment_id = a.appointment_id " +
                "JOIN Clients c ON a.client_id = c.client_id " +
                "JOIN Users u1 ON c.client_id = u1.user_id " +
                "JOIN Lawyers l ON a.lawyer_id = l.lawyer_id " +
                "JOIN Users u2 ON l.lawyer_id = u2.user_id " +
                "WHERE a.client_id = ? " +
                "ORDER BY r.review_date DESC";

        List<Review> reviews = new ArrayList<>();

        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, clientId);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    reviews.add(mapResultSetToReview(rs));
                }
            }

            return reviews;
        } catch (SQLException e) {
            e.printStackTrace();
            return reviews;
        }
    }

    /**
     * Get recent reviews
     * @param limit Maximum number of reviews to return
     * @return List of Review objects
     */
    public List<Review> getRecentReviews(int limit) {
        String sql = "SELECT r.*, u1.full_name AS client_name, u2.full_name AS lawyer_name " +
                "FROM Reviews r " +
                "JOIN Appointments a ON r.appointment_id = a.appointment_id " +
                "JOIN Clients c ON a.client_id = c.client_id " +
                "JOIN Users u1 ON c.client_id = u1.user_id " +
                "JOIN Lawyers l ON a.lawyer_id = l.lawyer_id " +
                "JOIN Users u2 ON l.lawyer_id = u2.user_id " +
                "ORDER BY r.review_date DESC " +
                "LIMIT ?";

        List<Review> reviews = new ArrayList<>();

        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, limit);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    reviews.add(mapResultSetToReview(rs));
                }
            }

            return reviews;
        } catch (SQLException e) {
            e.printStackTrace();
            return reviews;
        }
    }

    /**
     * Update a review in the database
     * @param review Review object to update
     * @return true if successful, false otherwise
     */
    public boolean updateReview(Review review) {
        String sql = "UPDATE Reviews SET rating = ?, comment = ? WHERE review_id = ?";

        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, review.getRating());
            stmt.setString(2, review.getComment());
            stmt.setInt(3, review.getReviewId());

            int rowsAffected = stmt.executeUpdate();

            if (rowsAffected > 0) {
                // Update lawyer's rating
                int lawyerId = getLawyerIdFromReview(conn, review.getReviewId());
                updateLawyerRating(conn, lawyerId);

                return true;
            }

            return false;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Delete a review from the database
     * @param reviewId ID of the review to delete
     * @return true if successful, false otherwise
     */
    public boolean deleteReview(int reviewId) {
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = DBConnectionUtil.getConnection();
            conn.setAutoCommit(false);

            // Get the lawyer ID before deleting the review
            int lawyerId = getLawyerIdFromReview(conn, reviewId);

            // Delete the review
            String sql = "DELETE FROM Reviews WHERE review_id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, reviewId);

            int rowsAffected = stmt.executeUpdate();

            if (rowsAffected > 0) {
                // Update lawyer's rating
                updateLawyerRating(conn, lawyerId);

                conn.commit();
                return true;
            } else {
                conn.rollback();
                return false;
            }
        } catch (SQLException e) {
            try {
                if (conn != null) {
                    conn.rollback();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (stmt != null) {
                    stmt.close();
                }
                if (conn != null) {
                    conn.setAutoCommit(true);
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    /**
     * Get the lawyer ID from a review
     * @param conn Database connection
     * @param reviewId ID of the review
     * @return Lawyer ID
     * @throws SQLException if a database access error occurs
     */
    private int getLawyerIdFromReview(Connection conn, int reviewId) throws SQLException {
        String sql = "SELECT a.lawyer_id FROM Reviews r " +
                "JOIN Appointments a ON r.appointment_id = a.appointment_id " +
                "WHERE r.review_id = ?";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, reviewId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("lawyer_id");
                }
            }
        }

        return 0;
    }

    /**
     * Get the lawyer ID from an appointment
     * @param conn Database connection
     * @param appointmentId ID of the appointment
     * @return Lawyer ID
     * @throws SQLException if a database access error occurs
     */
    private int getLawyerIdFromAppointment(Connection conn, int appointmentId) throws SQLException {
        String sql = "SELECT lawyer_id FROM Appointments WHERE appointment_id = ?";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, appointmentId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("lawyer_id");
                }
            }
        }

        return 0;
    }

    /**
     * Update a lawyer's rating based on their reviews
     * @param conn Database connection
     * @param lawyerId ID of the lawyer
     * @throws SQLException if a database access error occurs
     */
    private void updateLawyerRating(Connection conn, int lawyerId) throws SQLException {
        String sql = "UPDATE Lawyers SET rating = " +
                "(SELECT COALESCE(AVG(r.rating), 0.0) FROM Reviews r " +
                "JOIN Appointments a ON r.appointment_id = a.appointment_id " +
                "WHERE a.lawyer_id = ?) " +
                "WHERE lawyer_id = ?";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, lawyerId);
            stmt.setInt(2, lawyerId);

            stmt.executeUpdate();
        }
    }

    /**
     * Map a ResultSet to a Review object
     * @param rs ResultSet to map
     * @return Review object
     * @throws SQLException if a database access error occurs
     */
    private Review mapResultSetToReview(ResultSet rs) throws SQLException {
        Review review = new Review();
        review.setReviewId(rs.getInt("review_id"));
        review.setAppointmentId(rs.getInt("appointment_id"));
        review.setRating(rs.getInt("rating"));
        review.setComment(rs.getString("comment"));
        review.setReviewDate(rs.getTimestamp("review_date"));

        // Additional fields for display purposes
        review.setClientName(rs.getString("client_name"));
        review.setLawyerName(rs.getString("lawyer_name"));

        return review;
    }
}
