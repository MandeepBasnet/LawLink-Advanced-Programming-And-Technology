<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>LawLink | Admin Clients</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/adminStyle.css">
</head>
<body>
<jsp:include page="common/header.jsp" />

<div class="main-container">
    <jsp:include page="common/sidebar.jsp">
        <jsp:param name="activePage" value="clients" />
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
        <div class="clients-section">
            <h2 class="section-title">All Clients</h2>
            <table class="clients-table">
                <thead>
                <tr>
                    <th>S.N.</th>
                    <th>Client</th>
                    <th>Username</th>
                    <th>Address</th>
                    <th>Email</th>
                    <th>Phone</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${clients}" var="client" varStatus="loop">
                    <tr>
                        <td><c:out value="${loop.count}" /></td>
                        <td>
                            <img src="${pageContext.request.contextPath}/assets/images/<c:out value='${empty client.profileImage ? "default.png" : client.profileImage}' />" alt="<c:out value='${client.fullName}' />" class="client-avatar">
                            <c:out value="${client.fullName}" />
                        </td>
                        <td><c:out value="${client.username}" /></td>
                        <td><c:out value="${client.address}" default="N/A" /></td>
                        <td><c:out value="${client.email}" /></td>
                        <td><c:out value="${client.phone}" default="N/A" /></td>
                    </tr>
                </c:forEach>
                <c:if test="${empty clients}">
                    <tr>
                        <td colspan="6">No clients found.</td>
                    </tr>
                </c:if>
                </tbody>
            </table>
        </div>
    </main>
</div>
</body>
</html>