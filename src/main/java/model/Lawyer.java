package model;

import java.math.BigDecimal;

/**
 * Lawyer class that extends User with lawyer-specific attributes
 */
public class Lawyer extends User {
    private int lawyerId;
    private String specialization;
    private String practiceAreas;
    private int experienceYears;
    private String education;
    private String licenseNumber;
    private String aboutMe;
    private BigDecimal consultationFee;
    private boolean isVerified;
    private boolean isAvailable;
    private BigDecimal rating;

    // Default constructor
    public Lawyer() {
        super();
        this.setRole("LAWYER");
    }

    // Constructor with essential fields
    public Lawyer(String username, String password, String email, String fullName,
                  String specialization, String practiceAreas, int experienceYears,
                  String education, String licenseNumber, BigDecimal consultationFee) {
        super(username, password, email, fullName, "LAWYER");
        this.specialization = specialization;
        this.practiceAreas = practiceAreas;
        this.experienceYears = experienceYears;
        this.education = education;
        this.licenseNumber = licenseNumber;
        this.consultationFee = consultationFee;
        this.isVerified = false;
        this.isAvailable = true;
        this.rating = new BigDecimal("0.0");
    }

    // Getters and Setters
    public int getLawyerId() {
        return lawyerId;
    }

    public void setLawyerId(int lawyerId) {
        this.lawyerId = lawyerId;
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

    public BigDecimal getConsultationFee() {
        return consultationFee;
    }

    public void setConsultationFee(BigDecimal consultationFee) {
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

    public BigDecimal getRating() {
        return rating;
    }

    public void setRating(BigDecimal rating) {
        this.rating = rating;
    }

    @Override
    public String toString() {
        return "Lawyer{" +
                "lawyerId=" + lawyerId +
                ", userId=" + getUserId() +
                ", fullName='" + getFullName() + '\'' +
                ", specialization='" + specialization + '\'' +
                ", experienceYears=" + experienceYears +
                ", consultationFee=" + consultationFee +
                ", isAvailable=" + isAvailable +
                '}';
    }
}
