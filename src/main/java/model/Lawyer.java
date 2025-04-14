package model;

import java.sql.Timestamp;
import util.FileStorageUtil;

/**
 * Represents a Lawyer in the LawLink system.
 */
public class Lawyer {
    private int lawyerId;
    private Integer adminId;
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

    // Lawyer-specific fields
    private String specialization;
    private String practiceAreas;
    private int experienceYears;
    private String education;
    private String licenseNumber;
    private String aboutMe;
    private double consultationFee;
    private boolean isVerified;
    private boolean isAvailable;
    private double rating;

    // Default constructor
    public Lawyer() {
    }

    // Constructor with essential fields
    public Lawyer(String username, String password, String email, String fullName,
                  String specialization, String practiceAreas, int experienceYears,
                  String education, String licenseNumber, double consultationFee) {
        this.username = username;
        this.password = password;
        this.email = email;
        this.fullName = fullName;
        this.specialization = specialization;
        this.practiceAreas = practiceAreas;
        this.experienceYears = experienceYears;
        this.education = education;
        this.licenseNumber = licenseNumber;
        this.consultationFee = consultationFee;
        this.isActive = true;
        this.isVerified = false;
        this.isAvailable = true;
        this.rating = 0.0;
    }

    // Full constructor
    public Lawyer(int lawyerId, String username, String password, String email, String fullName,
                  String phone, String address, Timestamp registrationDate, Timestamp lastLogin,
                  boolean isActive, String profileImage, String specialization, String practiceAreas,
                  int experienceYears, String education, String licenseNumber, String aboutMe,
                  double consultationFee, boolean isVerified, boolean isAvailable, double rating) {
        this.lawyerId = lawyerId;
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
        this.specialization = specialization;
        this.practiceAreas = practiceAreas;
        this.experienceYears = experienceYears;
        this.education = education;
        this.licenseNumber = licenseNumber;
        this.aboutMe = aboutMe;
        this.consultationFee = consultationFee;
        this.isVerified = isVerified;
        this.isAvailable = isAvailable;
        this.rating = rating;
    }

    // Getters and Setters
    public int getLawyerId() {
        return lawyerId;
    }

    public void setLawyerId(int lawyerId) {
        this.lawyerId = lawyerId;
    }

    public Integer getAdminId() {
        return adminId;
    }

    public void setAdminId(Integer adminId) {
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

    public String getSpecialization() {
        return specialization;
    }

    public void setSpecialization(String specialization) {
        this.specialization = specialization;
    }

    public String getPracticeAreas() {
        return practiceAreas;
    }

    public void setPracticeAreas(String practiceAreas) {
        this.practiceAreas = practiceAreas;
    }

    public int getExperienceYears() {
        return experienceYears;
    }

    public void setExperienceYears(int experienceYears) {
        this.experienceYears = experienceYears;
    }

    public String getEducation() {
        return education;
    }

    public void setEducation(String education) {
        this.education = education;
    }

    public String getLicenseNumber() {
        return licenseNumber;
    }

    public void setLicenseNumber(String licenseNumber) {
        this.licenseNumber = licenseNumber;
    }

    public String getAboutMe() {
        return aboutMe;
    }

    public void setAboutMe(String aboutMe) {
        this.aboutMe = aboutMe;
    }

    public double getConsultationFee() {
        return consultationFee;
    }

    public void setConsultationFee(double consultationFee) {
        this.consultationFee = consultationFee;
    }

    public boolean isVerified() {
        return isVerified;
    }

    public void setVerified(boolean verified) {
        isVerified = verified;
    }

    public boolean isAvailable() {
        return isAvailable;
    }

    public void setAvailable(boolean available) {
        isAvailable = available;
    }

    public double getRating() {
        return rating;
    }

    public void setRating(double rating) {
        this.rating = rating;
    }

    public boolean hasProfileImage() {
        return profileImage != null && !profileImage.isEmpty();
    }

    // Update the getProfileImageOrDefault method to use FileStorageUtil
    public String getProfileImageOrDefault() {
        if (hasProfileImage()) {
            return profileImage;
        } else {
            return FileStorageUtil.getDefaultProfileImage("lawyer");
        }
    }

    // Update the getProfileImageUrl method to use FileStorageUtil
    public String getProfileImageUrl() {
        if (hasProfileImage()) {
            return FileStorageUtil.getCdnUrl(profileImage);
        } else {
            return FileStorageUtil.getCdnUrl(FileStorageUtil.getDefaultProfileImage("lawyer"));
        }
    }

    @Override
    public String toString() {
        return "Lawyer{" +
                "lawyerId=" + lawyerId +
                ", username='" + username + '\'' +
                ", email='" + email + '\'' +
                ", fullName='" + fullName + '\'' +
                ", specialization='" + specialization + '\'' +
                ", experienceYears=" + experienceYears +
                ", rating=" + rating +
                ", isVerified=" + isVerified +
                ", isAvailable=" + isAvailable +
                '}';
    }
}
