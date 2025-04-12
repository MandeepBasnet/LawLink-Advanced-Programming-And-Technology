package model;


import java.sql.Timestamp;
import util.FileStorageUtil;

/**
 * Represents a user in the LawLink system.
 * This is the base class for all user types (Admin, Lawyer, Client).
 */
public class User {
    private int userId;
    private String username;
    private String password;
    private String email;
    private String fullName;
    private String phone;
    private String address;
    private String role;
    private Timestamp registrationDate;
    private Timestamp lastLogin;
    private boolean isActive;
    private String profileImage;  // Changed to store the file path instead of binary data

    // Default constructor
    public User() {
    }

    // Constructor with essential fields
    public User(String username, String password, String email, String fullName, String role) {
        this.username = username;
        this.password = password;
        this.email = email;
        this.fullName = fullName;
        this.role = role;
        this.isActive = true;
    }

    // Full constructor
    public User(int userId, String username, String password, String email, String fullName,
                String phone, String address, String role, Timestamp registrationDate,
                Timestamp lastLogin, boolean isActive, String profileImage) {
        this.userId = userId;
        this.username = username;
        this.password = password;
        this.email = email;
        this.fullName = fullName;
        this.phone = phone;
        this.address = address;
        this.role = role;
        this.registrationDate = registrationDate;
        this.lastLogin = lastLogin;
        this.isActive = isActive;
        this.profileImage = profileImage;
    }

    // Getters and Setters
    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public Timestamp getRegistrationDate() {
        return registrationDate;
    }

    public void setRegistrationDate(Timestamp registrationDate) {
        this.registrationDate = registrationDate;
    }

    public Timestamp getLastLogin() {
        return lastLogin;
    }

    public void setLastLogin(Timestamp lastLogin) {
        this.lastLogin = lastLogin;
    }

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean active) {
        isActive = active;
    }

    /**
     * Gets the profile image path.
     *
     * @return The profile image path, or null if not set
     */
    public String getProfileImage() {
        return profileImage;
    }

    /**
     * Sets the profile image path.
     *
     * @param profileImage The profile image path
     */
    public void setProfileImage(String profileImage) {
        this.profileImage = profileImage;
    }

    /**
     * Checks if the user has a profile image.
     *
     * @return true if the user has a profile image, false otherwise
     */
    public boolean hasProfileImage() {
        return profileImage != null && !profileImage.isEmpty();
    }

    /**
     * Gets the profile image path or a default image if not set.
     *
     * @return The profile image path or default image path
     */
    public String getProfileImageOrDefault() {
        if (hasProfileImage()) {
            return profileImage;
        } else {
            return "assets/images/default-profile.png";
        }
    }

    /**
     * Gets the CDN URL for the profile image.
     *
     * @return The CDN URL for the profile image, or the default image URL if not set
     */
    public String getProfileImageUrl() {
        if (hasProfileImage()) {
            return FileStorageUtil.getCdnUrl(profileImage);
        } else {
            return FileStorageUtil.getCdnUrl("assets/images/default-profile.png");
        }
    }

    @Override
    public String toString() {
        return "User{" +
                "userId=" + userId +
                ", username='" + username + '\'' +
                ", email='" + email + '\'' +
                ", fullName='" + fullName + '\'' +
                ", role='" + role + '\'' +
                ", isActive=" + isActive +
                ", hasProfileImage=" + hasProfileImage() +
                '}';
    }
}

