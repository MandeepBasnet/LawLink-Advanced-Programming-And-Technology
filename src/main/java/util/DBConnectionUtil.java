package util;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

/**
 * Utility class for managing database connections.
 */
public class DBConnectionUtil {
    private static String JDBC_URL;
    private static String JDBC_USER;
    private static String JDBC_PASSWORD; // Set your MySQL password here

    // Static block to load the JDBC driver
    static {
        try (InputStream is = DBConnectionUtil.class.getClassLoader().getResourceAsStream("db.properties")) {
            Properties prop = new Properties();
            prop.load(is);
            Class.forName(prop.getProperty("db.driver"));
            JDBC_URL = prop.getProperty("db.url");
            JDBC_USER = prop.getProperty("db.username");
            JDBC_PASSWORD = prop.getProperty("db.password");
        } catch (Exception e) {
            System.err.println("Failed to load database configuration: " + e.getMessage());
        }
    }

    /**
     * Gets a connection to the database.
     *
     * @return A Connection object representing a connection to the database
     * @throws SQLException If a database access error occurs
     */
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
    }

    /**
     * Closes the given connection safely.
     *
     * @param connection The connection to close
     */
    public static void closeConnection(Connection connection) {
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                System.err.println("Error closing connection: " + e.getMessage());
            }
        }
    }
}
