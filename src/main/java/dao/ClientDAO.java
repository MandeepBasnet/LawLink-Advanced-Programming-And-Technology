package dao;

import model.Client;
import util.DBConnectionUtil;
import util.PasswordUtil;
import util.EmailUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Data Access Object for Client entity
 */
public class ClientDAO {

    private static final Logger LOGGER = Logger.getLogger(ClientDAO.class.getName());
    private UserDAO userDAO;

    /**
     * Constructor for ClientDAO
     * @throws SQLException if a database access error occurs
     */
    public ClientDAO() throws SQLException {
        this.userDAO = new UserDAO();
    }

    /**
     * Register a new client in the database
     * @param client Client object to register
     * @return true if successful, false otherwise
     * @throws SQLException if a database access error occurs
     */
    public boolean registerClient(Client client) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = DBConnectionUtil.getConnection();
            conn.setAutoCommit(false);

            // Hash the password
            String hashedPassword = PasswordUtil.hashPassword(client.getPassword());
            if (hashedPassword == null) {
                LOGGER.log(Level.SEVERE, "Failed to hash password for client: {0}", client.getEmail());
                return false;
            }
            client.setPassword(hashedPassword);

            // First, create the user record
            boolean userCreated = userDAO.createUser(client);

            if (!userCreated) {
                conn.rollback();
                return false;
            }

            // Then, create the client record
            String sql = "INSERT INTO Clients (client_id, date_of_birth, gender) VALUES (?, ?, ?)";

            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, client.getUserId());

            if (client.getDateOfBirthSql() != null) {
                stmt.setDate(2, client.getDateOfBirthSql());
            } else {
                stmt.setNull(2, Types.DATE);
            }

            stmt.setString(3, client.getGender());

            int rowsAffected = stmt.executeUpdate();

            if (rowsAffected > 0) {
                client.setClientId(client.getUserId());
                conn.commit();

                // Send welcome email
                try {
                    String subject = "Welcome to LawLink";
                    String body = "<h1>Welcome to LawLink!</h1>" +
                            "<p>Dear " + client.getFullName() + ",</p>" +
                            "<p>Thank you for registering with LawLink. We're excited to have you on board!</p>" +
                            "<p>You can now:</p>" +
                            "<ul>" +
                            "<li>Search for lawyers</li>" +
                            "<li>Book appointments</li>" +
                            "<li>Manage your profile</li>" +
                            "</ul>" +
                            "<p>If you have any questions, please don't hesitate to contact us.</p>" +
                            "<p>Best regards,<br>The LawLink Team</p>";

                    EmailUtil.sendEmail(client.getEmail(), subject, body);
                } catch (Exception e) {
                    LOGGER.log(Level.WARNING, "Failed to send welcome email to " + client.getEmail(), e);
                }

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
                LOGGER.log(Level.SEVERE, "Failed to rollback transaction", ex);
            }
            LOGGER.log(Level.SEVERE, "Failed to register client", e);
            throw e;
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
                LOGGER.log(Level.SEVERE, "Failed to close database resources", e);
            }
        }
    }

    /**
     * Get a client by their ID
     * @param clientId ID of the client to retrieve
     * @return Client object if found, null otherwise
     */
    public Client getClientById(int clientId) {
        String sql = "SELECT u.*, c.* FROM Users u " +
                "JOIN Clients c ON u.user_id = c.client_id " +
                "WHERE c.client_id = ?";

        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, clientId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToClient(rs);
                }
            }

            return null;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * Get all clients from the database
     * @return List of Client objects
     */
    public List<Client> getAllClients() {
        String sql = "SELECT u.*, c.* FROM Users u " +
                "JOIN Clients c ON u.user_id = c.client_id";
        List<Client> clients = new ArrayList<>();

        try (Connection conn = DBConnectionUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                clients.add(mapResultSetToClient(rs));
            }

            return clients;
        } catch (SQLException e) {
            e.printStackTrace();
            return clients;
        }
    }

    /**
     * Update a client in the database
     * @param client Client object to update
     * @return true if successful, false otherwise
     */
    public boolean updateClient(Client client) {
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = DBConnectionUtil.getConnection();
            conn.setAutoCommit(false);

            // First, update the user record
            boolean userUpdated = userDAO.updateUser(client);

            if (!userUpdated) {
                conn.rollback();
                return false;
            }

            // Then, update the client record
            String sql = "UPDATE Clients SET date_of_birth = ?, gender = ? WHERE client_id = ?";

            stmt = conn.prepareStatement(sql);

            if (client.getDateOfBirthSql() != null) {
                stmt.setDate(1, client.getDateOfBirthSql());
            } else {
                stmt.setNull(1, Types.DATE);
            }

            stmt.setString(2, client.getGender());
            stmt.setInt(3, client.getClientId());

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
     * Delete a client from the database
     * @param clientId ID of the client to delete
     * @return true if successful, false otherwise
     */
    public boolean deleteClient(int clientId) {
        // This will cascade to delete the client record due to ON DELETE CASCADE
        return userDAO.deleteUser(clientId);
    }

    /**
     * Map a ResultSet to a Client object
     * @param rs ResultSet to map
     * @return Client object
     * @throws SQLException if a database access error occurs
     */
    private Client mapResultSetToClient(ResultSet rs) throws SQLException {
        Client client = new Client();

        // Map User fields
        client.setUserId(rs.getInt("user_id"));
        client.setUsername(rs.getString("username"));
        client.setPassword(rs.getString("password"));
        client.setEmail(rs.getString("email"));
        client.setFullName(rs.getString("full_name"));
        client.setPhone(rs.getString("phone"));
        client.setAddress(rs.getString("address"));
        client.setRole(rs.getString("role"));
        client.setRegistrationDate(rs.getTimestamp("registration_date"));
        client.setLastLogin(rs.getTimestamp("last_login"));
        client.setActive(rs.getBoolean("is_active"));
        client.setProfileImage(rs.getString("profile_image"));
        client.setSessionToken(rs.getString("session_token"));
        client.setSessionExpiry(rs.getTimestamp("session_expiry"));
        client.setResetToken(rs.getString("reset_token"));
        client.setResetTokenExpiry(rs.getTimestamp("reset_token_expiry"));

        // Map Client fields
        client.setClientId(rs.getInt("client_id"));
        
        // Use the SQL Date version for the client-specific field
        java.sql.Date dob = rs.getDate("date_of_birth");
        client.setDateOfBirthSql(dob);
        // The setDateOfBirthSql method will also set the string version in the parent class
        
        client.setGender(rs.getString("gender"));

        return client;
    }
}
