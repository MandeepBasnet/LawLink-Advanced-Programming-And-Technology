package model;

import java.sql.Timestamp;

/**
 * Review class that represents a client's review of a lawyer after an appointment
 */
public class Review {
    private int reviewId;
    private int appointmentId;
    private int rating;
    private String comment;
    private Timestamp reviewDate;

    // Additional fields for display purposes
    private String clientName;
    private String lawyerName;

    // Default constructor
    public Review() {
    }

    // Constructor with essential fields
    public Review(int appointmentId, int rating, String comment) {
        this.appointmentId = appointmentId;
        this.rating = rating;
        this.comment = comment;
    }

    // Getters and Setters
    public int getReviewId() {
        return reviewId;
    }

    public void setReviewId(int reviewId) {
        this.reviewId = reviewId;
    }

    public int getAppointmentId() {
        return appointmentId;
    }

    public void setAppointmentId(int appointmentId) {
        this.appointmentId = appointmentId;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public Timestamp getReviewDate() {
        return reviewDate;
    }

    public void setReviewDate(Timestamp reviewDate) {
        this.reviewDate = reviewDate;
    }

    public String getClientName() {
        return clientName;
    }

    public void setClientName(String clientName) {
        this.clientName = clientName;
    }

    public String getLawyerName() {
        return lawyerName;
    }

    public void setLawyerName(String lawyerName) {
        this.lawyerName = lawyerName;
    }

    @Override
    public String toString() {
        return "Review{" +
                "reviewId=" + reviewId +
                ", appointmentId=" + appointmentId +
                ", rating=" + rating +
                ", reviewDate=" + reviewDate +
                '}';
    }
}
