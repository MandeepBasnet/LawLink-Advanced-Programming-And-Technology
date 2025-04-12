package model;


import java.sql.Date;
import java.sql.Time;
import java.sql.Timestamp;

/**
 * Represents an appointment between a lawyer and a client.
 */
public class Appointment {
    private int appointmentId;
    private int lawyerId;
    private int clientId;
    private Date appointmentDate;
    private Time appointmentTime;
    private int duration; // in minutes
    private String status; // PENDING, CONFIRMED, COMPLETED, CANCELLED
    private String notes;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    // Additional fields for convenience
    private Lawyer lawyer;
    private Client client;

    // Default constructor
    public Appointment() {
    }

    // Constructor with essential fields
    public Appointment(int lawyerId, int clientId, Date appointmentDate, Time appointmentTime, int duration) {
        this.lawyerId = lawyerId;
        this.clientId = clientId;
        this.appointmentDate = appointmentDate;
        this.appointmentTime = appointmentTime;
        this.duration = duration;
        this.status = "PENDING";
    }

    // Full constructor
    public Appointment(int appointmentId, int lawyerId, int clientId, Date appointmentDate,
                       Time appointmentTime, int duration, String status, String notes,
                       Timestamp createdAt, Timestamp updatedAt) {
        this.appointmentId = appointmentId;
        this.lawyerId = lawyerId;
        this.clientId = clientId;
        this.appointmentDate = appointmentDate;
        this.appointmentTime = appointmentTime;
        this.duration = duration;
        this.status = status;
        this.notes = notes;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    // Getters and Setters
    public int getAppointmentId() {
        return appointmentId;
    }

    public void setAppointmentId(int appointmentId) {
        this.appointmentId = appointmentId;
    }

    public int getLawyerId() {
        return lawyerId;
    }

    public void setLawyerId(int lawyerId) {
        this.lawyerId = lawyerId;
    }

    public int getClientId() {
        return clientId;
    }

    public void setClientId(int clientId) {
        this.clientId = clientId;
    }

    public Date getAppointmentDate() {
        return appointmentDate;
    }

    public void setAppointmentDate(Date appointmentDate) {
        this.appointmentDate = appointmentDate;
    }

    public Time getAppointmentTime() {
        return appointmentTime;
    }

    public void setAppointmentTime(Time appointmentTime) {
        this.appointmentTime = appointmentTime;
    }

    public int getDuration() {
        return duration;
    }

    public void setDuration(int duration) {
        this.duration = duration;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }

    public Lawyer getLawyer() {
        return lawyer;
    }

    public void setLawyer(Lawyer lawyer) {
        this.lawyer = lawyer;
    }

    public Client getClient() {
        return client;
    }

    public void setClient(Client client) {
        this.client = client;
    }

    @Override
    public String toString() {
        return "Appointment{" +
                "appointmentId=" + appointmentId +
                ", lawyerId=" + lawyerId +
                ", clientId=" + clientId +
                ", appointmentDate=" + appointmentDate +
                ", appointmentTime=" + appointmentTime +
                ", status='" + status + '\'' +
                '}';
    }
}

