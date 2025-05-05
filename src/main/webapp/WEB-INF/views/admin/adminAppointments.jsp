<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>LawLink | Admin Appointments</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/adminStyle.css">
</head>
<body>
<jsp:include page="common/header.jsp" />

<div class="main-container">
    <jsp:include page="common/sidebar.jsp">
        <jsp:param name="activePage" value="appointments" />
    </jsp:include>

    <main class="main-content">
        <div class="dashboard-stats">
            <div class="stat-card">
                <img src="${pageContext.request.contextPath}/assets/images/clients_icon.svg" alt="Clients Icon" class="stat-icon">
                <h3 class="stat-number"><c:out value="${clientCount}" default="0" /></h3>
                <p class="stat-label">Clients</p>
            </div>
            <div class="stat-card">
                <img src="${pageContext.request.contextPath}/assets/images/lawyer_icon.png" alt="Lawyers Icon" class="stat-icon">
                <h3 class="stat-number"><c:out value="${lawyerCount}" default="0" /></h3>
                <p class="stat-label">Lawyers</p>
            </div>
            <div class="stat-card">
                <img src="${pageContext.request.contextPath}/assets/images/appointments_icon.svg" alt="Appointments Icon" class="stat-icon">
                <h3 class="stat-number"><c:out value="${appointmentCount}" default="0" /></h3>
                <p class="stat-label">Appointments</p>
            </div>
        </div>
        <div class="appointments">
            <h2 class="section-title">All Appointments</h2>
            <table class="appointments-table">
                <thead>
                <tr>
                    <th>S.N.</th>
                    <th>Client</th>
                    <th>Date and Time</th>
                    <th>Lawyer</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${appointments}" var="appointment" varStatus="loop">
                    <tr>
                        <td><c:out value="${loop.count}" /></td>
                        <td>
                            <c:out value="${appointment.clientName}" />
                        </td>
                        <td><c:out value="${appointment.appointmentDate} ${appointment.appointmentTime}" /></td>
                        <td>
                            <c:out value="${appointment.lawyerName}" />
                        </td>
                        <td>
                            <span class="status-badge ${fn:toLowerCase(appointment.status)}">
                                <c:out value="${appointment.status}" />
                            </span>
                        </td>
                        <td>
                            <c:if test="${appointment.status != 'CANCELLED' && appointment.status != 'COMPLETED'}">
                                <button class="action-btn" onclick="cancelAppointment(<c:out value='${appointment.appointmentId}' />)">
                                    <img src="${pageContext.request.contextPath}/assets/images/cancel_icon.svg" alt="Cancel">
                                </button>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty appointments}">
                    <tr>
                        <td colspan="6">No appointments found.</td>
                    </tr>
                </c:if>
                </tbody>
            </table>
        </div>
    </main>
</div>
<script>
    function cancelAppointment(appointmentId) {
        if (confirm('Are you sure you want to cancel this appointment?')) {
            fetch('${pageContext.request.contextPath}/admin/cancel-appointment', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: 'appointmentId=' + appointmentId
            }).then(response => {
                if (response.ok) {
                    location.reload();
                } else {
                    alert('Failed to cancel appointment.');
                }
            }).catch(error => {
                console.error('Error:', error);
                alert('An error occurred.');
            });
        }
    }
</script>
</body>
</html>