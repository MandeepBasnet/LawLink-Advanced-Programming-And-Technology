<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Login Page</title>
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      font-family: Arial, sans-serif;
    }

    body {
      background-color: #f0f0f0;
      display: flex;
      justify-content: center;
      align-items: center;
      min-height: 100vh;
    }

    .container {
      display: flex;
      max-width: 1000px;
      width: 100%;
      overflow: hidden;
    }

    .image-container {
      flex: 1;
      position: relative;
    }

    .image-container img {
      width: 100%;
      height: 100%;
      object-fit: cover;
    }

    .form-container {
      flex: 1;
      background-color: #a0a0a0;
      padding: 40px;
      border-radius: 20px;
    }

    .back-link {
      display: flex;
      align-items: center;
      margin-bottom: 30px;
      text-decoration: none;
      color: black;
      font-weight: bold;
    }

    .back-arrow {
      margin-right: 10px;
      font-size: 20px;
    }

    h1 {
      font-size: 42px;
      margin-bottom: 10px;
    }

    .subtitle {
      margin-bottom: 30px;
      font-size: 18px;
    }

    .form-group {
      margin-bottom: 20px;
    }

    label {
      display: block;
      font-size: 18px;
      margin-bottom: 10px;
    }

    input {
      width: 100%;
      padding: 15px;
      border: none;
      border-radius: 8px;
      background-color: #c0c0c0;
      font-size: 16px;
    }

    .forgot-password {
      display: block;
      text-align: center;
      margin: 15px 0;
      color: black;
      text-decoration: none;
    }

    .login-btn {
      width: 100%;
      padding: 15px;
      border: none;
      border-radius: 8px;
      background-color: #c0c0c0;
      font-size: 16px;
      font-weight: bold;
      cursor: pointer;
      margin-top: 10px;
    }

    .login-btn:hover {
      background-color: #b0b0b0;
    }

    .signup-section {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-top: 25px;
    }

    .signup-btn {
      background-color: #c0c0c0;
      border: none;
      border-radius: 50px;
      padding: 10px 20px;
      font-weight: bold;
      cursor: pointer;
    }

    .signup-btn:hover {
      background-color: #b0b0b0;
    }

    @media (max-width: 768px) {
      .container {
        flex-direction: column;
      }

      .image-container {
        display: none;
      }

      .form-container {
        width: 100%;
        padding: 20px;
      }
    }
  </style>
</head>
<body>
<div class="container">
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
</body>
</html>