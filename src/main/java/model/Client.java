package model;

import java.sql.Date;

/**
 * Client class that extends User with client-specific attributes
 */
public class Client extends User {
    private int clientId;
    private Date dateOfBirth;
    private String gender;

    // Default constructor
    public Client() {
        super();
        this.setRole("CLIENT");
    }

    // Constructor with essential fields
    public Client(String username, String password, String email, String fullName) {
        super(username, password, email, fullName, "CLIENT");
    }

    // Constructor with all fields
    public Client(String username, String password, String email, String fullName,
                  Date dateOfBirth, String gender) {
        super(username, password, email, fullName, "CLIENT");
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

    @Override
    public String toString() {
        return "Client{" +
                "clientId=" + clientId +
                ", userId=" + getUserId() +
                ", fullName='" + getFullName() + '\'' +
                ", dateOfBirth=" + dateOfBirth +
                ", gender='" + gender + '\'' +
                '}';
    }
}
