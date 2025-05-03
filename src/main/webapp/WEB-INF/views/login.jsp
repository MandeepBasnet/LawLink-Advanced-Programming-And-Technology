<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Login Page</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
</head>
<body>
<div class="login-wrapper">
  <div class="login-container">
    <div class="image-container">
      <img src="${pageContext.request.contextPath}/assets/images/legal_background.jpg" alt="Legal background with gavel and books">
    </div>
    <div class="form-container">
      <a href="${pageContext.request.contextPath}/home" class="back-link">
        <span class="back-arrow">◀</span> Back to Website
      </a>
      <h1>Welcome!</h1>
      <p class="subtitle">Login to get started</p>
      <form action="${pageContext.request.contextPath}/log-in" method="post">
        <div class="form-group">
          <label for="email">Email</label>
          <input type="email" id="email" name="email" required>
        </div>
        <div class="form-group">
          <label for="password">Password</label>
          <input type="password" id="password" name="password" required>
        </div>
        <a href="${pageContext.request.contextPath}/forgot-password" class="forgot-password">Forget Password?</a>
        <button type="submit" class="login-btn">LOGIN</button>
      </form>
      <div class="signup-section">
        <span>Don't Have An Account?</span>
        <a href="${pageContext.request.contextPath}/register">
          <button type="button" class="signup-btn">SIGN UP</button>
        </a>
      </div>
    </div>
  </div>
</div>
</body>
</html>