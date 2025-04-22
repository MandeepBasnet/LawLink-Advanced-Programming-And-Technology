<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - LawLink</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/WEB-INF/views/lawyer/css/style.css">
</head>
<body>
    <jsp:include page="common/header.jsp" />
    
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
                    <img src="${pageContext.request.contextPath}/assets/images/experience.png" alt="Experience" class="stat-icon">
                    <div class="stat-number">8 years</div>
                    <div class="stat-label">Experience till now</div>
                </div>
                <div class="stat-card">
                    <img src="${pageContext.request.contextPath}/assets/images/specialization.png" alt="Specialization" class="stat-icon">
                    <div class="stat-number">Family Law</div>
                    <div class="stat-label">Service</div>
                </div>
                <div class="stat-card">
                    <img src="${pageContext.request.contextPath}/assets/images/rating.png" alt="Rating" class="stat-icon">
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

                    <div class="appointment-item">
                        <img src="${pageContext.request.contextPath}/assets/images/profile_pic.png" alt="Birkbey Pandey" class="client-avatar">
                        <div class="appointment-details">
                            <div class="client-name">Birkbey Pandey</div>
                            <div class="appointment-time">Time: 10:40 AM</div>
                        </div>
                        <span class="appointment-status status-pending">Pending</span>
                    </div>

                    <div class="appointment-item">
                        <img src="${pageContext.request.contextPath}/assets/images/profile_pic.png" alt="Sailo Bahadur Khatri" class="client-avatar">
                        <div class="appointment-details">
                            <div class="client-name">Sailo Bahadur Khatri</div>
                            <div class="appointment-time">Time: 10:30 AM</div>
                        </div>
                        <span class="appointment-status status-pending">Pending</span>
                    </div>

                    <div class="appointment-item">
                        <img src="${pageContext.request.contextPath}/assets/images/profile_pic.png" alt="Dhruva Prasad Koirala" class="client-avatar">
                        <div class="appointment-details">
                            <div class="client-name">Dhruva Prasad Koirala</div>
                            <div class="appointment-time">Time: 10:30 AM</div>
                        </div>
                        <span class="appointment-status status-pending">Pending</span>
                    </div>

                    <div class="appointment-item">
                        <img src="${pageContext.request.contextPath}/assets/images/profile_pic.png" alt="Nawaraj Thapa" class="client-avatar">
                        <div class="appointment-details">
                            <div class="client-name">Nawaraj Thapa</div>
                            <div class="appointment-time">Time: 10:20 AM</div>
                        </div>
                        <span class="appointment-status status-pending">Pending</span>
                    </div>
                </div>
            </div>

            <div class="reviews-section">
                <div class="section-header">
                    <h2 class="section-title">Recent Reviews</h2>
                    <a href="${pageContext.request.contextPath}/all-reviews" class="btn-link">See All</a>
                </div>
                <div class="review-list">
                    <div class="review-card">
                        <div class="review-content">"Very professional and explained everything clearly."</div>
                    </div>
                    <div class="review-card">
                        <div class="review-content">"Helped me win a tough property dispute."</div>
                    </div>
                    <div class="review-card">
                        <div class="review-content">"Quick to respond and very supportive."</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
