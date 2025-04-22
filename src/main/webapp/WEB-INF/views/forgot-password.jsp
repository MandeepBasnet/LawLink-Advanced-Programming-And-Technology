<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forgot Password - LawLink</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>
    <div class="container">
        <div class="forgot-password-container">
            <h1>Forgot Password</h1>
            
            <%-- Display error message if any --%>
            <c:if test="${not empty error}">
                <div class="alert alert-danger">
                    ${error}
                </div>
            </c:if>
            
            <%-- Display success message if any --%>
            <c:if test="${not empty message}">
                <div class="alert alert-success">
                    ${message}
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/forgot-password" method="post">
                <div class="form-group">
                    <label for="email">Email Address</label>
                    <input type="email" id="email" name="email" required 
                           placeholder="Enter your email address">
                </div>

                <button type="submit" class="btn btn-primary">Send Reset Link</button>
            </form>

            <div class="back-to-login">
                <a href="${pageContext.request.contextPath}/log-in">Back to Login</a>
            </div>
        </div>
    </div>
</body>
</html> 