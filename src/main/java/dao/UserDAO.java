package dao;

import model.User;
import util.DBConnectionUtil;
import util.PasswordUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Data Access Object for User entity
 */
public class UserDAO {
    private static final Logger LOGGER = Logger.getLogger(UserDAO.class.getName());
    private final Connection conn;

    public UserDAO() throws SQLException {
        conn = DBConnectionUtil.getConnection();
    }

    /**
     * Create a new user in the database
     * @param user User object to create
     * @return true if successful, false otherwise
     */
    public boolean createUser(User user) {
        String sql = "INSERT INTO users (username, password, email, full_name, phone, address, role, is_active) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            pstmt.setString(1, user.getUsername());
            pstmt.setString(2, user.getPassword());
            pstmt.setString(3, user.getEmail());
            pstmt.setString(4, user.getFullName());
            pstmt.setString(5, user.getPhone());
            pstmt.setString(6, user.getAddress());
            pstmt.setString(7, user.getRole());
            
            int affectedRows = pstmt.executeUpdate();
            
            if (affectedRows > 0) {
                try (ResultSet rs = pstmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        user.setUserId(rs.getInt(1));
                        return true;
                    }
                }
            }
            return false;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error creating user", e);
            return false;
        }
    }

    /**
     * Get a user by their ID
     * @param userId ID of the user to retrieve
     * @return User object if found, null otherwise
     */
    public User getUserById(int userId) {
        String sql = "SELECT * FROM Users WHERE user_id = ?";

        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToUser(rs);
                }
            }

            return null;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * Get a user by their username
     * @param username Username of the user to retrieve
     * @return User object if found, null otherwise
     */
    public User getUserByUsername(String username) {
        String sql = "SELECT * FROM users WHERE username = ?";
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, username);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    User user = new User();
                    user.setUserId(rs.getInt("user_id"));
                    user.setUsername(rs.getString("username"));
                    user.setPassword(rs.getString("password"));
                    user.setEmail(rs.getString("email"));
                    user.setFullName(rs.getString("full_name"));
                    user.setPhone(rs.getString("phone"));
                    user.setAddress(rs.getString("address"));
                    user.setRole(rs.getString("role"));
                    return user;
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting user by username", e);
        }
        return null;
    }

    /**
     * Get a user by their email
     * @param email Email of the user to retrieve
     * @return User object if found, null otherwise
     */
    public User getUserByEmail(String email) {
        String sql = "SELECT * FROM Users WHERE email = ?";

        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, email);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToUser(rs);
                }
            }

            return null;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * Get a user by their session token
     * @param sessionToken Session token of the user to retrieve
     * @return User object if found and token is valid, null otherwise
     */
    public User getUserBySessionToken(String sessionToken) {
        String sql = "SELECT * FROM Users WHERE session_token = ? AND session_expiry > NOW()";

        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, sessionToken);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToUser(rs);
                }
            }

            return null;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * Get all users from the database
     * @return List of User objects
     */
    public List<User> getAllUsers() {
        String sql = "SELECT * FROM Users";
        List<User> users = new ArrayList<>();

        try (Connection conn = DBConnectionUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                users.add(mapResultSetToUser(rs));
            }

            return users;
        } catch (SQLException e) {
            e.printStackTrace();
            return users;
        }
    }

    /**
     * Update a user in the database
     * @param user User object to update
     * @return true if successful, false otherwise
     * @throws SQLException if a database error occurs
     */
    public boolean updateUser(User user) throws SQLException {
        String sql = "UPDATE users SET username = ?, email = ?, full_name = ?, " +
                    "phone = ?, address = ?, gender = ? WHERE user_id = ?";
                    
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getFullName());
            stmt.setString(4, user.getPhone());
            stmt.setString(5, user.getAddress());
            stmt.setString(6, user.getGender());
            stmt.setInt(7, user.getUserId());
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating user: " + e.getMessage(), e);
            throw e;
        }
    }

    /**
     * Update a user's last login time
     * @param userId ID of the user to update
     * @return true if successful, false otherwise
     */
    public boolean updateLastLogin(int userId) {
        String sql = "UPDATE Users SET last_login = CURRENT_TIMESTAMP WHERE user_id = ?";

        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Update a user's session token
     * @param userId ID of the user to update
     * @param sessionToken Session token
     * @param sessionExpiry Session expiry timestamp
     * @return true if successful, false otherwise
     */
    public boolean updateSessionToken(int userId, String sessionToken, Timestamp sessionExpiry) {
        String sql = "UPDATE Users SET session_token = ?, session_expiry = ? WHERE user_id = ?";

        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, sessionToken);
            stmt.setTimestamp(2, sessionExpiry);
            stmt.setInt(3, userId);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }




    /**
     * Delete a user from the database
     * @param userId ID of the user to delete
     * @return true if successful, false otherwise
     */
    public boolean deleteUser(int userId) {
        String sql = "DELETE FROM Users WHERE user_id = ?";

        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }


    /**
     * Map a ResultSet to a User object
     * @param rs ResultSet to map
     * @return User object
     * @throws SQLException if a database access error occurs
     */
    private User mapResultSetToUser(ResultSet rs) throws SQLException {
        User user = new User();
        user.setUserId(rs.getInt("user_id"));
        user.setUsername(rs.getString("username"));
        user.setPassword(rs.getString("password"));
        user.setEmail(rs.getString("email"));
        user.setFullName(rs.getString("full_name"));
        user.setPhone(rs.getString("phone"));
        user.setAddress(rs.getString("address"));
        user.setRole(rs.getString("role"));
        return user;
    }

    /**
     * Register a new user
     * @param user User object to register
     * @return true if successful, false otherwise
     */
    public boolean registerUser(User user) {
        try {
            // Hash password using BCrypt
            String hashedPassword = PasswordUtil.hashPassword(user.getPassword());
            user.setPassword(hashedPassword);

            return createUser(user);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Failed to register user", e);
            return false;
        }
    }


    /**
     * Update a user's profile
     * @param user User object with updated profile information
     * @return true if successful, false otherwise
     */
    public boolean updateUserProfile(User user) {
        try {
            User existingUser = getUserById(user.getUserId());
            if (existingUser == null) {
                return false;
            }

            // Only update profile-related fields
            existingUser.setFullName(user.getFullName());
            existingUser.setPhone(user.getPhone());
            existingUser.setAddress(user.getAddress());
            existingUser.setProfileImage(user.getProfileImage());

            return updateUser(existingUser);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Failed to update user profile", e);
            return false;
        }
    }



    public List<User> getAllClients() throws SQLException {
        List<User> clients = new ArrayList<>();
        String sql = "SELECT * FROM users WHERE role = 'CLIENT'";
        
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                User client = new User();
                client.setUserId(rs.getInt("user_id"));
                client.setUsername(rs.getString("username"));
                client.setEmail(rs.getString("email"));
                client.setFullName(rs.getString("full_name"));
                client.setRole(rs.getString("role"));
                client.setPhone(rs.getString("phone"));
                client.setAddress(rs.getString("address"));
                client.setProfileImage(rs.getString("profile_image"));
                clients.add(client);
            }
        } catch (SQLException e) {
            LOGGER.severe("Error retrieving all clients: " + e.getMessage());
            throw e;
        }
        
        return clients;
    }



    public void close() {
        try {
            if (conn != null && !conn.isClosed()) {
                conn.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Helper method to check if a column exists in a table
    private boolean checkIfColumnExists(Connection conn, String tableName, String columnName) throws SQLException {
        ResultSet rs = null;
        try {
            // Get database metadata
            DatabaseMetaData meta = conn.getMetaData();
            rs = meta.getColumns(null, null, tableName, columnName);
            return rs.next(); // If rs.next() returns true, the column exists
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    LOGGER.warning("Error closing result set: " + e.getMessage());
                }
            }
        }
    }
}
