package dao;

import model.Lawyer;
import util.DBConnectionUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

/**
 * Data Access Object for Lawyer entity
 */
public class LawyerDAO {

    private static final Logger LOGGER = Logger.getLogger(LawyerDAO.class.getName());
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
                LOGGER.warning("Failed to create user record for lawyer ID: " + lawyer.getUserId());
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
                LOGGER.info("Successfully created lawyer record for ID: " + lawyer.getUserId());
                return true;
            } else {
                conn.rollback();
                LOGGER.warning("Failed to create lawyer record for ID: " + lawyer.getUserId());
                return false;
            }
        } catch (SQLException e) {
            LOGGER.severe("Error creating lawyer: " + e.getMessage());
            try {
                if (conn != null) {
                    conn.rollback();
                }
            } catch (SQLException ex) {
                LOGGER.severe("Error rolling back transaction: " + ex.getMessage());
            }
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
                LOGGER.severe("Error closing resources: " + e.getMessage());
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
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = DBConnectionUtil.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, lawyerId);
            rs = stmt.executeQuery();
            if (rs.next()) {
                return mapResultSetToLawyer(rs);
            }
            LOGGER.info("No lawyer found for ID: " + lawyerId);
            return null;
        } catch (SQLException e) {
            LOGGER.severe("Error fetching lawyer by ID: " + lawyerId + ", " + e.getMessage());
            return null;
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                LOGGER.severe("Error closing resources: " + e.getMessage());
            }
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
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            conn = DBConnectionUtil.getConnection();
            stmt = conn.createStatement();
            rs = stmt.executeQuery(sql);
            while (rs.next()) {
                lawyers.add(mapResultSetToLawyer(rs));
            }
            LOGGER.info("Retrieved " + lawyers.size() + " lawyers");
            return lawyers;
        } catch (SQLException e) {
            LOGGER.severe("Error fetching all lawyers: " + e.getMessage());
            return lawyers;
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                LOGGER.severe("Error closing resources: " + e.getMessage());
            }
        }
    }

    /**
     * Get the first N lawyers from the database
     * @param limit Maximum number of lawyers to return
     * @return List of Lawyer objects
     */
    public List<Lawyer> getFirstLawyers(int limit) {
        String sql = "SELECT u.*, l.* FROM Users u " +
                "JOIN Lawyers l ON u.user_id = l.lawyer_id " +
                "WHERE u.is_active = TRUE AND l.is_available = TRUE " +
                "ORDER BY l.lawyer_id ASC LIMIT ?";
        List<Lawyer> lawyers = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = DBConnectionUtil.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, limit);
            rs = stmt.executeQuery();
            while (rs.next()) {
                lawyers.add(mapResultSetToLawyer(rs));
            }
            LOGGER.info("Retrieved " + lawyers.size() + " first lawyers with limit: " + limit);
            return lawyers;
        } catch (SQLException e) {
            LOGGER.severe("Error fetching first lawyers: " + e.getMessage());
            return lawyers;
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                LOGGER.severe("Error closing resources: " + e.getMessage());
            }
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
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = DBConnectionUtil.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, practiceArea);
            rs = stmt.executeQuery();
            while (rs.next()) {
                lawyers.add(mapResultSetToLawyer(rs));
            }
            LOGGER.info("Retrieved " + lawyers.size() + " lawyers for practice area: " + practiceArea);
            return lawyers;
        } catch (SQLException e) {
            LOGGER.severe("Error fetching lawyers by practice area: " + e.getMessage());
            return lawyers;
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                LOGGER.severe("Error closing resources: " + e.getMessage());
            }
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
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            conn = DBConnectionUtil.getConnection();
            stmt = conn.createStatement();
            rs = stmt.executeQuery(sql);
            while (rs.next()) {
                lawyers.add(mapResultSetToLawyer(rs));
            }
            LOGGER.info("Retrieved " + lawyers.size() + " available lawyers");
            return lawyers;
        } catch (SQLException e) {
            LOGGER.severe("Error fetching available lawyers: " + e.getMessage());
            return lawyers;
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                LOGGER.severe("Error closing resources: " + e.getMessage());
            }
        }
    }

    /**
     * Update a lawyer in the database
     * @param lawyer Lawyer object to update
     * @return true if successful, false otherwise
     */
    public boolean updateLawyer(Lawyer lawyer) throws SQLException {
        Connection conn = null;
        PreparedStatement userStmt = null;
        PreparedStatement lawyerStmt = null;

        try {
            conn = DBConnectionUtil.getConnection();
            conn.setAutoCommit(false);

            // Update Users table
            String userSql = "UPDATE Users SET full_name = ?, email = ?, phone = ?, address = ?, gender = ?, profile_image = ?, date_of_birth = ? WHERE user_id = ?";
            userStmt = conn.prepareStatement(userSql);
            userStmt.setString(1, lawyer.getFullName());
            userStmt.setString(2, lawyer.getEmail());
            userStmt.setString(3, lawyer.getPhone());
            userStmt.setString(4, lawyer.getAddress());
            userStmt.setString(5, lawyer.getGender());
            userStmt.setString(6, lawyer.getProfileImage());
            userStmt.setString(7, lawyer.getDateOfBirth());
            userStmt.setInt(8, lawyer.getUserId());

            LOGGER.info("Executing update query for Users table: userId=" + lawyer.getUserId() +
                    ", fullName=" + lawyer.getFullName() + ", email=" + lawyer.getEmail());

            int userRowsAffected = userStmt.executeUpdate();

            // Update Lawyers table
            String lawyerSql = "UPDATE Lawyers SET specialization = ?, practice_areas = ?, experience_years = ?, " +
                    "education = ?, license_number = ?, about_me = ?, consultation_fee = ?, " +
                    "is_verified = ?, is_available = ?, rating = ? WHERE lawyer_id = ?";
            lawyerStmt = conn.prepareStatement(lawyerSql);
            lawyerStmt.setString(1, lawyer.getSpecialization());
            lawyerStmt.setString(2, lawyer.getPracticeAreas());
            lawyerStmt.setInt(3, lawyer.getExperienceYears());
            lawyerStmt.setString(4, lawyer.getEducation());
            lawyerStmt.setString(5, lawyer.getLicenseNumber());
            lawyerStmt.setString(6, lawyer.getAboutMe());
            lawyerStmt.setBigDecimal(7, lawyer.getConsultationFee());
            lawyerStmt.setBoolean(8, lawyer.isVerified());
            lawyerStmt.setBoolean(9, lawyer.isAvailable());
            lawyerStmt.setBigDecimal(10, lawyer.getRating());
            lawyerStmt.setInt(11, lawyer.getLawyerId());

            LOGGER.info("Executing update query for Lawyers table: lawyerId=" + lawyer.getLawyerId());

            int lawyerRowsAffected = lawyerStmt.executeUpdate();

            if (userRowsAffected > 0 && lawyerRowsAffected > 0) {
                conn.commit();
                LOGGER.info("Successfully updated lawyer profile for userId: " + lawyer.getUserId());
                return true;
            } else {
                conn.rollback();
                LOGGER.warning("No rows affected: userRows=" + userRowsAffected + ", lawyerRows=" + lawyerRowsAffected +
                        " for userId: " + lawyer.getUserId());
                return false;
            }
        } catch (SQLException e) {
            LOGGER.severe("Error updating lawyer profile for userId: " + lawyer.getUserId() + ", " + e.getMessage());
            try {
                if (conn != null) {
                    conn.rollback();
                }
            } catch (SQLException ex) {
                LOGGER.severe("Error rolling back transaction: " + ex.getMessage());
            }
            throw e;
        } finally {
            try {
                if (userStmt != null) {
                    userStmt.close();
                }
                if (lawyerStmt != null) {
                    lawyerStmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                LOGGER.severe("Error closing resources: " + e.getMessage());
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
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = DBConnectionUtil.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setBoolean(1, isAvailable);
            stmt.setInt(2, lawyerId);
            int rowsAffected = stmt.executeUpdate();
            LOGGER.info("Updated availability for lawyerId: " + lawyerId + ", rowsAffected: " + rowsAffected);
            return rowsAffected > 0;
        } catch (SQLException e) {
            LOGGER.severe("Error updating lawyer availability: " + e.getMessage());
            return false;
        } finally {
            try {
                if (stmt != null) {
                    stmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                LOGGER.severe("Error closing resources: " + e.getMessage());
            }
        }
    }

    /**
     * Delete a lawyer from the database
     * @param lawyerId ID of the lawyer to delete
     * @return true if successful, false otherwise
     */
    public boolean deleteLawyer(int lawyerId) {
        boolean success = userDAO.deleteUser(lawyerId);
        LOGGER.info("Deleted lawyerId: " + lawyerId + ", success: " + success);
        return success;
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
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = DBConnectionUtil.getConnection();
            stmt = conn.prepareStatement(sql);
            String searchPattern = "%" + query + "%";
            stmt.setString(1, searchPattern);
            stmt.setString(2, searchPattern);
            rs = stmt.executeQuery();
            while (rs.next()) {
                lawyers.add(mapResultSetToLawyer(rs));
            }
            LOGGER.info("Found " + lawyers.size() + " lawyers for search query: " + query);
            return lawyers;
        } catch (SQLException e) {
            LOGGER.severe("Error searching lawyers: " + e.getMessage());
            return lawyers;
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                LOGGER.severe("Error closing resources: " + e.getMessage());
            }
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
        lawyer.setGender(rs.getString("gender"));
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
        String dateOfBirth = rs.getString("date_of_birth");
        lawyer.setDateOfBirth(dateOfBirth != null ? dateOfBirth : "");

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

    /**
     * Close method is a no-op as connections are managed per operation
     */
    public void close() throws SQLException {
        LOGGER.info("No connection to close; managed per operation");
    }
}
