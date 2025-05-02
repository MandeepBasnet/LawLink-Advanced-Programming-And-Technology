package model;

import java.sql.Date;

/**
 * Client class that extends User with client-specific attributes
 */
public class Client extends User {
    private int clientId;
    private Date dateOfBirthSql; // SQL Date type for database operations
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
                  Date dateOfBirthSql, String gender) {
        super(username, password, email, fullName, "CLIENT");
        this.dateOfBirthSql = dateOfBirthSql;
        this.gender = gender;
        // Also set the string version for the parent class
        if (dateOfBirthSql != null) {
            this.setDateOfBirth(dateOfBirthSql.toString());
        }
    }

    // Getters and Setters
    public int getClientId() {
        return clientId;
    }

    public void setClientId(int clientId) {
        this.clientId = clientId;
    }

    // SQL Date version for database operations
    public Date getDateOfBirthSql() {
        return dateOfBirthSql;
    }

    public void setDateOfBirthSql(Date dateOfBirthSql) {
        this.dateOfBirthSql = dateOfBirthSql;
        // Also set the string version for the parent class
        if (dateOfBirthSql != null) {
            this.setDateOfBirth(dateOfBirthSql.toString());
        }
    }

    // Override to maintain compatibility with parent class
    @Override
    public void setGender(String gender) {
        super.setGender(gender);
        this.gender = gender;
    }

    @Override
    public String toString() {
        return "Client{" +
                "clientId=" + clientId +
                ", userId=" + getUserId() +
                ", fullName='" + getFullName() + '\'' +
                ", dateOfBirth=" + dateOfBirthSql +
                ", gender='" + gender + '\'' +
                '}';
    }
}
