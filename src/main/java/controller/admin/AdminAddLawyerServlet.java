package controller.admin;

import dao.LawyerDAO;
import model.Lawyer;
import util.PasswordUtil;
import util.StringUtil;
import util.ValidationUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Logger;
import java.math.BigDecimal;

@WebServlet("/admin/admin-add-lawyer")
public class AdminAddLawyerServlet extends HttpServlet {
    private static final Logger logger = Logger.getLogger(AdminAddLawyerServlet.class.getName());
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String username = StringUtil.safeString(request.getParameter("username"));
            String email = StringUtil.safeString(request.getParameter("email"));
            String fullName = StringUtil.safeString(request.getParameter("fullName"));
            String password = StringUtil.safeString(request.getParameter("password"));
            String specialization = StringUtil.safeString(request.getParameter("specialization"));
            String practiceAreas = StringUtil.safeString(request.getParameter("practiceAreas"));
            String education = StringUtil.safeString(request.getParameter("education"));
            String licenseNumber = StringUtil.safeString(request.getParameter("licenseNumber"));
            BigDecimal consultationFee = new BigDecimal(request.getParameter("consultationFee"));

            // Validations
            if (!ValidationUtil.isValidEmail(email)) {
                request.setAttribute("error", "Invalid email format.");
                request.getRequestDispatcher("adminAddLawyers.jsp").forward(request, response);
                return;
            }

            String hashedPassword = PasswordUtil.hashPassword(password);

            Lawyer lawyer = new Lawyer();
            lawyer.setUsername(username);
            lawyer.setEmail(email);
            lawyer.setFullName(fullName);
            lawyer.setPassword(hashedPassword);
            lawyer.setRole("LAWYER");
            lawyer.setSpecialization(specialization);
            lawyer.setPracticeAreas(practiceAreas);
            lawyer.setEducation(education);
            lawyer.setLicenseNumber(licenseNumber);
            lawyer.setConsultationFee(consultationFee);
            lawyer.setVerified(true); // Admin adds => directly verified

            boolean created = lawyerDAO.createLawyer(lawyer);

            if (created) {
                request.setAttribute("success", "Lawyer added successfully!");
            } else {
                request.setAttribute("error", "Failed to add lawyer. Try again.");
            }

            request.getRequestDispatcher("adminAddLawyers.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            logger.warning("Invalid consultation fee format: " + request.getParameter("consultationFee"));
            request.setAttribute("error", "Invalid consultation fee format.");
            request.getRequestDispatcher("adminAddLawyers.jsp").forward(request, response);
        } catch (Exception e) {
            logger.severe("Unexpected error while adding lawyer: " + e.getMessage());
            request.setAttribute("error", "An unexpected error occurred. Please try again.");
            request.getRequestDispatcher("adminAddLawyers.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/admin/admin-add-lawyer.jsp").forward(request, response);
    }
}


