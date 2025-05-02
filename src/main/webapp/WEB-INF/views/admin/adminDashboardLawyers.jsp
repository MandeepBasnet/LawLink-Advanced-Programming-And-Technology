<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard Lawyers - LawLink</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/adminStyle.css">
</head>
<body>
<jsp:include page="common/header.jsp" />

<div class="main-container">
    <jsp:include page="common/sidebar.jsp">
        <jsp:param name="activePage" value="lawyers" />
    </jsp:include>

    <div class="main-content">
        <div class="dashboard-stats">
            <div class="stat-card">
                <img src="${pageContext.request.contextPath}/assets/images/clients_icon.svg" alt="Clients" class="stat-icon">
                <div class="stat-number">12</div>
                <div class="stat-label">Clients</div>
            </div>
            <div class="stat-card">
                <img src="${pageContext.request.contextPath}/assets/images/lawyer_icon.png" alt="Lawyers" class="stat-icon">
                <div class="stat-number">15</div>
                <div class="stat-label">Lawyers</div>
            </div>
            <div class="stat-card">
                <img src="${pageContext.request.contextPath}/assets/images/appointments_icon.svg" alt="Appointments" class="stat-icon">
                <div class="stat-number">12</div>
                <div class="stat-label">Appointments</div>
            </div>
        </div>

        <div class="lawyers-section">
            <h2 class="section-title">Lawyers</h2>

            <table class="lawyers-table">
                <thead>
                <tr>
                    <th>S.N.</th>
                    <th>Lawyer</th>
                    <th>Practice Area</th>
                    <th>Address</th>
                    <th>Email</th>
                    <th>Phone</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>1</td>
                    <td>
                        <img src="${pageContext.request.contextPath}/assets/images/susasa-acharaya.png" alt="Susasa Acharya" class="lawyer-avatar">
                        Susasa Acharya
                    </td>
                    <td>Property Law</td>
                    <td>Biratnagar</td>
                    <td>susasa@lawlink.com</td>
                    <td>9703129041</td>
                </tr>
                <tr>
                    <td>2</td>
                    <td>
                        <img src="${pageContext.request.contextPath}/assets/images/anish-basnet.png" alt="Anish Basnet" class="lawyer-avatar">
                        Anish Basnet
                    </td>
                    <td>Labour Law</td>
                    <td>Jhapa</td>
                    <td>anish@lawlink.com</td>
                    <td>9705203041</td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>
</body>
</html>
