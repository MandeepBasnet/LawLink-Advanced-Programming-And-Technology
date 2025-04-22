package dao;

import model.User;
import util.DBConnectionUtil;
import util.PasswordUtil;
import util.EmailUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;
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
            pstmt.setBoolean(8, user.isActive());
            
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
                    user.setActive(rs.getBoolean("is_active"));
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
     */
    public boolean updateUser(User user) {
        String sql = "UPDATE Users SET username = ?, password = ?, email = ?, " +
                "full_name = ?, phone = ?, address = ?, role = ?, is_active = ?, " +
                "profile_image = ?, session_token = ?, session_expiry = ?, " +
                "reset_token = ?, reset_token_expiry = ?, otp = ?, otp_expiry = ? WHERE user_id = ?";

        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getPassword());
            stmt.setString(3, user.getEmail());
            stmt.setString(4, user.getFullName());
            stmt.setString(5, user.getPhone());
            stmt.setString(6, user.getAddress());
            stmt.setString(7, user.getRole());
            stmt.setBoolean(8, user.isActive());
            stmt.setString(9, user.getProfileImage());
            stmt.setString(10, user.getSessionToken());
            stmt.setTimestamp(11, user.getSessionExpiry());
            stmt.setString(12, user.getResetToken());
            stmt.setTimestamp(13, user.getResetTokenExpiry());
            stmt.setString(14, user.getOtp());
            stmt.setTimestamp(15, user.getOtpExpiry());
            stmt.setInt(16, user.getUserId());

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
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
     * Clear a user's session token
     * @param userId ID of the user
     * @return true if successful, false otherwise
     */
    public boolean clearSessionToken(int userId) {
        String sql = "UPDATE Users SET session_token = NULL, session_expiry = NULL WHERE user_id = ?";

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
     * Set a password reset token for a user
     * @param userId ID of the user
     * @param resetToken Reset token
     * @param expiryHours Hours until the token expires
     * @return true if successful, false otherwise
     */
    public boolean setResetToken(int userId, String resetToken, int expiryHours) {
        String sql = "UPDATE Users SET reset_token = ?, reset_token_expiry = DATE_ADD(NOW(), INTERVAL ? HOUR) WHERE user_id = ?";

        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, resetToken);
            stmt.setInt(2, expiryHours);
            stmt.setInt(3, userId);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Get a user by their reset token
     * @param resetToken Reset token
     * @return User object if found and token is valid, null otherwise
     */
    public User getUserByResetToken(String resetToken) {
        String sql = "SELECT * FROM Users WHERE reset_token = ? AND reset_token_expiry > NOW()";

        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, resetToken);

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
     * Clear a user's reset token
     * @param userId ID of the user
     * @return true if successful, false otherwise
     */
    public boolean clearResetToken(int userId) {
        String sql = "UPDATE Users SET reset_token = NULL, reset_token_expiry = NULL WHERE user_id = ?";

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
     * Set an OTP for email verification
     * @param userId ID of the user
     * @param otp OTP to set
     * @param expiryMinutes Minutes until the OTP expires
     * @return true if successful, false otherwise
     */
    public boolean setOTP(int userId, String otp, int expiryMinutes) {
        String sql = "UPDATE Users SET otp = ?, otp_expiry = DATE_ADD(NOW(), INTERVAL ? MINUTE) WHERE user_id = ?";

        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, otp);
            stmt.setInt(2, expiryMinutes);
            stmt.setInt(3, userId);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Get a user's OTP
     * @param userId ID of the user
     * @return OTP if found and valid, null otherwise
     */
    public String getOTP(int userId) {
        String sql = "SELECT otp FROM Users WHERE user_id = ? AND otp_expiry > NOW()";

        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("otp");
                }
            }

            return null;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * Clear a user's OTP
     * @param userId ID of the user
     * @return true if successful, false otherwise
     */
    public boolean clearOTP(int userId) {
        String sql = "UPDATE Users SET otp = NULL, otp_expiry = NULL WHERE user_id = ?";

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
        user.setActive(rs.getBoolean("is_active"));
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
     * Authenticate a user
     * @param username Username
     * @param password Password
     * @return User object if authenticated, null otherwise
     */
    public User authenticate(String username, String password) {
        try {
            User user = getUserByUsername(username);
            if (user != null && PasswordUtil.verifyPassword(password, user.getPassword())) {
                updateLastLogin(user.getUserId());
                return user;
            }
            return null;
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Failed to authenticate user", e);
            return null;
        }
    }

    /**
     * Change a user's password after verifying the current password
     * @param userId User ID
     * @param currentPassword Current password to verify
     * @param newPassword New password to set
     * @return true if successful, false otherwise
     */
    public boolean changePassword(int userId, String currentPassword, String newPassword) {
        try {
            // Get the user to verify current password
            User user = getUserById(userId);
            if (user == null) {
                return false;
            }

            // Verify current password
            if (!PasswordUtil.verifyPassword(currentPassword, user.getPassword())) {
                return false;
            }

            // Hash and update the new password
            String hashedPassword = PasswordUtil.hashPassword(newPassword);
            return updatePassword(userId, hashedPassword);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Failed to change password", e);
            return false;
        }
    }

    /**
     * Request OTP for password reset
     * @param email User's email
     * @return true if OTP was sent successfully, false otherwise
     */
    public boolean requestOTP(String email) {
        try {
            User user = getUserByEmail(email);
            if (user == null) {
                return false;
            }

            // Generate OTP
            String otp = generateOTP();
            Timestamp otpExpiry = new Timestamp(System.currentTimeMillis() + (30 * 60 * 1000)); // 30 minutes

            // Update user with OTP
            user.setOtp(otp);
            user.setOtpExpiry(otpExpiry);
            if (!updateUser(user)) {
                return false;
            }

            // Send OTP via email
            String subject = "Your OTP for Password Reset";
            String message = "Your OTP is: " + otp + "\nThis OTP will expire in 30 minutes.";
            return EmailUtil.sendEmail(email, subject, message);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Failed to request OTP", e);
            return false;
        }
    }

    /**
     * Verify OTP for password reset
     * @param userId User ID
     * @param otp OTP to verify
     * @return true if OTP is valid, false otherwise
     */
    public boolean verifyOTP(int userId, String otp) {
        try {
            User user = getUserById(userId);
            if (user == null || user.getOtp() == null || user.getOtpExpiry() == null) {
                return false;
            }

            // Check if OTP matches and hasn't expired
            if (user.getOtp().equals(otp) && user.getOtpExpiry().after(new Timestamp(System.currentTimeMillis()))) {
                // Clear OTP after successful verification
                clearOTP(userId);
                return true;
            }

            return false;
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Failed to verify OTP", e);
            return false;
        }
    }

    /**
     * Reset user's password using reset token
     * @param token Reset token
     * @param newPassword New password
     * @return true if successful, false otherwise
     */
    public boolean resetPassword(String token, String newPassword) {
        try {
            User user = getUserByResetToken(token);
            if (user == null) {
                return false;
            }

            // Hash the new password
            String hashedPassword = PasswordUtil.hashPassword(newPassword);
            user.setPassword(hashedPassword);
            user.setResetToken(null);
            user.setResetTokenExpiry(null);

            return updateUser(user);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Failed to reset password", e);
            return false;
        }
    }

    /**
     * Create a session token for a user
     * @param userId User ID
     * @param rememberMe Whether to create a long-term session
     * @return true if successful, false otherwise
     */
    public boolean createSessionToken(int userId, boolean rememberMe) {
        try {
            // Generate a random session token
            String sessionToken = java.util.UUID.randomUUID().toString();
            
            // Calculate expiry time (24 hours for normal sessions, 30 days for remember me)
            int expiryHours = rememberMe ? 720 : 24; // 720 hours = 30 days
            
            // Create expiry timestamp
            java.sql.Timestamp expiryTime = new java.sql.Timestamp(
                System.currentTimeMillis() + (expiryHours * 60 * 60 * 1000L)
            );
            
            return updateSessionToken(userId, sessionToken, expiryTime);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Failed to create session token", e);
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

    /**
     * Generate a random OTP
     * @return 6-digit OTP
     */
    private String generateOTP() {
        Random random = new Random();
        int otp = 100000 + random.nextInt(900000);
        return String.valueOf(otp);
    }

    /**
     * Update a user's password
     * @param userId User ID
     * @param hashedPassword Hashed password
     * @return true if successful, false otherwise
     */
    private boolean updatePassword(int userId, String hashedPassword) {
        String sql = "UPDATE Users SET password = ? WHERE user_id = ?";

        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, hashedPassword);
            stmt.setInt(2, userId);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Failed to update password", e);
            return false;
        }
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
                client.setCreatedAt(rs.getTimestamp("created_at"));
                clients.add(client);
            }
        } catch (SQLException e) {
            LOGGER.severe("Error retrieving all clients: " + e.getMessage());
            throw e;
        }
        
        return clients;
    }

    /**
     * Authenticate a user by email and password
     * @param email User's email
     * @param password User's password
     * @return User object if authentication successful, null otherwise
     */
    // FIX: Proper authenticate by email + password method
    public User authenticateByEmail(String email, String password) {
        try {
            User user = getUserByEmail(email);
            if (user != null && PasswordUtil.verifyPassword(password, user.getPassword())) {
                updateLastLogin(user.getUserId());
                return user;
            }
            return null;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }


    /**
     * Send a password reset email to the user
     * @param email User's email address
     * @return true if email was sent successfully, false otherwise
     */
    public boolean sendPasswordResetEmail(String email) {
        User user = getUserByEmail(email);
        if (user == null) {
            // Return true even if user doesn't exist for security reasons
            return true;
        }

        // Generate a reset token
        String resetToken = generateResetToken();
        boolean tokenSet = setResetToken(user.getUserId(), resetToken, 1); // 1 hour expiry

        if (!tokenSet) {
            return false;
        }

        // Send email with reset link
        String resetLink = "http://localhost:8081/LawLink_war_exploded/reset-password?token=" + resetToken;
        String subject = "Password Reset Request - LawLink";
        String body = "Hello " + user.getFullName() + ",\n\n" +
                "You have requested to reset your password. Please click the link below to reset your password:\n\n" +
                resetLink + "\n\n" +
                "This link will expire in 1 hour.\n\n" +
                "If you did not request this password reset, please ignore this email.\n\n" +
                "Best regards,\n" +
                "LawLink Team";

        try {
            EmailUtil.sendEmail(user.getEmail(), subject, body);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Generate a secure reset token
     * @return Generated reset token
     */
    private String generateResetToken() {
        byte[] randomBytes = new byte[32];
        new Random().nextBytes(randomBytes);
        return java.util.Base64.getUrlEncoder().withoutPadding().encodeToString(randomBytes);
    }
}
