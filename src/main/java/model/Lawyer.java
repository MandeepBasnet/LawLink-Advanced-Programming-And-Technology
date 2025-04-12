package model;

import java.util.List;

/**
 * Represents a lawyer in the LawLink system.
 * Contains professional information about the lawyer.
 */
public class Lawyer {
    private int lawyerId;
    private int userId;
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
    // Removed profileImage field as we're now using User's profilePicture
    private User user; // Associated user object
    private List<String> availabilitySchedule; // Simplified representation of availability

    // Default constructor
    public Lawyer() {
    }

    // Constructor with essential fields
    public Lawyer(int userId, String specialization, String practiceAreas, int experienceYears,
                  String education, String licenseNumber, double consultationFee) {
        this.userId = userId;
        this.specialization = specialization;
        this.practiceAreas = practiceAreas;
        this.experienceYears = experienceYears;
        this.education = education;
        this.licenseNumber = licenseNumber;
        this.consultationFee = consultationFee;
        this.isVerified = false;
        this.isAvailable = true;
        this.rating = 0.0;
    }

    // Full constructor
    public Lawyer(int lawyerId, int userId, String specialization, String practiceAreas,
                  int experienceYears, String education, String licenseNumber, String aboutMe,
                  double consultationFee, boolean isVerified, boolean isAvailable,
                  double rating) {
        this.lawyerId = lawyerId;
        this.userId = userId;
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

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
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

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public List<String> getAvailabilitySchedule() {
        return availabilitySchedule;
    }

    public void setAvailabilitySchedule(List<String> availabilitySchedule) {
        this.availabilitySchedule = availabilitySchedule;
    }

    @Override
    public String toString() {
        return "Lawyer{" +
                "lawyerId=" + lawyerId +
                ", userId=" + userId +
                ", specialization='" + specialization + '\'' +
                ", experienceYears=" + experienceYears +
                ", consultationFee=" + consultationFee +
                ", isVerified=" + isVerified +
                ", isAvailable=" + isAvailable +
                ", rating=" + rating +
                '}';
    }
}

