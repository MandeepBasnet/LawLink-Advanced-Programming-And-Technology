<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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

    <main class="main-content">
        <div class="dashboard-stats">
            <div class="stat-card">
                <img src="${pageContext.request.contextPath}/assets/images/appointment_icon.svg" alt="Appointments" class="stat-icon">
                <h3 class="stat-number"><c:out value="${todayAppointmentsCount}" default="0" /></h3>
                <p class="stat-label">Today's Appointments</p>
            </div>
            <div class="stat-card">
                <img src="${pageContext.request.contextPath}/assets/images/add_icon.svg" alt="Experience" class="stat-icon">
                <h3 class="stat-number"><c:out value="${lawyer.experienceYears != null ? lawyer.experienceYears : 0}" /> years</h3>
                <p class="stat-label">Experience</p>
            </div>
            <div class="stat-card">
                <img src="${pageContext.request.contextPath}/assets/images/family-law.png" alt="Specialization" class="stat-icon">
                <h3 class="stat-number"><c:out value="${lawyer.specialization != null ? lawyer.specialization : 'N/A'}" /></h3>
                <p class="stat-label">Service</p>
            </div>
            <div class="stat-card">
                <img src="${pageContext.request.contextPath}/assets/images/cross_icon.png" alt="Rating" class="stat-icon">
                <h3 class="stat-number"><c:out value="${lawyer.rating != null ? lawyer.rating : 0.0}" /></h3>
                <p class="stat-label">Rating</p>
            </div>
        </div>

        <div class="appointments-section">
            <h2 class="section-title">Upcoming Appointments</h2>
            <table class="appointments-table">
                <thead>
                <tr>
                    <th>S.N.</th>
                    <th>Client</th>
                    <th>Time</th>
                    <th>Status</th>
                </tr>
                </thead>
                <tbody>
                <c:set var="hasUpcoming" value="false" />
                <c:forEach items="${appointments}" var="appointment" varStatus="loop">
                    <c:if test="${appointment.appointmentDate != null && appointment.appointmentDate.toLocalDate() >= '2025-05-01' && appointment.status != 'CANCELLED' && appointment.status != 'COMPLETED'}">
                        <c:set var="hasUpcoming" value="true" />
                        <tr>
                            <td><c:out value="${loop.count}" /></td>
                            <td>
                                <img src="${pageContext.request.contextPath}/assets/images/profile_pic.png" alt="${appointment.clientName}" class="client-avatar">
                                <c:out value="${appointment.clientName}" />
                            </td>
                            <td><c:out value="${appointment.appointmentTime}" /></td>
                            <td>
                                <span class="status-badge ${fn:toLowerCase(appointment.status)}">
                                    <c:out value="${appointment.status}" />
                                </span>
                            </td>
                        </tr>
                    </c:if>
                </c:forEach>
                <c:if test="${!hasUpcoming}">
                    <tr>
                        <td colspan="4">No upcoming appointments found.</td>
                    </tr>
                </c:if>
                </tbody>
            </table>
        </div>

        <div class="reviews-section">
            <div class="section-header">
                <h2 class="section-title">Recent Reviews</h2>
                <a href="${pageContext.request.contextPath}/lawyer/all-reviews" class="action-btn">See All</a>
            </div>
            <div class="reviews-container">
                <c:set var="reviewCount" value="0" />
                <c:forEach items="${appointments}" var="appointment" varStatus="loop">
                    <c:if test="${appointment.status == 'COMPLETED' && reviewCount < 3}">
                        <c:set var="review" value="${reviewMap[appointment.appointmentId]}" />
                        <c:if test="${review != null}">
                            <c:set var="reviewCount" value="${reviewCount + 1}" />
                            <div class="review-card">
                                <div class="review-header">
                                    <img src="${pageContext.request.contextPath}/assets/images/profile_pic.png" alt="${appointment.clientName}" class="reviewer-avatar">
                                    <div class="reviewer-info">
                                        <div class="reviewer-name"><c:out value="${appointment.clientName}" /></div>
                                    </div>
                                </div>
                                <div class="review-rating">
                                    <c:forEach begin="1" end="5" var="i">
                                        <c:choose>
                                            <c:when test="${i <= review.rating}">
                                                <span>★</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span>☆</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                </div>
                                <div class="review-comment">"<c:out value="${review.comment}" default="No review available" />"</div>
                                <div class="review-date">Comment at: <fmt:formatDate value="${appointment.appointmentDate}" pattern="dd MMMM, yyyy" /></div>
                            </div>
                        </c:if>
                    </c:if>
                </c:forEach>
                <c:if test="${reviewCount == 0}">
                    <div class="review-card">No recent reviews found.</div>
                </c:if>
            </div>
        </div>
    </main>
</div>
</body>
</html>