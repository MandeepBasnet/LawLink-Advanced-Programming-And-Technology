<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>My Profile - LawLink</title>
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      font-family: Arial, sans-serif;
    }

    body {
      background-color: #f8f8f8;
    }

    .navbar {
      display: flex;
      justify-content: space-between;
      align-items: center;
      background-color: #7f8c9a;
      padding: 15px 50px;
      color: white;
    }

    .logo-container {
      display: flex;
      align-items: center;
    }

    .logo-img {
      width: 30px;
      height: 30px;
      margin-right: 10px;
    }

    .logo-text {
      font-size: 20px;
      font-weight: bold;
    }

    .nav-links {
      display: flex;
      gap: 30px;
    }

    .nav-links a {
      color: white;
      text-decoration: none;
    }

    .profile-container {
      position: relative;
    }

    .profile-img {
      width: 40px;
      height: 40px;
      border-radius: 50%;
      cursor: pointer;
    }

    .dropdown-icon {
      margin-left: 5px;
    }

    .dropdown-menu {
      position: absolute;
      right: 0;
      top: 60px;
      background-color: #e0e0e0;
      width: 200px;
      border-radius: 5px;
      overflow: hidden;
    }

    .dropdown-item {
      padding: 15px;
      text-align: center;
      cursor: pointer;
    }

    .dropdown-item:hover {
      background-color: #d0d0d0;
    }

    .dropdown-item.active {
      background-color: #c0c0c0;
      font-weight: bold;
    }

    .container {
      max-width: 1200px;
      margin: 0 auto;
      padding: 30px 20px;
    }

    h1 {
      font-size: 32px;
      margin-bottom: 40px;
    }

    .profile {
      position: relative;
      display: inline-block;
    }

    .profile img {
      width: 40px;
      height: 40px;
      border-radius: 50%;
      cursor: pointer;
    }

    .profile-menu {
      display: none;
      position: absolute;
      right: 0;
      background-color: white;
      color: black;
      min-width: 150px;
      box-shadow: 0px 8px 16px rgba(0,0,0,0.2);
      border-radius: 8px;
      z-index: 99;
    }

    .profile-menu a, .profile-menu form button {
      padding: 10px;
      text-align: left;
      text-decoration: none;
      display: block;
      background: none;
      border: none;
      color: black;
      width: 100%;
      font-size: 14px;
      cursor: pointer;
    }

    .profile-menu a:hover, .profile-menu form button:hover {
      background-color: #f1f1f1;
    }

    .profile:hover .profile-menu {
      display: block;
    }

    .user-name {
      font-size: 24px;
      font-weight: bold;
      margin-bottom: 30px;
    }

    .info-container {
      display: flex;
      width: 100%;
      max-width: 800px;
      margin-bottom: 40px;
      border-top: 1px solid #e0e0e0;
    }

    .info-column {
      flex: 1;
      padding: 20px;
    }

    .info-column:first-child {
      border-right: 1px solid #e0e0e0;
    }

    .info-heading {
      font-size: 20px;
      font-weight: bold;
      margin-bottom: 20px;
      text-align: center;
    }

    .info-item {
      margin-bottom: 15px;
      display: flex;
    }

    .info-label {
      font-weight: bold;
      margin-right: 10px;
    }

    .button-group {
      display: flex;
      gap: 20px;
    }

    .btn {
      padding: 10px 30px;
      border: none;
      border-radius: 5px;
      cursor: pointer;
      font-weight: bold;
    }

    .btn-edit {
      background-color: #b8b8b8;
    }

    .btn-save {
      background-color: #a3e07a;
    }

    .btn-password {
      background-color: #b8b8b8;
    }
  </style>
</head>
<body>
<!-- Navigation Bar -->
<div class="navbar">
  <div class="logo-container">
    <img src="${pageContext.request.contextPath}/assets/images/logo.png" alt="LawLink Logo" class="logo-img">
    <span class="logo-text">LawLink</span>
  </div>

  <div class="nav-links">
    <a href="${pageContext.request.contextPath}/home">Home</a>
    <a href="${pageContext.request.contextPath}/appointment">Appointment</a>
    <a href="${pageContext.request.contextPath}/lawyers">Lawyers</a>
    <a href="${pageContext.request.contextPath}/about-us">About Us</a>
    <a href="${pageContext.request.contextPath}/contact-us">Contact Us</a>
  </div>

  <div class="profile">
    <img src="${pageContext.request.contextPath}/assets/images/profile_pic.png" alt="John Thapa" class="profile-pic">
    <div class="profile-menu">
      <a href="${pageContext.request.contextPath}/client/my-appointments">My Appointments</a>
      <a href="${pageContext.request.contextPath}/client/my-profile">My Profile</a>
      <form action="${pageContext.request.contextPath}/logout" method="post" style="margin:0;">
        <button type="submit">Logout</button>
      </form>
    </div>
  </div>
</div>

<!-- Main Content -->
<div class="container">
  <h1>My Profile</h1>

    <div class="user-name">${user.fullName}</div>

    <div class="info-container">
      <div class="info-column">
        <div class="info-heading">Basic Information</div>

        <div class="info-item">
          <div class="info-label">Username:</div>
          <div>${user.username}</div>
        </div>

        <div class="info-item">
          <div class="info-label">Gender:</div>
          <div>${user.gender}</div>
        </div>

        <div class="info-item">
          <div class="info-label">Date of Birth:</div>
          <div>${user.dateOfBirth}</div>
        </div>
      </div>

      <div class="info-column">
        <div class="info-heading">Contact Information</div>

        <div class="info-item">
          <div class="info-label">Email:</div>
          <div>${user.email}</div>
        </div>

        <div class="info-item">
          <div class="info-label">Phone:</div>
          <div>${user.phone}</div>
        </div>

        <div class="info-item">
          <div class="info-label">Address:</div>
          <div>${user.address}</div>
        </div>
      </div>
    </div>

    <div class="button-group">
      <form action="${pageContext.request.contextPath}/edit-profile" method="get">
        <button type="submit" class="btn btn-edit">Edit</button>
      </form>

      <form action="${pageContext.request.contextPath}/save-profile" method="post">
        <button type="submit" class="btn btn-save">Save</button>
      </form>

      <form action="${pageContext.request.contextPath}/change-password" method="get">
        <button type="submit" class="btn btn-password">Change Password</button>
      </form>
    </div>
  </div>
</div>
</body>
</html>