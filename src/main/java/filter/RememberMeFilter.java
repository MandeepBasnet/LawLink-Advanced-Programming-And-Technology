package filter;

import dao.UserDAO;
import model.User;
import util.CookieUtil;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebFilter("/*")
public class RememberMeFilter implements Filter {

    private static final Logger LOGGER = Logger.getLogger(RememberMeFilter.class.getName());
    private UserDAO userDAO;
    private boolean daoInitialized = false;

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Defer DAO initialization to first request to avoid startup failures
        LOGGER.info("RememberMeFilter initialized");
    }

    private void initializeDAO() {
        if (!daoInitialized) {
            try {
                this.userDAO = new UserDAO();
                daoInitialized = true;
                LOGGER.info("UserDAO successfully initialized");
            } catch (SQLException e) {
                LOGGER.log(Level.SEVERE, "Failed to initialize UserDAO. Remember Me functionality will be disabled.", e);
                // Don't throw exception - let the filter continue without remember me functionality
            }
        }
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        // Initialize DAO on first request
        if (!daoInitialized) {
            initializeDAO();
        }

        // Only proceed with remember me logic if DAO was successfully initialized
        if (daoInitialized) {
            HttpServletRequest req = (HttpServletRequest) request;
            HttpSession session = req.getSession(false);

            if (session == null || session.getAttribute("currentUser") == null) {
                try {
                    String token = CookieUtil.getCookieValue(req, CookieUtil.REMEMBER_ME_COOKIE);
                    if (token != null) {
                        User user = userDAO.getUserBySessionToken(token);
                        if (user != null && user.isActive()) {
                            HttpSession newSession = req.getSession(true);
                            newSession.setAttribute("currentUser", user);
                            LOGGER.info("User auto-logged in via remember me token: " + user.getEmail());
                        }
                    }
                } catch (Exception e) {
                    // Log error but don't block the request
                    LOGGER.log(Level.SEVERE, "Error processing remember me token", e);
                }
            }
        }

        // Always continue the filter chain
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        if (userDAO != null) {
            try {
                userDAO.close();
                LOGGER.info("UserDAO closed successfully");
            } catch (Exception e) {
                LOGGER.log(Level.WARNING, "Error closing UserDAO", e);
            }
        }
    }
}
