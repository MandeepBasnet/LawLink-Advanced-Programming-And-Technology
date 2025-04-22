package dao;

import model.Appointment;
import util.DBConnectionUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object for Appointment entity
 * This class handles database operations related to appointments
 */
public class AppointmentDAO {

    /**
     * Create a new appointment in the database
     * @param appointment Appointment object to create
     * @return true if successful, false otherwise
     */
    public boolean createAppointment(Appointment appointment) {
        String sql = "INSERT INTO Appointments (lawyer_id, client_id, appointment_date, appointment_time, " +
                "duration, status, notes) VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setInt(1, appointment.getLawyerId());
            stmt.setInt(2, appointment.getClientId());
            stmt.setDate(3, appointment.getAppointmentDate());
            stmt.setTime(4, appointment.getAppointmentTime());
            stmt.setInt(5, appointment.getDuration());
            stmt.setString(6, appointment.getStatus());
            stmt.setString(7, appointment.getNotes());

            int rowsAffected = stmt.executeUpdate();

            if (rowsAffected > 0) {
                // Get the generated appointment_id
                try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        appointment.setAppointmentId(generatedKeys.getInt(1));
                        return true;
                    }
                }
            }

            return false;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Get an appointment by its ID
     * @param appointmentId ID of the appointment to retrieve
     * @return Appointment object if found, null otherwise
     */
    public Appointment getAppointmentById(int appointmentId) {
        String sql = "SELECT a.*, u1.full_name AS lawyer_name, u2.full_name AS client_name, l.consultation_fee " +
                "FROM Appointments a " +
                "JOIN Lawyers l ON a.lawyer_id = l.lawyer_id " +
                "JOIN Users u1 ON l.lawyer_id = u1.user_id " +
                "JOIN Clients c ON a.client_id = c.client_id " +
                "JOIN Users u2 ON c.client_id = u2.user_id " +
                "WHERE a.appointment_id = ?";

        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, appointmentId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToAppointment(rs);
                }
            }

            return null;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * Get all appointments for a lawyer
     * @param lawyerId ID of the lawyer
     * @return List of Appointment objects
     */
    public List<Appointment> getAppointmentsByLawyer(int lawyerId) {
        String sql = "SELECT a.*, u1.full_name AS lawyer_name, u2.full_name AS client_name, l.consultation_fee " +
                "FROM Appointments a " +
                "JOIN Lawyers l ON a.lawyer_id = l.lawyer_id " +
                "JOIN Users u1 ON l.lawyer_id = u1.user_id " +
                "JOIN Clients c ON a.client_id = c.client_id " +
                "JOIN Users u2 ON c.client_id = u2.user_id " +
                "WHERE a.lawyer_id = ? " +
                "ORDER BY a.appointment_date DESC, a.appointment_time DESC";

        List<Appointment> appointments = new ArrayList<>();

        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, lawyerId);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    appointments.add(mapResultSetToAppointment(rs));
                }
            }

            return appointments;
        } catch (SQLException e) {
            e.printStackTrace();
            return appointments;
        }
    }

    /**
     * Get upcoming appointments for a lawyer
     * @param lawyerId ID of the lawyer
     * @param limit Maximum number of appointments to return
     * @return List of Appointment objects
     */
    public List<Appointment> getUpcomingAppointmentsByLawyer(int lawyerId, int limit) {
        String sql = "SELECT a.*, u1.full_name AS lawyer_name, u2.full_name AS client_name, l.consultation_fee " +
                "FROM Appointments a " +
                "JOIN Lawyers l ON a.lawyer_id = l.lawyer_id " +
                "JOIN Users u1 ON l.lawyer_id = u1.user_id " +
                "JOIN Clients c ON a.client_id = c.client_id " +
                "JOIN Users u2 ON c.client_id = u2.user_id " +
                "WHERE a.lawyer_id = ? AND a.appointment_date >= CURDATE() " +
                "AND (a.status = 'PENDING' OR a.status = 'CONFIRMED') " +
                "ORDER BY a.appointment_date ASC, a.appointment_time ASC " +
                "LIMIT ?";

        List<Appointment> appointments = new ArrayList<>();

        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, lawyerId);
            stmt.setInt(2, limit);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    appointments.add(mapResultSetToAppointment(rs));
                }
            }

            return appointments;
        } catch (SQLException e) {
            e.printStackTrace();
            return appointments;
        }
    }

    /**
     * Get all appointments for a client
     * @param clientId ID of the client
     * @return List of Appointment objects
     */
    public List<Appointment> getAppointmentsByClient(int clientId) {
        String sql = "SELECT a.*, u1.full_name AS lawyer_name, u2.full_name AS client_name, l.consultation_fee " +
                "FROM Appointments a " +
                "JOIN Lawyers l ON a.lawyer_id = l.lawyer_id " +
                "JOIN Users u1 ON l.lawyer_id = u1.user_id " +
                "JOIN Clients c ON a.client_id = c.client_id " +
                "JOIN Users u2 ON c.client_id = u2.user_id " +
                "WHERE a.client_id = ? " +
                "ORDER BY a.appointment_date DESC, a.appointment_time DESC";

        List<Appointment> appointments = new ArrayList<>();

        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, clientId);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    appointments.add(mapResultSetToAppointment(rs));
                }
            }

            return appointments;
        } catch (SQLException e) {
            e.printStackTrace();
            return appointments;
        }
    }

    /**
     * Get all appointments
     * @return List of Appointment objects
     */
    public List<Appointment> getAllAppointments() {
        String sql = "SELECT a.*, u1.full_name AS lawyer_name, u2.full_name AS client_name, l.consultation_fee " +
                "FROM Appointments a " +
                "JOIN Lawyers l ON a.lawyer_id = l.lawyer_id " +
                "JOIN Users u1 ON l.lawyer_id = u1.user_id " +
                "JOIN Clients c ON a.client_id = c.client_id " +
                "JOIN Users u2 ON c.client_id = u2.user_id " +
                "ORDER BY a.appointment_date DESC, a.appointment_time DESC";

        List<Appointment> appointments = new ArrayList<>();

        try (Connection conn = DBConnectionUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                appointments.add(mapResultSetToAppointment(rs));
            }

            return appointments;
        } catch (SQLException e) {
            e.printStackTrace();
            return appointments;
        }
    }

    /**
     * Get recent appointments
     * @param limit Maximum number of appointments to return
     * @return List of Appointment objects
     */
    public List<Appointment> getRecentAppointments(int limit) {
        String sql = "SELECT a.*, u1.full_name AS lawyer_name, u2.full_name AS client_name, l.consultation_fee " +
                "FROM Appointments a " +
                "JOIN Lawyers l ON a.lawyer_id = l.lawyer_id " +
                "JOIN Users u1 ON l.lawyer_id = u1.user_id " +
                "JOIN Clients c ON a.client_id = c.client_id " +
                "JOIN Users u2 ON c.client_id = u2.user_id " +
                "ORDER BY a.created_at DESC " +
                "LIMIT ?";

        List<Appointment> appointments = new ArrayList<>();

        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, limit);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    appointments.add(mapResultSetToAppointment(rs));
                }
            }

            return appointments;
        } catch (SQLException e) {
            e.printStackTrace();
            return appointments;
        }
    }

    /**
     * Update an appointment's status
     * @param appointmentId Appointment ID
     * @param status New status
     * @return true if successful, false otherwise
     */
    public boolean updateAppointmentStatus(int appointmentId, String status) {
        String sql = "UPDATE Appointments SET status = ? WHERE appointment_id = ?";

        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, status);
            stmt.setInt(2, appointmentId);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Check if a lawyer is available at a specific date and time
     * @param lawyerId Lawyer ID
     * @param appointmentDate Date to check
     * @param appointmentTime Time to check
     * @return true if available, false otherwise
     */
    public boolean isLawyerAvailable(int lawyerId, Date appointmentDate, Time appointmentTime) {
        String sql = "SELECT COUNT(*) FROM Appointments " +
                "WHERE lawyer_id = ? AND appointment_date = ? AND appointment_time = ? " +
                "AND status != 'CANCELLED'";

        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, lawyerId);
            stmt.setDate(2, appointmentDate);
            stmt.setTime(3, appointmentTime);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) == 0;
                }
            }

            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Map a ResultSet to an Appointment object
     * @param rs ResultSet to map
     * @return Appointment object
     * @throws SQLException if a database access error occurs
     */
    private Appointment mapResultSetToAppointment(ResultSet rs) throws SQLException {
        Appointment appointment = new Appointment();
        appointment.setAppointmentId(rs.getInt("appointment_id"));
        appointment.setLawyerId(rs.getInt("lawyer_id"));
        appointment.setClientId(rs.getInt("client_id"));
        appointment.setAppointmentDate(rs.getDate("appointment_date"));
        appointment.setAppointmentTime(rs.getTime("appointment_time"));
        appointment.setDuration(rs.getInt("duration"));
        appointment.setStatus(rs.getString("status"));
        appointment.setNotes(rs.getString("notes"));
        appointment.setCreatedAt(rs.getTimestamp("created_at"));
        appointment.setUpdatedAt(rs.getTimestamp("updated_at"));

        // Additional fields for display purposes
        appointment.setLawyerName(rs.getString("lawyer_name"));
        appointment.setClientName(rs.getString("client_name"));
        appointment.setConsultationFee(rs.getBigDecimal("consultation_fee"));

        return appointment;
    }
}
