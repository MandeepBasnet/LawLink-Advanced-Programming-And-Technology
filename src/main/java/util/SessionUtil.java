// --- Helper Class for Session User ---
package util;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import model.User;

public class SessionUtil {
    public static User getLoggedInUser(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return (session != null) ? (User) session.getAttribute("user") : null;
    }
}