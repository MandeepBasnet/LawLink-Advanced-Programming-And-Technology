package dao;

import model.Lawyer;
import util.DBConnectionUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object for Lawyer entity
 */
public class LawyerDAO {

    private UserDAO userDAO;

    /**
     * Constructor for LawyerDAO
     * @throws SQLException if there is an error initializing the UserDAO
     */
    public LawyerDAO() throws SQLException {
        this.userDAO = new UserDAO();
    }

    /**
     * Create a new lawyer in the database
     * @param lawyer Lawyer object to create
     * @return true if successful, false otherwise
     */
    public boolean createLawyer(Lawyer lawyer) {
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = DBConnectionUtil.getConnection();
            conn.setAutoCommit(false);

            // First, create the user record
            boolean userCreated = userDAO.createUser(lawyer);

            if (!userCreated) {
                conn.rollback();
                return false;
            }

            // Then, create the lawyer record
            String sql = "INSERT INTO Lawyers (lawyer_id, specialization, practice_areas, experience_years, " +
                    "education, license_number, about_me, consultation_fee, is_verified, is_available) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, lawyer.getUserId());
            stmt.setString(2, lawyer.getSpecialization());
            stmt.setString(3, lawyer.getPracticeAreas());
            stmt.setInt(4, lawyer.getExperienceYears());
            stmt.setString(5, lawyer.getEducation());
            stmt.setString(6, lawyer.getLicenseNumber());
            stmt.setString(7, lawyer.getAboutMe());
            stmt.setBigDecimal(8, lawyer.getConsultationFee());
            stmt.setBoolean(9, lawyer.isVerified());
            stmt.setBoolean(10, lawyer.isAvailable());

            int rowsAffected = stmt.executeUpdate();

            if (rowsAffected > 0) {
                lawyer.setLawyerId(lawyer.getUserId());
                conn.commit();
                return true;
            } else {
                conn.rollback();
                return false;
            }
        } catch (SQLException e) {
            try {
                if (conn != null) {
                    conn.rollback();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (stmt != null) {
                    stmt.close();
                }
                if (conn != null) {
                    conn.setAutoCommit(true);
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    /**
     * Get a lawyer by their ID
     * @param lawyerId ID of the lawyer to retrieve
     * @return Lawyer object if found, null otherwise
     */
    public Lawyer getLawyerById(int lawyerId) {
        String sql = "SELECT u.*, l.* FROM Users u " +
                "JOIN Lawyers l ON u.user_id = l.lawyer_id " +
                "WHERE l.lawyer_id = ?";

        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, lawyerId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToLawyer(rs);
                }
            }

            return null;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * Get all lawyers from the database
     * @return List of Lawyer objects
     */
    public List<Lawyer> getAllLawyers() {
        String sql = "SELECT u.*, l.* FROM Users u " +
                "JOIN Lawyers l ON u.user_id = l.lawyer_id";
        List<Lawyer> lawyers = new ArrayList<>();

        try (Connection conn = DBConnectionUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                lawyers.add(mapResultSetToLawyer(rs));
            }

            return lawyers;
        } catch (SQLException e) {
            e.printStackTrace();
            return lawyers;
        }
    }


    /**
     * Get lawyers by practice area
     * @param practiceArea Practice area to filter by
     * @return List of Lawyer objects
     */
    public List<Lawyer> getLawyersByPracticeArea(String practiceArea) {
        String sql = "SELECT u.*, l.* FROM Users u " +
                "JOIN Lawyers l ON u.user_id = l.lawyer_id " +
                "JOIN LawyerPracticeAreas lpa ON l.lawyer_id = lpa.lawyer_id " +
                "JOIN PracticeAreas pa ON lpa.area_id = pa.area_id " +
                "WHERE pa.area_name = ?";
        List<Lawyer> lawyers = new ArrayList<>();

        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, practiceArea);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    lawyers.add(mapResultSetToLawyer(rs));
                }
            }

            return lawyers;
        } catch (SQLException e) {
            e.printStackTrace();
            return lawyers;
        }
    }

    /**
     * Get available lawyers
     * @return List of available Lawyer objects
     */
    public List<Lawyer> getAvailableLawyers() {
        String sql = "SELECT u.*, l.* FROM Users u " +
                "JOIN Lawyers l ON u.user_id = l.lawyer_id " +
                "WHERE l.is_available = TRUE";
        List<Lawyer> lawyers = new ArrayList<>();

        try (Connection conn = DBConnectionUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                lawyers.add(mapResultSetToLawyer(rs));
            }

            return lawyers;
        } catch (SQLException e) {
            e.printStackTrace();
            return lawyers;
        }
    }

    /**
     * Update a lawyer in the database
     * @param lawyer Lawyer object to update
     * @return true if successful, false otherwise
     */
    public boolean updateLawyer(Lawyer lawyer) {
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = DBConnectionUtil.getConnection();
            conn.setAutoCommit(false);

            // First, update the user record
            boolean userUpdated = userDAO.updateUser(lawyer);

            if (!userUpdated) {
                conn.rollback();
                return false;
            }

            // Then, update the lawyer record
            String sql = "UPDATE Lawyers SET specialization = ?, practice_areas = ?, experience_years = ?, " +
                    "education = ?, license_number = ?, about_me = ?, consultation_fee = ?, " +
                    "is_verified = ?, is_available = ?, rating = ? WHERE lawyer_id = ?";

            stmt = conn.prepareStatement(sql);
            stmt.setString(1, lawyer.getSpecialization());
            stmt.setString(2, lawyer.getPracticeAreas());
            stmt.setInt(3, lawyer.getExperienceYears());
            stmt.setString(4, lawyer.getEducation());
            stmt.setString(5, lawyer.getLicenseNumber());
            stmt.setString(6, lawyer.getAboutMe());
            stmt.setBigDecimal(7, lawyer.getConsultationFee());
            stmt.setBoolean(8, lawyer.isVerified());
            stmt.setBoolean(9, lawyer.isAvailable());
            stmt.setBigDecimal(10, lawyer.getRating());
            stmt.setInt(11, lawyer.getLawyerId());

            int rowsAffected = stmt.executeUpdate();

            if (rowsAffected > 0) {
                conn.commit();
                return true;
            } else {
                conn.rollback();
                return false;
            }
        } catch (SQLException e) {
            try {
                if (conn != null) {
                    conn.rollback();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (stmt != null) {
                    stmt.close();
                }
                if (conn != null) {
                    conn.setAutoCommit(true);
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    /**
     * Update a lawyer's availability
     * @param lawyerId ID of the lawyer to update
     * @param isAvailable New availability status
     * @return true if successful, false otherwise
     */
    public boolean updateLawyerAvailability(int lawyerId, boolean isAvailable) {
        String sql = "UPDATE Lawyers SET is_available = ? WHERE lawyer_id = ?";

        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setBoolean(1, isAvailable);
            stmt.setInt(2, lawyerId);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Delete a lawyer from the database
     * @param lawyerId ID of the lawyer to delete
     * @return true if successful, false otherwise
     */
    public boolean deleteLawyer(int lawyerId) {
        // This will cascade to delete the lawyer record due to ON DELETE CASCADE
        return userDAO.deleteUser(lawyerId);
    }

    /**
     * Search for lawyers by name or specialization
     * @param query Search query
     * @return List of matching Lawyer objects
     */
    public List<Lawyer> searchLawyers(String query) {
        String sql = "SELECT u.*, l.* FROM Users u " +
                "JOIN Lawyers l ON u.user_id = l.lawyer_id " +
                "WHERE u.full_name LIKE ? OR l.specialization LIKE ?";
        List<Lawyer> lawyers = new ArrayList<>();

        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            String searchPattern = "%" + query + "%";
            stmt.setString(1, searchPattern);
            stmt.setString(2, searchPattern);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    lawyers.add(mapResultSetToLawyer(rs));
                }
            }

            return lawyers;
        } catch (SQLException e) {
            e.printStackTrace();
            return lawyers;
        }
    }

    /**
     * Map a ResultSet to a Lawyer object
     * @param rs ResultSet to map
     * @return Lawyer object
     * @throws SQLException if a database access error occurs
     */
    private Lawyer mapResultSetToLawyer(ResultSet rs) throws SQLException {
        Lawyer lawyer = new Lawyer();

        // Map User fields
        lawyer.setUserId(rs.getInt("user_id"));
        lawyer.setUsername(rs.getString("username"));
        lawyer.setPassword(rs.getString("password"));
        lawyer.setEmail(rs.getString("email"));
        lawyer.setFullName(rs.getString("full_name"));
        lawyer.setPhone(rs.getString("phone"));
        lawyer.setAddress(rs.getString("address"));
        lawyer.setRole(rs.getString("role"));
        lawyer.setRegistrationDate(rs.getTimestamp("registration_date"));
        lawyer.setLastLogin(rs.getTimestamp("last_login"));
        lawyer.setActive(rs.getBoolean("is_active"));
        lawyer.setProfileImage(rs.getString("profile_image"));
        lawyer.setSessionToken(rs.getString("session_token"));
        lawyer.setSessionExpiry(rs.getTimestamp("session_expiry"));
        lawyer.setResetToken(rs.getString("reset_token"));
        lawyer.setResetTokenExpiry(rs.getTimestamp("reset_token_expiry"));
        lawyer.setOtp(rs.getString("otp"));
        lawyer.setOtpExpiry(rs.getTimestamp("otp_expiry"));

        // Map Lawyer fields
        lawyer.setLawyerId(rs.getInt("lawyer_id"));
        lawyer.setSpecialization(rs.getString("specialization"));
        lawyer.setPracticeAreas(rs.getString("practice_areas"));
        lawyer.setExperienceYears(rs.getInt("experience_years"));
        lawyer.setEducation(rs.getString("education"));
        lawyer.setLicenseNumber(rs.getString("license_number"));
        lawyer.setAboutMe(rs.getString("about_me"));
        lawyer.setConsultationFee(rs.getBigDecimal("consultation_fee"));
        lawyer.setVerified(rs.getBoolean("is_verified"));
        lawyer.setAvailable(rs.getBoolean("is_available"));
        lawyer.setRating(rs.getBigDecimal("rating"));

        return lawyer;
    }
}
