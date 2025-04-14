package model;

import java.sql.Date;
import java.sql.Time;

/**
 * Represents a specific time slot for a lawyer.
 */
public class LawyerTimeSlot {
    private int slotId;
    private int lawyerId;
    private Date slotDate;
    private Time startTime;
    private Time endTime;
    private boolean isAvailable;
    private Integer appointmentId;

    // Default constructor
    public LawyerTimeSlot() {
    }

    // Constructor with essential fields
    public LawyerTimeSlot(int lawyerId, Date slotDate, Time startTime, Time endTime, boolean isAvailable) {
        this.lawyerId = lawyerId;
        this.slotDate = slotDate;
        this.startTime = startTime;
        this.endTime = endTime;
        this.isAvailable = isAvailable;
    }

    // Full constructor
    public LawyerTimeSlot(int slotId, int lawyerId, Date slotDate, Time startTime, Time endTime,
                          boolean isAvailable, Integer appointmentId) {
        this.slotId = slotId;
        this.lawyerId = lawyerId;
        this.slotDate = slotDate;
        this.startTime = startTime;
        this.endTime = endTime;
        this.isAvailable = isAvailable;
        this.appointmentId = appointmentId;
    }

    // Getters and Setters
    public int getSlotId() {
        return slotId;
    }

    public void setSlotId(int slotId) {
        this.slotId = slotId;
    }

    public int getLawyerId() {
        return lawyerId;
    }

    public void setLawyerId(int lawyerId) {
        this.lawyerId = lawyerId;
    }

    public Date getSlotDate() {
        return slotDate;
    }

    public void setSlotDate(Date slotDate) {
        this.slotDate = slotDate;
    }

    public Time getStartTime() {
        return startTime;
    }

    public void setStartTime(Time startTime) {
        this.startTime = startTime;
    }

    public Time getEndTime() {
        return endTime;
    }

    public void setEndTime(Time endTime) {
        this.endTime = endTime;
    }

    public boolean isAvailable() {
        return isAvailable;
    }

    public void setAvailable(boolean available) {
        isAvailable = available;
    }

    public Integer getAppointmentId() {
        return appointmentId;
    }

    public void setAppointmentId(Integer appointmentId) {
        this.appointmentId = appointmentId;
    }

    @Override
    public String toString() {
        return "LawyerTimeSlot{" +
                "slotId=" + slotId +
                ", lawyerId=" + lawyerId +
                ", slotDate=" + slotDate +
                ", startTime=" + startTime +
                ", endTime=" + endTime +
                ", isAvailable=" + isAvailable +
                ", appointmentId=" + appointmentId +
                '}';
    }
}
