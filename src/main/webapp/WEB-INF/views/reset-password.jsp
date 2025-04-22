<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Reset Password</title>
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      font-family: Arial, sans-serif;
    }

    body {
      background-color: #d3d3d3;
      display: flex;
      justify-content: center;
      align-items: center;
      min-height: 100vh;
    }

    .container {
      background-color: #9ca3af;
      border-radius: 20px;
      padding: 40px;
      width: 100%;
      max-width: 500px;
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
      text-align: center;
      margin-bottom: 30px;
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
      background-color: #b8b8b8;
      font-size: 16px;
    }

    button {
      display: block;
      width: 100%;
      max-width: 300px;
      margin: 30px auto 0;
      padding: 15px;
      border: none;
      border-radius: 50px;
      background-color: #d1d1d1;
      font-size: 16px;
      font-weight: bold;
      cursor: pointer;
    }

    button:hover {
      background-color: #c0c0c0;
    }
  </style>
</head>
<body>
<div class="container">
  <a href="${pageContext.request.contextPath}/home" class="back-link">
    <span class="back-arrow">◀</span> Back to Website
  </a>

  <h1>Reset Password</h1>

  <form action="${pageContext.request.contextPath}/reset-password" method="post">
    <div class="form-group">
      <label for="current-password">Current Password</label>
      <input type="password" id="current-password" name="currentPassword" required>
    </div>

    <div class="form-group">
      <label for="new-password">New Password</label>
      <input type="password" id="new-password" name="newPassword" required>
    </div>

    <div class="form-group">
      <label for="confirm-password">New Password</label>
      <input type="password" id="confirm-password" name="confirmPassword" required>
    </div>

    <button type="submit">Change Password</button>
  </form>
</div>
</body>
</html>