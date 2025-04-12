package model;

import java.sql.Date;

/**
 * Represents a client in the LawLink system.
 * Contains additional information specific to clients.
 */
public class Client {
    private int clientId;
    private int userId;
    private Date dateOfBirth;
    private String gender;
    private User user; // Associated user object

    // Default constructor
    public Client() {
    }

    // Constructor with essential fields
    public Client(int userId) {
        this.userId = userId;
    }

    // Full constructor
    public Client(int clientId, int userId, Date dateOfBirth, String gender) {
        this.clientId = clientId;
        this.userId = userId;
        this.dateOfBirth = dateOfBirth;
        this.gender = gender;
    }

    // Getters and Setters
    public int getClientId() {
        return clientId;
    }

    public void setClientId(int clientId) {
        this.clientId = clientId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public Date getDateOfBirth() {
        return dateOfBirth;
    }

    public void setDateOfBirth(Date dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    @Override
    public String toString() {
        return "Client{" +
                "clientId=" + clientId +
                ", userId=" + userId +
                ", dateOfBirth=" + dateOfBirth +
                ", gender='" + gender + '\'' +
                '}';
    }
}
