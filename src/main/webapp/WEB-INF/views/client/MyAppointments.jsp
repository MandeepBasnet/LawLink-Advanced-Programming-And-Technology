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
<script>
  const profileImg = document.querySelector('.profile-img');
  const dropdownMenu = document.querySelector('.dropdown-menu');

  profileImg.addEventListener('click', () => {
    dropdownMenu.style.display = dropdownMenu.style.display === 'block' ? 'none' : 'block';
  });

  // Optional: Hide dropdown when clicking outside
  document.addEventListener('click', (e) => {
    if (!document.querySelector('.profile-container').contains(e.target)) {
      dropdownMenu.style.display = 'none';
    }
  });
</script>

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