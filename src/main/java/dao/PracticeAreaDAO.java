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
