<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>My Appointments - LawLink</title>
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
      margin-bottom: 30px;
    }

    .appointment-list {
      display: flex;
      flex-direction: column;
      gap: 20px;
    }

    .appointment-card {
      display: flex;
      border-bottom: 1px solid #e0e0e0;
      padding-bottom: 20px;
    }

    .lawyer-img {
      width: 100px;
      height: 120px;
      object-fit: cover;
      margin-right: 20px;
    }

    .appointment-details {
      flex: 1;
    }

    .lawyer-name {
      font-size: 18px;
      font-weight: bold;
      margin-bottom: 5px;
    }

    .lawyer-specialty {
      color: #555;
      margin-bottom: 10px;
    }

    .appointment-info {
      margin-bottom: 5px;
    }

    .appointment-actions {
      display: flex;
      justify-content: flex-end;
      align-items: center;
    }

    .btn {
      padding: 10px 20px;
      border: none;
      border-radius: 5px;
      cursor: pointer;
      font-weight: bold;
    }

    .btn-cancel {
      background-color: white;
      border: 1px solid #ccc;
    }

    .btn-cancelled {
      background-color: #e07a7a;
      color: white;
    }

    .btn-completed {
      background-color: #a3e07a;
      color: black;
    }

    .btn-leave_review {
      background-color: #3a444a;
      color: black;
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

  <div class="profile-container">
    <img src="${pageContext.request.contextPath}/assets/images/upload_area.png" alt="Profile" class="profile-img">
    <span class="dropdown-icon">▼</span>

    <div class="dropdown-menu">
      <a href="${pageContext.request.contextPath}/client/my-profile"><div class="dropdown-item">My Profile</div></a>
      <a href="${pageContext.request.contextPath}/client/my-appointments"><div class="dropdown-item active">My Appointments</div></a>
      <a href="${pageContext.request.contextPath}/logout"><div class="dropdown-item">Logout</div></a>
    </div>
  </div>
</div>

<!-- Main Content -->
<div class="container">
  <h1>My Appointments</h1>

  <div class="appointment-list">
    <!-- Appointment 1 -->
    <div class="appointment-card">
      <img src="${pageContext.request.contextPath}/assets/images/susasa-acharaya.png" alt="Susasa Acharya" class="lawyer-img">

      <div class="appointment-details">
        <div class="lawyer-name">Susasa Acharya</div>
        <div class="lawyer-specialty">Property Law</div>
        <div class="appointment-info"><strong>Address:</strong> Birtamod</div>
        <div class="appointment-info"><strong>Date & Time:</strong> 25, July, 2025 | 10:30 AM</div>
        <div class="appointment-info"><strong>Contact:</strong> 9703129041</div>
      </div>

      <div class="appointment-actions">
        <form action="${pageContext.request.contextPath}/cancel-appointment" method="post">
          <input type="hidden" name="appointmentId" value="1">
          <button type="submit" class="btn btn-cancel">Cancel appointment</button>
        </form>
      </div>
    </div>

    <!-- Appointment 2 -->
    <div class="appointment-card">
      <img src="${pageContext.request.contextPath}/assets/images/anish-basnet.png" alt="Anish Basnet" class="lawyer-img">

      <div class="appointment-details">
        <div class="lawyer-name">Anish Basnet</div>
        <div class="lawyer-specialty">Labour Law</div>
        <div class="appointment-info"><strong>Address:</strong> Jhapa</div>
        <div class="appointment-info"><strong>Date & Time:</strong> 26, July, 2025 | 3:30 PM</div>
        <div class="appointment-info"><strong>Contact:</strong> 9705203041</div>
      </div>

      <div class="appointment-actions">
        <div class="btn btn-cancelled">Cancelled</div>
      </div>
    </div>

    <!-- Appointment 3 -->
    <div class="appointment-card">
      <img src="${pageContext.request.contextPath}/assets/images/yusha-shrestha.png" alt="Yusha Shrestha" class="lawyer-img">

      <div class="appointment-details">
        <div class="lawyer-name">Yusha Shrestha</div>
        <div class="lawyer-specialty">International Law</div>
        <div class="appointment-info"><strong>Address:</strong> Tarahara, Itahari</div>
        <div class="appointment-info"><strong>Date & Time:</strong> 20, April, 2025 | 02 PM</div>
        <div class="appointment-info"><strong>Contact:</strong> 9709304911</div>
      </div>

      <div class="appointment-actions">
        <div class="btn btn-leave_review">Leave Review</div>
      </div>

      <div class="appointment-actions">
        <div class="btn btn-completed">
          <a href="${pageContext.request.contextPath}/client/reviews">Completed</a>
        </div>
      </div>
    </div>
  </div>
</div>
</body>
</html>