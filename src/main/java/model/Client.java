package model;

import java.sql.Date;
import java.sql.Timestamp;
import util.FileStorageUtil;

/**
 * Represents a Client in the LawLink system.
 */
public class Client {
    private int clientId;
    private String username;
    private String password;
    private String email;
    private String fullName;
    private String phone;
    private String address;
    private Timestamp registrationDate;
    private Timestamp lastLogin;
    private boolean isActive;
    private String profileImage;  // File path to profile image

    // Client-specific fields
    private Date dateOfBirth;
    private String gender;

    // Default constructor
    public Client() {
    }

    // Constructor with essential fields
    public Client(String username, String password, String email, String fullName) {
        this.username = username;
        this.password = password;
        this.email = email;
        this.fullName = fullName;
        this.isActive = true;
    }

    // Full constructor
    public Client(int clientId, String username, String password, String email, String fullName,
                  String phone, String address, Timestamp registrationDate, Timestamp lastLogin,
                  boolean isActive, String profileImage, Date dateOfBirth, String gender) {
        this.clientId = clientId;
        this.username = username;
        this.password = password;
        this.email = email;
        this.fullName = fullName;
        this.phone = phone;
        this.address = address;
        this.registrationDate = registrationDate;
        this.lastLogin = lastLogin;
        this.isActive = isActive;
        this.profileImage = profileImage;
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

    public String getProfileImage() {
        return profileImage;
    }

    public void setProfileImage(String profileImage) {
        this.profileImage = profileImage;
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

    public boolean hasProfileImage() {
        return profileImage != null && !profileImage.isEmpty();
    }

    // Update the getProfileImageOrDefault method to use FileStorageUtil
    public String getProfileImageOrDefault() {
        if (hasProfileImage()) {
            return profileImage;
        } else {
            return FileStorageUtil.getDefaultProfileImage("client");
        }
    }

    // Update the getProfileImageUrl method to use FileStorageUtil
    public String getProfileImageUrl() {
        if (hasProfileImage()) {
            return FileStorageUtil.getCdnUrl(profileImage);
        } else {
            return FileStorageUtil.getCdnUrl(FileStorageUtil.getDefaultProfileImage("client"));
        }
    }

    @Override
    public String toString() {
        return "Client{" +
                "clientId=" + clientId +
                ", username='" + username + '\'' +
                ", email='" + email + '\'' +
                ", fullName='" + fullName + '\'' +
                ", dateOfBirth=" + dateOfBirth +
                ", gender='" + gender + '\'' +
                '}';
    }
}
