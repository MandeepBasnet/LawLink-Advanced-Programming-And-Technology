<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>My Appointments - LawLink</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/clientStyle.css?v=1">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" />
</head>
<body>
<!-- Navigation Bar -->
<header>
  <div class="container header-content">
    <div class="logo-container">
      <img src="${pageContext.request.contextPath}/assets/images/logo.png" alt="LawLink Logo" class="logo">
      <span class="logo-text">LawLink</span>
    </div>
    <nav>
      <ul>
        <li><a href="${pageContext.request.contextPath}/home">Home</a></li>
        <li><a href="${pageContext.request.contextPath}/appointment">Appointments</a></li>
        <li><a href="${pageContext.request.contextPath}/lawyers">Lawyers</a></li>
        <li><a href="${pageContext.request.contextPath}/about-us">About Us</a></li>
        <li><a href="${pageContext.request.contextPath}/contact-us">Contact Us</a></li>
        <c:choose>
          <c:when test="${empty sessionScope.user}">
            <li><a href="${pageContext.request.contextPath}/log-in" class="login-btn">Log In</a></li>
          </c:when>
          <c:otherwise>
            <li>
              <div class="profile">
                <c:choose>
                  <c:when test="${not empty sessionScope.user.profileImage}">
                    <img src="${pageContext.request.contextPath}/${sessionScope.user.profileImage}" alt="Profile" class="profile-img">
                  </c:when>
                  <c:otherwise>
                    <img src="${pageContext.request.contextPath}/assets/images/profile_pic.png" alt="Profile" class="profile-img">
                  </c:otherwise>
                </c:choose>
                <div class="profile-menu">
                  <a href="${pageContext.request.contextPath}/client/my-appointments">My Appointments</a>
                  <a href="${pageContext.request.contextPath}/client/my-profile">My Profile</a>
                  <form action="${pageContext.request.contextPath}/logout" method="post" style="margin:0;">
                    <input type="hidden" name="csrfToken" value="${sessionScope.csrfToken}">
                    <button type="submit">Logout</button>
                  </form>
                </div>
              </div>
            </li>
          </c:otherwise>
        </c:choose>
      </ul>
    </nav>
  </div>
</header>

<!-- Main Content -->
<div class="container">
  <h1>My Appointments</h1>

  <c:if test="${not empty success}">
    <div class="alert alert-success"><c:out value="${success}" /></div>
  </c:if>
  <c:if test="${not empty error}">
    <div class="alert alert-danger"><c:out value="${error}" /></div>
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
              <div class="lawyer-name"><c:out value="${appointment.lawyerName}" /></div>
              <div class="lawyer-specialty"><c:out value="${appointment.lawyer.specialization}" /></div>
              <div class="appointment-info"><strong>Address:</strong> <c:out value="${appointment.lawyer.address}" /></div>
              <div class="appointment-info"><strong>Date & Time:</strong>
                <fmt:formatDate value="${appointment.appointmentDate}" pattern="dd MMMM, yyyy" /> |
                <fmt:formatDate value="${appointment.appointmentTime}" pattern="hh:mm a" />
              </div>
              <div class="appointment-info"><strong>Contact:</strong> <c:out value="${appointment.lawyer.phone}" /></div>
              <div class="appointment-info"><strong>Status:</strong> <c:out value="${appointment.status}" /></div>
            </div>

            <div class="appointment-actions">
              <c:choose>
                <c:when test="${appointment.status == 'PENDING' || appointment.status == 'CONFIRMED'}">
                  <form action="${pageContext.request.contextPath}/client/cancel-appointment" method="post" onsubmit="return confirm('Are you sure you want to cancel this appointment?');">
                    <input type="hidden" name="appointmentId" value="${appointment.appointmentId}">
                    <input type="hidden" name="csrfToken" value="${sessionScope.csrfToken}">
                    <button type="submit" class="btn btn-cancel">Cancel Appointment</button>
                  </form>
                </c:when>
                <c:when test="${appointment.status == 'COMPLETED'}">
                  <form action="${pageContext.request.contextPath}/client/reviews" method="get">
                    <input type="hidden" name="appointmentId" value="${appointment.appointmentId}">
                    <input type="hidden" name="csrfToken" value="${sessionScope.csrfToken}">
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

<script>
  document.addEventListener('DOMContentLoaded', () => {
    // Toggle profile menu on click for mobile devices
    const profile = document.querySelector('.profile');
    const profileImg = document.querySelector('.profile-img');
    if (profile && profileImg) {
      profileImg.addEventListener('click', () => {
        profile.classList.toggle('active');
      });
      // Close menu when clicking outside
      document.addEventListener('click', (e) => {
        if (!profile.contains(e.target)) {
          profile.classList.remove('active');
        }
      });
    }
  });
</script>
</body>
</html>