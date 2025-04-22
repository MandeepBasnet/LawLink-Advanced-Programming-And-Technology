package model;

/**
 * LawyerAvailability class that represents a lawyer's availability on a specific day of the week
 */
public class LawyerAvailability {
    private int lawyerId;
    private String dayOfWeek;
    private boolean isAvailable;

    // Default constructor
    public LawyerAvailability() {
    }

    // Constructor with essential fields
    public LawyerAvailability(int lawyerId, String dayOfWeek, boolean isAvailable) {
        this.lawyerId = lawyerId;
        this.dayOfWeek = dayOfWeek;
        this.isAvailable = isAvailable;
    }

    // Getters and Setters
    public int getLawyerId() {
        return lawyerId;
    }

    public void setLawyerId(int lawyerId) {
        this.lawyerId = lawyerId;
    }

    public String getDayOfWeek() {
        return dayOfWeek;
    }

    public void setDayOfWeek(String dayOfWeek) {
        this.dayOfWeek = dayOfWeek;
    }

    public boolean isAvailable() {
        return isAvailable;
    }

    public void setAvailable(boolean available) {
        isAvailable = available;
    }

    @Override
    public String toString() {
        return "LawyerAvailability{" +
                "lawyerId=" + lawyerId +
                ", dayOfWeek='" + dayOfWeek + '\'' +
                ", isAvailable=" + isAvailable +
                '}';
    }
}
