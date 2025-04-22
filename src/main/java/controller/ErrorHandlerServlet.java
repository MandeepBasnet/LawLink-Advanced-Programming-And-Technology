package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.logging.Logger;

@WebServlet("/error-handler")
public class ErrorHandlerServlet extends HttpServlet {
    private static final Logger logger = Logger.getLogger(ErrorHandlerServlet.class.getName());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        handleError(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        handleError(request, response);
    }

    private void handleError(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get error information from request attributes
        Integer statusCode = (Integer) request.getAttribute("jakarta.servlet.error.status_code");
        String errorMessage = (String) request.getAttribute("jakarta.servlet.error.message");
        String requestUri = (String) request.getAttribute("jakarta.servlet.error.request_uri");
        Throwable throwable = (Throwable) request.getAttribute("jakarta.servlet.error.exception");

        // Log the error
        logger.severe("Error occurred - Status: " + statusCode + 
                     ", Message: " + errorMessage + 
                     ", URI: " + requestUri + 
                     (throwable != null ? ", Exception: " + throwable.getMessage() : ""));

        // Set error information in request attributes
        request.setAttribute("statusCode", statusCode);
        request.setAttribute("errorMessage", errorMessage);
        request.setAttribute("requestUri", requestUri);

        // Determine which error page to show based on status code
        String errorPage;
        if (statusCode == null) {
            errorPage = "/WEB-INF/views/error/500.jsp";
        } else {
            switch (statusCode) {
                case 400:
                    errorPage = "/WEB-INF/views/error/400.jsp";
                    break;
                case 401:
                    errorPage = "/WEB-INF/views/error/401.jsp";
                    break;
                case 403:
                    errorPage = "/WEB-INF/views/error/403.jsp";
                    break;
                case 404:
                    errorPage = "/WEB-INF/views/error/404.jsp";
                    break;
                case 500:
                    errorPage = "/WEB-INF/views/error/500.jsp";
                    break;
                default:
                    errorPage = "/WEB-INF/views/error/generic.jsp";
                    break;
            }
        }

        // Forward to the appropriate error page
        request.getRequestDispatcher(errorPage).forward(request, response);
    }
}
