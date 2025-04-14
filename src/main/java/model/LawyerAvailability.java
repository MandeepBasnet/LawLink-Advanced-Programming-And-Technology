package model;

/**
 * Represents a lawyer's availability for a specific day of the week.
 * By default, lawyers are available every day of the week.
 * This class is used to track days when a lawyer is NOT available.
 */
public class LawyerAvailability {
    private int lawyerId;
    private String dayOfWeek; // MONDAY, TUESDAY, etc.
    private boolean isAvailable;

    // Default constructor
    public LawyerAvailability() {
        // By default, lawyers are available
        this.isAvailable = true;
    }

    // Constructor with all fields
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
