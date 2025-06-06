package dao;

import model.User;
import util.DBConnectionUtil;
import util.PasswordUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.Part;

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
        String sql = "INSERT INTO users (username, password, email, full_name, phone, address, role, is_active, profile_image) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            pstmt.setString(1, user.getUsername());
            pstmt.setString(2, user.getPassword());
            pstmt.setString(3, user.getEmail());
            pstmt.setString(4, user.getFullName());
            pstmt.setString(5, user.getPhone());
            pstmt.setString(6, user.getAddress());
            pstmt.setString(7, user.getRole());
            pstmt.setBoolean(8, user.isActive());
            pstmt.setString(9, user.getProfileImage());

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
     * Register a new user with optional profile image
     * @param user User object to register
     * @param profilePicturePart The uploaded profile picture part
     * @param servletContext Servlet context for file storage
     * @return true if successful, false otherwise
     */
    public boolean registerUser(User user, Part profilePicturePart, ServletContext servletContext) {
        try {
            String hashedPassword = PasswordUtil.hashPassword(user.getPassword());
            user.setPassword(hashedPassword);
            System.out.println("Hashed password for user: " + user.getUsername());

            if (profilePicturePart != null && profilePicturePart.getSize() > 0) {
                String fileName = getSubmittedFileName(profilePicturePart);
                if (fileName != null && !fileName.isEmpty()) {
                    String extension = fileName.substring(fileName.lastIndexOf("."));
                    String uniqueFileName = java.util.UUID.randomUUID().toString() + extension;
                    String uploadPath = servletContext.getRealPath("") + java.io.File.separator + "uploads/users";
                    java.io.File uploadDir = new java.io.File(uploadPath);
                    if (!uploadDir.exists()) {
                        uploadDir.mkdirs();
                    }
                    java.nio.file.Files.copy(profilePicturePart.getInputStream(), java.nio.file.Paths.get(uploadPath, uniqueFileName), java.nio.file.StandardCopyOption.REPLACE_EXISTING);
                    String profileImagePath = "uploads/users/" + uniqueFileName;
                    user.setProfileImage(profileImagePath);
                    System.out.println("Profile image saved: " + profileImagePath);
                }
            } else {
                System.out.println("No profile picture provided");
                user.setProfileImage(null);
            }

            boolean success = createUser(user);
            System.out.println("User creation success: " + success);
            return success;
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Failed to register user: " + e.getMessage(), e);
            if (user.getProfileImage() != null) {
                String uploadPath = servletContext.getRealPath("") + java.io.File.separator + user.getProfileImage();
                try {
                    java.nio.file.Files.deleteIfExists(java.nio.file.Paths.get(uploadPath));
                    System.out.println("Cleaned up profile image: " + user.getProfileImage());
                } catch (java.io.IOException ex) {
                    LOGGER.warning("Failed to clean up profile image: " + user.getProfileImage());
                }
            }
            return false;
        }
    }

    /**
     * Get a user by their ID
     * @param userId ID of the user to retrieve
     * @return User object if found, null otherwise
     */
    public User getUserById(int userId) {
        String sql = "SELECT u.*, u.date_of_birth FROM Users u LEFT JOIN Clients c ON u.user_id = c.client_id WHERE u.user_id = ?";

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
            LOGGER.log(Level.SEVERE, "Error getting user by ID", e);
            return null;
        }
    }


    /**
     * Get a user by their email
     * @param email Email of the user to retrieve
     * @return User object if found, null otherwise
     */
    public User getUserByEmail(String email) {
        String sql = "SELECT u.*, u.date_of_birth FROM Users u LEFT JOIN Clients c ON u.user_id = c.client_id WHERE u.email = ?";

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
            LOGGER.log(Level.SEVERE, "Error getting user by email", e);
            return null;
        }
    }

    /**
     * Get a user by their session token
     * @param sessionToken Session token of the user to retrieve
     * @return User object if found and token is valid, null otherwise
     */
    public User getUserBySessionToken(String sessionToken) {
        String sql = "SELECT u.*, c.date_of_birth FROM Users u LEFT JOIN Clients c ON u.user_id = c.client_id WHERE u.session_token = ? AND u.session_expiry > NOW()";

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
            LOGGER.log(Level.SEVERE, "Error getting user by session token", e);
            return null;
        }
    }

    /**
     * Get all users from the database
     * @return List of User objects
     */
    public List<User> getAllUsers() {
        String sql = "SELECT u.*, c.date_of_birth FROM Users u LEFT JOIN Clients c ON u.user_id = c.client_id";
        List<User> users = new ArrayList<>();

        try (Connection conn = DBConnectionUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                users.add(mapResultSetToUser(rs));
            }

            return users;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting all users", e);
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
                "phone = ?, address = ?, gender = ?, profile_image = ?, date_of_birth = ? WHERE user_id = ?";

        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getFullName());
            stmt.setString(4, user.getPhone());
            stmt.setString(5, user.getAddress());
            stmt.setString(6, user.getGender());
            stmt.setString(7, user.getProfileImage());
            stmt.setString(8, user.getDateOfBirth());
            stmt.setInt(9, user.getUserId());

            int rowsAffected = stmt.executeUpdate();

            // Update gender in Clients table if user is a client
            if ("CLIENT".equals(user.getRole())) {
                String clientSql = "INSERT INTO Clients (client_id, gender) " +
                        "VALUES (?, ?) ON DUPLICATE KEY UPDATE gender = ?";
                try (PreparedStatement clientStmt = conn.prepareStatement(clientSql)) {
                    clientStmt.setInt(1, user.getUserId());
                    clientStmt.setString(2, user.getGender());
                    clientStmt.setString(3, user.getGender());
                    clientStmt.executeUpdate();
                }
            }

            return rowsAffected > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating user: " + e.getMessage(), e);
            throw e;
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
            LOGGER.log(Level.SEVERE, "Error deleting user", e);
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
        user.setProfileImage(rs.getString("profile_image"));
        user.setGender(rs.getString("gender"));
        user.setDateOfBirth(rs.getString("date_of_birth"));
        return user;
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
            existingUser.setEmail(user.getEmail());
            existingUser.setGender(user.getGender());
            existingUser.setDateOfBirth(user.getDateOfBirth());

            return updateUser(existingUser);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Failed to update user profile", e);
            return false;
        }
    }


    public void close() {
        try {
            if (conn != null && !conn.isClosed()) {
                conn.close();
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error closing connection", e);
        }
    }


    private String getSubmittedFileName(Part part) {
        for (String content : part.getHeader("content-disposition").split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(content.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }
}