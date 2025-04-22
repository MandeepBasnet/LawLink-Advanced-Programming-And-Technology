package dao;

import model.PracticeArea;
import util.DBConnectionUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object for PracticeArea entity
 */
public class PracticeAreaDAO {

    /**
     * Create a new practice area in the database
     * @param practiceArea PracticeArea object to create
     * @return true if successful, false otherwise
     */
    public boolean createPracticeArea(PracticeArea practiceArea) {
        String sql = "INSERT INTO PracticeAreas (area_name, description) VALUES (?, ?)";

        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setString(1, practiceArea.getAreaName());
            stmt.setString(2, practiceArea.getDescription());

            int rowsAffected = stmt.executeUpdate();

            if (rowsAffected > 0) {
                // Get the generated area_id
                try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        practiceArea.setAreaId(generatedKeys.getInt(1));
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
     * Get a practice area by its ID
     * @param areaId ID of the practice area to retrieve
     * @return PracticeArea object if found, null otherwise
     */
    public PracticeArea getPracticeAreaById(int areaId) {
        String sql = "SELECT * FROM PracticeAreas WHERE area_id = ?";

        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, areaId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToPracticeArea(rs);
                }
            }

            return null;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * Get all practice areas from the database
     * @return List of PracticeArea objects
     */
    public List<PracticeArea> getAllPracticeAreas() {
        String sql = "SELECT * FROM PracticeAreas ORDER BY area_name";
        List<PracticeArea> practiceAreas = new ArrayList<>();

        try (Connection conn = DBConnectionUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                practiceAreas.add(mapResultSetToPracticeArea(rs));
            }

            return practiceAreas;
        } catch (SQLException e) {
            e.printStackTrace();
            return practiceAreas;
        }
    }

    /**
     * Update a practice area in the database
     * @param practiceArea PracticeArea object to update
     * @return true if successful, false otherwise
     */
    public boolean updatePracticeArea(PracticeArea practiceArea) {
        String sql = "UPDATE PracticeAreas SET area_name = ?, description = ? WHERE area_id = ?";

        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, practiceArea.getAreaName());
            stmt.setString(2, practiceArea.getDescription());
            stmt.setInt(3, practiceArea.getAreaId());

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Delete a practice area from the database
     * @param areaId ID of the practice area to delete
     * @return true if successful, false otherwise
     */
    public boolean deletePracticeArea(int areaId) {
        String sql = "DELETE FROM PracticeAreas WHERE area_id = ?";

        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, areaId);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Get practice areas for a specific lawyer
     * @param lawyerId Lawyer ID
     * @return List of PracticeArea objects
     */
    public List<PracticeArea> getPracticeAreasByLawyer(int lawyerId) {
        String sql = "SELECT pa.* FROM PracticeAreas pa " +
                "JOIN LawyerPracticeAreas lpa ON pa.area_id = lpa.area_id " +
                "WHERE lpa.lawyer_id = ? " +
                "ORDER BY pa.area_name";
        List<PracticeArea> practiceAreas = new ArrayList<>();

        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, lawyerId);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    practiceAreas.add(mapResultSetToPracticeArea(rs));
                }
            }

            return practiceAreas;
        } catch (SQLException e) {
            e.printStackTrace();
            return practiceAreas;
        }
    }

    /**
     * Map a ResultSet to a PracticeArea object
     * @param rs ResultSet to map
     * @return PracticeArea object
     * @throws SQLException if a database access error occurs
     */
    private PracticeArea mapResultSetToPracticeArea(ResultSet rs) throws SQLException {
        PracticeArea practiceArea = new PracticeArea();
        practiceArea.setAreaId(rs.getInt("area_id"));
        practiceArea.setAreaName(rs.getString("area_name"));
        practiceArea.setDescription(rs.getString("description"));

        // Check if the image column exists in the result set
        try {
            practiceArea.setImage(rs.getString("image"));
        } catch (SQLException e) {
            // Image column doesn't exist, ignore
        }

        return practiceArea;
    }
}
