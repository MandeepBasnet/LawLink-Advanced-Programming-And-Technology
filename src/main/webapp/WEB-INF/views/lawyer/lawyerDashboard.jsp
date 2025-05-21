<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - LawLink</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/lawyerStyle.css">
    <style>
        .action-buttons {
            display: flex;
            gap: 10px;
            align-items: center;
        }

        .action-icon {
            background-color: transparent;
            border: none;
            width: 30px;
            height: 30px;
            border-radius: 50%;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .action-icon:hover {
            background-color: transparent;
        }

        .action-btn {
            background-color: #f5f5f5;
            border: none;
            width: 30px;
            height: 30px;
            border-radius: 50%;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: background-color 0.3s ease;
            text-decoration: none;
            color: #333;
            font-size: 14px;
        }

        .action-btn:hover {
            background-color: #e0e0e0;
        }
    </style>
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
        <c:if test="${not empty success}">
            <div class="alert alert-success"><c:out value="${success}" /></div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-danger"><c:out value="${error}" /></div>
        </c:if>

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
                    <th>Action</th>
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
                            <td><fmt:formatDate value="${appointment.appointmentDate}" pattern="dd MMMM, yyyy" /> | <fmt:formatDate value="${appointment.appointmentTime}" pattern="hh:mm a" /></td>
                            <td>
                                <span class="status-badge ${fn:toLowerCase(appointment.status)}">
                                    <c:out value="${appointment.status}" />
                                </span>
                            </td>
                            <td>
                                <div class="action-buttons">
                                    <c:choose>
                                        <c:when test="${empty sessionScope.csrfToken}">
                                            <span class="action-disabled" title="Please log in again to perform this action">Cancel</span>
                                        </c:when>
                                        <c:otherwise>
                                            <img class="action-icon cancel-icon" src="${pageContext.request.contextPath}/assets/images/cancel_icon.svg" alt="Cancel" onclick="cancelAppointment(<c:out value='${appointment.appointmentId}' />, '${fn:escapeXml(sessionScope.csrfToken)}')">
                                        </c:otherwise>
                                    </c:choose>
                                    <c:if test="${appointment.status != 'CONFIRMED'}">
                                        <c:choose>
                                            <c:when test="${empty sessionScope.csrfToken}">
                                                <span class="action-disabled" title="Please log in again to perform this action">Confirm</span>
                                            </c:when>
                                            <c:otherwise>
                                                <img class="action-icon confirm-icon" src="${pageContext.request.contextPath}/assets/images/tick_icon.svg" alt="Confirm" onclick="confirmAppointment(<c:out value='${appointment.appointmentId}' />, '${fn:escapeXml(sessionScope.csrfToken)}')">
                                            </c:otherwise>
                                        </c:choose>
                                    </c:if>
                                    <c:choose>
                                        <c:when test="${empty sessionScope.csrfToken}">
                                            <span class="action-disabled" title="Please log in again to perform this action">Complete</span>
                                        </c:when>
                                        <c:otherwise>
                                            <img class="action-icon complete-icon" src="${pageContext.request.contextPath}/assets/images/tick_icon.svg" alt="Complete" onclick="completeAppointment(<c:out value='${appointment.appointmentId}' />, '${fn:escapeXml(sessionScope.csrfToken)}')">
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </td>
                        </tr>
                    </c:if>
                </c:forEach>
                <c:if test="${!hasUpcoming}">
                    <tr>
                        <td colspan="5">No upcoming appointments found.</td>
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
<script>
    function cancelAppointment(appointmentId, csrfToken) {
        if (!csrfToken) {
            alert('Session expired or invalid. Please log in again.');
            window.location.href = '${pageContext.request.contextPath}/log-in';
            return;
        }
        if (confirm('Are you sure you want to cancel this appointment?')) {
            fetch('${pageContext.request.contextPath}/lawyer/cancel-appointment', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: 'appointmentId=' + appointmentId + '&csrfToken=' + encodeURIComponent(csrfToken)
            }).then(response => {
                if (response.ok) {
                    window.location.reload();
                } else {
                    return response.text().then(text => {
                        alert('Failed to cancel appointment: ' + (text || 'Unknown error'));
                        console.error('Server response:', text);
                    });
                }
            }).catch(error => {
                console.error('Error:', error);
                alert('An error occurred while cancelling the appointment.');
            });
        }
    }

    function confirmAppointment(appointmentId, csrfToken) {
        if (!csrfToken) {
            alert('Session expired or invalid. Please log in again.');
            window.location.href = '${pageContext.request.contextPath}/log-in';
            return;
        }
        if (confirm('Are you sure you want to confirm this appointment?')) {
            fetch('${pageContext.request.contextPath}/lawyer/confirm-appointment', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: 'appointmentId=' + appointmentId + '&csrfToken=' + encodeURIComponent(csrfToken)
            }).then(response => {
                if (response.ok) {
                    window.location.reload();
                } else {
                    return response.text().then(text => {
                        alert('Failed to confirm appointment: ' + (text || 'Unknown error'));
                        console.error('Server response:', text);
                    });
                }
            }).catch(error => {
                console.error('Error:', error);
                alert('An error occurred while confirming the appointment.');
            });
        }
    }

    function completeAppointment(appointmentId, csrfToken) {
        if (!csrfToken) {
            alert('Session expired or invalid. Please log in again.');
            window.location.href = '${pageContext.request.contextPath}/log-in';
            return;
        }
        if (confirm('Are you sure you want to mark this appointment as completed?')) {
            fetch('${pageContext.request.contextPath}/lawyer/complete-appointment', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: 'appointmentId=' + appointmentId + '&csrfToken=' + encodeURIComponent(csrfToken)
            }).then(response => {
                if (response.ok) {
                    window.location.reload();
                } else {
                    return response.text().then(text => {
                        alert('Failed to mark appointment as completed: ' + (text || 'Unknown error'));
                        console.error('Server response:', text);
                    });
                }
            }).catch(error => {
                console.error('Error:', error);
                alert('An error occurred while marking the appointment as completed.');
            });
        }
    }
</script>
</body>
</html>