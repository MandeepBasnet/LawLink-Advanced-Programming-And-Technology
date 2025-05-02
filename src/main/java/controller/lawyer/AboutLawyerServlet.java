package controller.lawyer;

import dao.LawyerDAO;
import model.Lawyer;
import model.User;
import util.SessionUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Logger;

@WebServlet("/lawyer/about")
public class AboutLawyerServlet extends HttpServlet {
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
        request.setAttribute("lawyer", lawyer);
        request.getRequestDispatcher("/WEB-INF/views/lawyer/aboutLawyer.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = SessionUtil.getLoggedInUser(request);

        if (user == null || !"LAWYER".equals(user.getRole())) {
            request.getRequestDispatcher("/WEB-INF/views/error/access-denied.jsp").forward(request, response);
            return;
        }

        Lawyer lawyer = lawyerDAO.getLawyerById(user.getUserId());

        String aboutMe = request.getParameter("aboutMe");
        String education = request.getParameter("education");
        int experienceYears = Integer.parseInt(request.getParameter("experienceYears"));
        String specialization = request.getParameter("specialization");

        lawyer.setAboutMe(aboutMe);
        lawyer.setEducation(education);
        lawyer.setExperienceYears(experienceYears);
        lawyer.setSpecialization(specialization);

        if (lawyerDAO.updateLawyer(lawyer)) {
            request.setAttribute("success", "Profile updated successfully");
        } else {
            request.setAttribute("error", "Failed to update profile");
        }

        request.setAttribute("lawyer", lawyer);
        request.getRequestDispatcher("/WEB-INF/views/lawyer/about-lawyer.jsp").forward(request, response);
    }
}
