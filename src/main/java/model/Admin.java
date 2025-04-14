package model;

import java.sql.Timestamp;

import util.FileStorageUtil;

/**
 * Represents an Admin user in the LawLink system.
 */
public class Admin {
    private int adminId;
    private String username;
    private String password;
    private String email;
    private String fullName;
    private String phone;
    private Timestamp lastLogin;
    private boolean isActive;
    private String profileImage;  // File path to profile image

    // Default constructor
    public Admin() {
    }

    // Constructor with essential fields
    public Admin(String username, String password, String email, String fullName) {
        this.username = username;
        this.password = password;
        this.email = email;
        this.fullName = fullName;
        this.isActive = true;
    }

    // Full constructor
    public Admin(int adminId, String username, String password, String email, String fullName,
                 String phone, Timestamp lastLogin, boolean isActive, String profileImage) {
        this.adminId = adminId;
        this.username = username;
        this.password = password;
        this.email = email;
        this.fullName = fullName;
        this.phone = phone;
        this.lastLogin = lastLogin;
        this.isActive = isActive;
        this.profileImage = profileImage;
    }

    // Getters and Setters
    public int getAdminId() {
        return adminId;
    }

    public void setAdminId(int adminId) {
        this.adminId = adminId;
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

    public String getProfileImage() {
        return profileImage;
    }

    public void setProfileImage(String profileImage) {
        this.profileImage = profileImage;
    }

    public boolean hasProfileImage() {
        return profileImage != null && !profileImage.isEmpty();
    }

    public String getProfileImageOrDefault() {
        if (hasProfileImage()) {
            return profileImage;
        } else {
            return "assets/images/default-admin.png";
        }
    }

    // Add getProfileImageUrl method to use FileStorageUtil
    public String getProfileImageUrl() {
        if (hasProfileImage()) {
            return FileStorageUtil.getCdnUrl(profileImage);
        } else {
            return FileStorageUtil.getCdnUrl(FileStorageUtil.getDefaultProfileImage("admin"));
        }
    }

    @Override
    public String toString() {
        return "Admin{" +
                "adminId=" + adminId +
                ", username='" + username + '\'' +
                ", email='" + email + '\'' +
                ", fullName='" + fullName + '\'' +
                ", isActive=" + isActive +
                '}';
    }
}
