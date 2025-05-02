<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>My Profile - LawLink</title>
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
  <h1>My Profile</h1>
  
  <!-- Success/Error Messages -->
  <c:if test="${not empty successMessage}">
    <div class="success-message">${successMessage}</div>
  </c:if>
  <c:if test="${not empty errorMessage}">
    <div class="error-message">${errorMessage}</div>
  </c:if>

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
    <button id="editProfileBtn" class="btn btn-edit">Edit Profile</button>
    <a href="${pageContext.request.contextPath}/client/change-password" class="btn btn-password">Change Password</a>
  </div>
  
  <!-- Edit Profile Form (Hidden by default) -->
  <div id="editProfileForm" style="display: none; margin-top: 30px;">
    <h2>Edit Profile</h2>
    <form action="${pageContext.request.contextPath}/client/my-profile" method="post">
      <div class="form-group">
        <label for="fullName">Full Name:</label>
        <input type="text" id="fullName" name="fullName" value="${user.fullName}" required>
      </div>
      
      <div class="form-group">
        <label for="email">Email:</label>
        <input type="email" id="email" name="email" value="${user.email}" required>
      </div>
      
      <div class="form-group">
        <label for="phone">Phone:</label>
        <input type="text" id="phone" name="phone" value="${user.phone}" required>
      </div>
      
      <div class="form-group">
        <label for="address">Address:</label>
        <input type="text" id="address" name="address" value="${user.address}" required>
      </div>
      
      <div class="form-group">
        <label for="gender">Gender:</label>
        <select id="gender" name="gender">
          <option value="Male" ${user.gender == 'Male' ? 'selected' : ''}>Male</option>
          <option value="Female" ${user.gender == 'Female' ? 'selected' : ''}>Female</option>
          <option value="Other" ${user.gender == 'Other' ? 'selected' : ''}>Other</option>
        </select>
      </div>
      
      <div class="button-group">
        <button type="submit" class="btn btn-save">Save Changes</button>
        <button type="button" id="cancelEditBtn" class="btn btn-cancel">Cancel</button>
      </div>
    </form>
  </div>
</div>

<script>
  // Toggle edit profile form
  document.getElementById('editProfileBtn').addEventListener('click', function() {
    document.getElementById('editProfileForm').style.display = 'block';
  });
  
  document.getElementById('cancelEditBtn').addEventListener('click', function() {
    document.getElementById('editProfileForm').style.display = 'none';
  });
</script>
<script>
  // No JavaScript needed for hover-based dropdown
</script>
</body>
</html>