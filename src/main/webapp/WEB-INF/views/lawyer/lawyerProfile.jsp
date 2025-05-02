<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile - LawLink</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/lawyerStyle.css">
</head>
<body>
<jsp:include page="common/header.jsp">
    <jsp:param name="pageTitle" value="Profile" />
</jsp:include>

<div class="main-container">
    <jsp:include page="common/sidebar.jsp">
        <jsp:param name="activePage" value="profile" />
    </jsp:include>

    <div class="main-content">
        <div class="profile-container">
            <div class="profile-header">
                <img src="${pageContext.request.contextPath}/assets/images/john.png" alt="John Thapa" class="profile-avatar">
                <h1 class="profile-name">John Thapa</h1>
            </div>

            <div class="info-section">
                <h2 class="info-title">Basic Information</h2>
                <div class="info-grid">
                    <div class="info-item">
                        <span class="info-label">Username</span>
                        <span class="info-value">john123</span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">Gender</span>
                        <span class="info-value">Male</span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">Date of Birth</span>
                        <span class="info-value">20 July, 2000</span>
                    </div>
                </div>
            </div>

            <div class="info-section">
                <h2 class="info-title">Contact Information</h2>
                <div class="info-grid">
                    <div class="info-item">
                        <span class="info-label">Email</span>
                        <span class="info-value">johnthapa@gmail.com</span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">Phone</span>
                        <span class="info-value">9812345678</span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">Address</span>
                        <span class="info-value">Itahari, Sunsari</span>
                    </div>
                </div>
            </div>

            <div class="button-group">
                <button class="btn-primary">Edit</button>
                <button class="btn-primary">Save</button>
                <button class="btn-primary">Change Password</button>
            </div>
        </div>
    </div>
</div>
<jsp:include page="common/footer.jsp" />
</body>
</html>