package listener;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import java.sql.Driver;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Enumeration;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebListener
public class AppContextListener implements ServletContextListener {
    private static final Logger LOGGER = Logger.getLogger(AppContextListener.class.getName());

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("Application started.");
        LOGGER.info("Application context initialized");
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        System.out.println("Application stopped.");

        // Properly deregister JDBC drivers
        Enumeration<Driver> drivers = DriverManager.getDrivers();
        while (drivers.hasMoreElements()) {
            Driver driver = drivers.nextElement();
            try {
                DriverManager.deregisterDriver(driver);
                LOGGER.log(Level.INFO, "Deregistering JDBC driver: {0}", driver);
            } catch (SQLException ex) {
                LOGGER.log(Level.SEVERE, "Error deregistering JDBC driver: " + driver, ex);
            }
        }

        // Shutdown MySQL AbandonedConnectionCleanupThread using reflection
        // This approach works across different MySQL Connector/J versions
        try {
            // Try to find and call the shutdown method using reflection
            Class<?> cls = Class.forName("com.mysql.cj.jdbc.AbandonedConnectionCleanupThread");
            try {
                // First try the checkedShutdown method (newer versions)
                cls.getMethod("checkedShutdown").invoke(null);
                LOGGER.log(Level.INFO, "MySQL AbandonedConnectionCleanupThread shutdown completed using checkedShutdown");
            } catch (NoSuchMethodException e) {
                try {
                    // Fall back to shutdown method (older versions)
                    cls.getMethod("shutdown").invoke(null);
                    LOGGER.log(Level.INFO, "MySQL AbandonedConnectionCleanupThread shutdown completed using shutdown");
                } catch (NoSuchMethodException ex) {
                    LOGGER.log(Level.WARNING, "Could not find MySQL cleanup thread shutdown method");
                }
            }
        } catch (ClassNotFoundException e) {
            LOGGER.log(Level.INFO, "MySQL AbandonedConnectionCleanupThread class not found, no cleanup needed");
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "Error shutting down MySQL AbandonedConnectionCleanupThread", e);
        }

        LOGGER.info("Application context destroyed");
    }
}
