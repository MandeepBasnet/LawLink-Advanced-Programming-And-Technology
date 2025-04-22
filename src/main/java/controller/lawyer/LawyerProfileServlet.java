package controller.lawyer;

import dao.LawyerDAO;
import model.Lawyer;
import model.User;
import util.StringUtil;
import util.ValidationUtil;
import util.SessionUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Logger;

@WebServlet("/lawyer/lawyer-profile")
public class LawyerProfileServlet extends HttpServlet {
    private static final Logger logger = Logger.getLogger(AboutLawyerServlet.class.getName());
    private LawyerDAO lawyerDAO;

    @Override
    public void init() throws ServletException {
        try {
            lawyerDAO = new LawyerDAO();
        } catch (SQLException e) {
            logger.severe("Failed to initialize LawyerDAO: " + e.getMessage());
            throw new ServletException("Failed to initialize LawyerDAO", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = SessionUtil.getLoggedInUser(request);

        if (user == null || !"LAWYER".equals(user.getRole())) {
            request.getRequestDispatcher("/WEB-INF/views/error/access-denied.jsp").forward(request, response);
            return;
        }

        Lawyer lawyer = lawyerDAO.getLawyerById(user.getUserId());

        if (lawyer != null) {
            request.setAttribute("lawyer", lawyer);
            request.getRequestDispatcher("/WEB-INF/views/lawyer/lawyerProfile.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("/WEB-INF/views/error/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = SessionUtil.getLoggedInUser(request);

        if (user == null || !"LAWYER".equals(user.getRole())) {
            request.getRequestDispatcher("/WEB-INF/views/error/access-denied.jsp").forward(request, response);
            return;
        }

        try {
            Lawyer lawyer = lawyerDAO.getLawyerById(user.getUserId());

            if (lawyer == null) {
                request.getRequestDispatcher("/WEB-INF/views/error/error.jsp").forward(request, response);
                return;
            }

            String fullName = StringUtil.safeString(request.getParameter("fullName"));
            String phone = StringUtil.safeString(request.getParameter("phone"));
            String address = StringUtil.safeString(request.getParameter("address"));
            String specialization = StringUtil.safeString(request.getParameter("specialization"));
            String practiceAreas = StringUtil.safeString(request.getParameter("practiceAreas"));
            String aboutMe = StringUtil.safeString(request.getParameter("aboutMe"));

            if (!ValidationUtil.isValidPhone(phone)) {
                request.setAttribute("error", "Invalid phone format.");
                request.setAttribute("lawyer", lawyer);
                request.getRequestDispatcher("/WEB-INF/views/lawyer/lawyerProfile.jsp").forward(request, response);
                return;
            }

            lawyer.setFullName(fullName);
            lawyer.setPhone(phone);
            lawyer.setAddress(address);
            lawyer.setSpecialization(specialization);
            lawyer.setPracticeAreas(practiceAreas);
            lawyer.setAboutMe(aboutMe);

            if (lawyerDAO.updateLawyer(lawyer)) {
                request.setAttribute("success", "Profile updated successfully");
                request.setAttribute("lawyer", lawyer);
            } else {
                request.setAttribute("error", "Failed to update profile");
            }
        } catch (Exception e) {
            logger.severe("Error updating lawyer profile: " + e.getMessage());
            request.setAttribute("error", "An error occurred while updating your profile");
        }

        request.getRequestDispatcher("/WEB-INF/views/lawyer/lawyerProfile.jsp").forward(request, response);
    }
}