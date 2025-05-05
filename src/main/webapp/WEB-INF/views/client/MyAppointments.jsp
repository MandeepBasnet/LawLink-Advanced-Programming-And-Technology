<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>My Appointments - LawLink</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/clientStyle.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" />
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

  <c:if test="${not empty success}">
    <div class="alert alert-success">${success}</div>
    <% session.removeAttribute("success"); %>
  </c:if>
  <c:if test="${not empty error}">
    <div class="alert alert-danger">${error}</div>
    <% session.removeAttribute("error"); %>
  </c:if>

  <div class="appointment-list">
    <c:choose>
      <c:when test="${empty appointments}">
        <p>No appointments found.</p>
      </c:when>
      <c:otherwise>
        <c:forEach var="appointment" items="${appointments}">
          <div class="appointment-card">
            <img src="${pageContext.request.contextPath}/assets/images/${appointment.lawyer.profileImage}" alt="${appointment.lawyerName}" class="lawyer-img" onerror="this.src='${pageContext.request.contextPath}/assets/images/profile_pic.png'" />

            <div class="appointment-details">
              <div class="lawyer-name">${appointment.lawyerName}</div>
              <div class="lawyer-specialty">${appointment.lawyer.specialization}</div>
              <div class="appointment-info"><strong>Address:</strong> ${appointment.lawyer.address}</div>
              <div class="appointment-info"><strong>Date & Time:</strong>
                <fmt:formatDate value="${appointment.appointmentDate}" pattern="dd MMMM, yyyy" /> |
                <fmt:formatDate value="${appointment.appointmentTime}" pattern="hh:mm a" />
              </div>
              <div class="appointment-info"><strong>Contact:</strong> ${appointment.lawyer.phone}</div>
              <div class="appointment-info"><strong>Status:</strong> ${appointment.status}</div>
            </div>

            <div class="appointment-actions">
              <c:choose>
                <c:when test="${appointment.status == 'PENDING' || appointment.status == 'CONFIRMED'}">
                  <form action="${pageContext.request.contextPath}/client/cancel-appointment" method="post" onsubmit="return confirm('Are you sure you want to cancel this appointment?');">
                    <input type="hidden" name="appointmentId" value="${appointment.appointmentId}">
                    <button type="submit" class="btn btn-cancel">Cancel Appointment</button>
                  </form>
                </c:when>
                <c:when test="${appointment.status == 'COMPLETED'}">
                  <form action="${pageContext.request.contextPath}/client/reviews" method="get">
                    <input type="hidden" name="appointmentId" value="${appointment.appointmentId}">
                    <button type="submit" class="btn btn-leave_review">Leave Review</button>
                  </form>
                  <div class="btn btn-completed">Completed</div>
                </c:when>
                <c:when test="${appointment.status == 'CANCELLED'}">
                  <div class="btn btn-cancelled">Cancelled</div>
                </c:when>
              </c:choose>
            </div>
          </div>
        </c:forEach>
      </c:otherwise>
    </c:choose>
  </div>
</div>

<style>
  .alert {
    padding: 15px;
    margin-bottom: 20px;
    border-radius: 4px;
  }
  .alert-success {
    background-color: #d4edda;
    color: #155724;
    border: 1px solid #c3e6cb;
  }
  .alert-danger {
    background-color: #f8d7da;
    color: #721c24;
    border: 1px solid #f5c6cb;
  }
  .btn {
    padding: 8px 16px;
    border-radius: 4px;
    text-align: center;
    display: inline-block;
  }
  .btn-cancel {
    background-color: #dc3545;
    color: white;
    border: none;
    cursor: pointer;
  }
  .btn-cancelled {
    background-color: #6c757d;
    color: white;
  }
  .btn-completed {
    background-color: #28a745;
    color: white;
  }
  .btn-leave_review {
    background-color: #007bff;
    color: white;
    border: none;
    cursor: pointer;
  }
</style>
</body>
</html>