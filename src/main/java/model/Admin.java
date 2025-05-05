package model;

/**
 * Admin class that extends User with admin-specific attributes
 */
public class Admin extends User {
    private int adminId;

    // Default constructor
    public Admin() {
        super();
        this.setRole("ADMIN");
    }

    // Constructor with essential fields
    public Admin(String username, String password, String email, String fullName) {
        super(username, password, email, fullName, "ADMIN");
    }

    // Getters and Setters
    public int getAdminId() {
        return adminId;
    }

    public void setAdminId(int adminId) {
        this.adminId = adminId;
    }

    @Override
    public String toString() {
        return "Admin{" +
                "adminId=" + adminId +
                ", userId=" + getUserId() +
                ", fullName='" + getFullName() + '\'' +
                '}';
    }
}