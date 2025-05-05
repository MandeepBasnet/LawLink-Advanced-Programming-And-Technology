<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up Form</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
</head>
<body>
<div class="login-wrapper">
    <div class="login-container">
        <div class="image-container">
            <img src="${pageContext.request.contextPath}/assets/images/lady%20justice.jpg" alt="Lady Justice statue">
        </div>
        <div class="form-container">
            <a href="${pageContext.request.contextPath}/home" class="back-link">
                <span class="back-arrow">◀</span> Back to Website
            </a>
            <h1>SIGN UP</h1>
            <p class="subtitle">Enter your Personal details to create your account</p>
            <form action="${pageContext.request.contextPath}/register" method="post" enctype="multipart/form-data">
                <div class="form-group">
                    <label for="fullName">Full Name</label>
                    <input type="text" id="fullName" name="fullName" required>
                </div>
                <div class="form-group">
                    <label for="userName">User Name</label>
                    <input type="text" id="userName" name="userName" required>
                </div>
                <div class="form-group">
                    <label for="email">Email Address</label>
                    <input type="email" id="email" name="email" required>
                </div>
                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" required>
                </div>
                <div class="form-group">
                    <label for="confirmPassword">Confirm Password</label>
                    <input type="password" id="confirmPassword" name="confirmPassword" required>
                </div>
                <div class="form-group">
                    <label for="profilePicture">Profile Picture</label>
                    <input type="file" id="profilePicture" name="profilePicture" accept="image/*">
                </div>
                <button type="submit" class="login-btn">SIGN UP</button>
            </form>
            <div class="login-section">
                <span class="login-text">Already Have An Account?</span>
                <a href="${pageContext.request.contextPath}/log-in">
                    <button type="button" class="signup-btn">LOG IN</button>
                </a>
            </div>
        </div>
    </div>
</div>
</body>
</html>