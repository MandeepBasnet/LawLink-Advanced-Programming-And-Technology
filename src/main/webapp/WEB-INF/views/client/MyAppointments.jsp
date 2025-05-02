<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>My Appointments - LawLink</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/clientStyle.css">
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
    <img src="${pageContext.request.contextPath}/assets/images/profile_pic.png" alt="Profile" class="profile-pic">
    <div class="profile-menu">
      <a href="${pageContext.request.contextPath}/client/my-appointments">My Appointments</a>
      <a href="${pageContext.request.contextPath}/client/my-profile">My Profile</a>
      <form action="${pageContext.request.contextPath}/logout" method="post" style="margin:0;">
        <button type="submit" class="menu-logout-btn">Logout</button>
      </form>
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
<script>
  // No JavaScript needed for hover-based dropdown
</script>
