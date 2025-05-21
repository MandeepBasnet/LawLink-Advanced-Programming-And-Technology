<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
                <div class="stat-number"><c:out value="${todayAppointmentsCount}" default="0" /></div>
                <div class="stat-label">Today's Appointments</div>
            </div>
            <div class="stat-card">
                <img src="${pageContext.request.contextPath}/assets/images/add_icon.svg" alt="Experience" class="stat-icon">
                <div class="stat-number"><c:out value="${lawyer.experienceYears != null ? lawyer.experienceYears : 0}" /> years</div>
                <div class="stat-label">Experience till now</div>
            </div>
            <div class="stat-card">
                <img src="${pageContext.request.contextPath}/assets/images/family-law.png" alt="Specialization" class="stat-icon">
                <div class="stat-number"><c:out value="${lawyer.specialization != null ? lawyer.specialization : 'N/A'}" /></div>
                <div class="stat-label">Service</div>
            </div>
            <div class="stat-card">
                <img src="${pageContext.request.contextPath}/assets/images/cross_icon.png" alt="Rating" class="stat-icon">
                <div class="stat-number"><c:out value="${lawyer.rating != null ? lawyer.rating : 0.0}" /></div>
                <div class="stat-label">Appointment Rating</div>
            </div>
        </div>

        <div class="appointments-section">
            <h2 class="section-title">Upcoming Appointments</h2>
            <div class="appointments-list">
                <c:set var="hasUpcoming" value="false" />
                <c:forEach items="${appointments}" var="appointment">
                    <c:if test="${appointment.appointmentDate != null && appointment.appointmentDate.toLocalDate() >= '2025-05-01' && appointment.status != 'CANCELLED' && appointment.status != 'COMPLETED'}">
                        <c:set var="hasUpcoming" value="true" />
                        <div class="appointment-item">
                            <img src="${pageContext.request.contextPath}/assets/images/profile_pic.png" alt="${appointment.clientName}" class="client-avatar">
                            <div class="appointment-details">
                                <div class="client-name"><c:out value="${appointment.clientName}" /></div>
                                <div class="appointment-time">Time: <c:out value="${appointment.appointmentTime}" /></div>
                            </div>
                            <span class="appointment-status status-${fn:toLowerCase(appointment.status)}"><c:out value="${appointment.status}" /></span>
                        </div>
                    </c:if>
                </c:forEach>
                <c:if test="${!hasUpcoming}">
                    <div class="appointment-item">No upcoming appointments found.</div>
                </c:if>
            </div>
        </div>

        <div class="reviews-section">
            <div class="section-header">
                <h2 class="section-title">Recent Reviews</h2>
                <a href="${pageContext.request.contextPath}/lawyer/all-reviews" class="btn-link">See All</a>
            </div>
            <div class="review-list">
                <c:set var="reviewCount" value="0" />
                <c:forEach items="${appointments}" var="appointment">
                    <c:if test="${appointment.status == 'COMPLETED' && reviewCount < 3}">
                        <c:set var="review" value="${reviewMap[appointment.appointmentId]}" />
                        <c:if test="${review != null}">
                            <c:set var="reviewCount" value="${reviewCount + 1}" />
                            <div class="review-card">
                                <div class="review-content">"<c:out value="${review.comment}" default="No review available" />"</div>
                            </div>
                        </c:if>
                    </c:if>
                </c:forEach>
                <c:if test="${reviewCount == 0}">
                    <div class="review-card">No recent reviews found.</div>
                </c:if>
            </div>
        </div>
    </div>
</div>
</body>
</html>