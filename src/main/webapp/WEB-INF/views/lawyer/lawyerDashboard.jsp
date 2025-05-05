<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - LawLink</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/lawyerStyle.css">
</head>
<body>
<jsp:include page="common/header.jsp">
    <jsp:param name="pageTitle" value="Dashboard" />
</jsp:include>

<div class="main-container">
    <jsp:include page="common/sidebar.jsp">
        <jsp:param name="activePage" value="dashboard" />
    </jsp:include>

    <div class="main-content">
        <div class="dashboard-stats">
            <div class="stat-card">
                <img src="${pageContext.request.contextPath}/assets/images/appointment_icon.svg" alt="Appointments" class="stat-icon">
                <div class="stat-number">12</div>
                <div class="stat-label">Today's Appointments</div>
            </div>
            <div class="stat-card">
                <img src="${pageContext.request.contextPath}/assets/images/add_icon.svg" alt="Experience" class="stat-icon">
                <div class="stat-number">8 years</div>
                <div class="stat-label">Experience till now</div>
            </div>
            <div class="stat-card">
                <img src="${pageContext.request.contextPath}/assets/images/family-law.png" alt="Specialization" class="stat-icon">
                <div class="stat-number">Family Law</div>
                <div class="stat-label">Service</div>
            </div>
            <div class="stat-card">
                <img src="${pageContext.request.contextPath}/assets/images/cross_icon.png" alt="Rating" class="stat-icon">
                <div class="stat-number">4.5</div>
                <div class="stat-label">Appointment Rating</div>
            </div>
        </div>

        <div class="appointments-section">
            <h2 class="section-title">Upcoming Appointments</h2>
            <div class="appointments-list">
                <div class="appointment-item">
                    <img src="${pageContext.request.contextPath}/assets/images/profile_pic.png" alt="Madhuri Shrestha" class="client-avatar">
                    <div class="appointment-details">
                        <div class="client-name">Madhuri Shrestha</div>
                        <div class="appointment-time">Time: 10:30 AM</div>
                    </div>
                    <span class="appointment-status status-confirmed">Confirmed</span>
                </div>

                <!-- More appointment items here -->
            </div>
        </div>

        <div class="reviews-section">
            <div class="section-header">
                <h2 class="section-title">Recent Reviews</h2>
                <a href="${pageContext.request.contextPath}/lawyer/all-reviews" class="btn-link">See All</a>
            </div>
            <div class="review-list">
                <div class="review-card">
                    <div class="review-content">"Very professional and explained everything clearly."</div>
                </div>
                <!-- More review cards here -->
            </div>
        </div>
    </div>
</div>
<jsp:include page="common/footer.jsp" />
</body>
</html>