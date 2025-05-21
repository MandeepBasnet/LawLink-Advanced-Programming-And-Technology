<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>LawLink | Admin Lawyers</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/adminStyle.css">
</head>
<body>
<jsp:include page="common/header.jsp" />

<div class="main-container">
    <jsp:include page="common/sidebar.jsp">
        <jsp:param name="activePage" value="lawyers" />
    </jsp:include>

    <main class="main-content">
        <c:if test="${not empty successMessage}">
            <div class="success-message"><c:out value="${successMessage}" /></div>
        </c:if>
        <c:if test="${not empty errorMessage}">
            <div class="error-message"><c:out value="${errorMessage}" /></div>
        </c:if>

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

        <div class="lawyers">
            <h2 class="section-title">All Lawyers</h2>
            <table class="lawyers-table">
                <thead>
                <tr>
                    <th>S.N.</th>
                    <th>Lawyer</th>
                    <th>Practice Area</th>
                    <th>Address</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <th>Action</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${lawyers}" var="lawyer" varStatus="loop">
                    <tr>
                        <td><c:out value="${loop.count}" /></td>
                        <td>
                            <img src="${pageContext.request.contextPath}/${empty lawyer.profileImage ? 'assets/images/default.png' : lawyer.profileImage}?v=${System.currentTimeMillis()}" alt="<c:out value='${lawyer.fullName}' />" class="lawyer-avatar">
                            <c:out value="${lawyer.fullName}" />
                        </td>
                        <td><c:out value="${lawyer.practiceAreas}" default="${lawyer.specialization}" /></td>
                        <td><c:out value="${lawyer.address}" default="N/A" /></td>
                        <td><c:out value="${lawyer.email}" /></td>
                        <td><c:out value="${lawyer.phone}" default="N/A" /></td>
                        <td>
                            <form action="${pageContext.request.contextPath}/admin/delete-lawyer" method="post" onsubmit="return confirm('Are you sure you want to delete this lawyer?');">
                                <input type="hidden" name="lawyerId" value="${lawyer.lawyerId}">
                                <button type="submit" class="action-btn" title="Delete Lawyer">
                                    <img src="${pageContext.request.contextPath}/assets/images/delete_icon.png" alt="Delete Icon" class="action-icon">
                                </button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty lawyers}">
                    <tr>
                        <td colspan="7">No lawyers found.</td>
                    </tr>
                </c:if>
                </tbody>
            </table>
        </div>
    </main>
</div>
</body>
</html>