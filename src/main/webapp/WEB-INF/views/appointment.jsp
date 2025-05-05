<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book Appointment - LawLink</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
</head>
<body>
<!-- Header Section -->
<jsp:include page="includes/header.jsp" />

<!-- Lawyers Grid -->
<div class="lawyers-container">
    <c:choose>
        <c:when test="${not empty lawyers}">
            <c:forEach var="lawyer" items="${lawyers}">
                <div class="lawyer-card">
                    <div class="lawyer-image">
                        <img src="${pageContext.request.contextPath}/assets/images/${lawyer.profileImage}" alt="${lawyer.fullName}" onerror="this.src='${pageContext.request.contextPath}/assets/images/profile_pic.png'">
                    </div>
                    <div class="lawyer-info">
                        <h2 class="lawyer-name">${lawyer.fullName}</h2>
                        <p class="lawyer-title">${lawyer.specialization}</p>
                        <p class="lawyer-location"><i class="fas fa-map-marker-alt"></i> ${lawyer.address}</p>
                        <p class="lawyer-phone"><i class="fas fa-phone"></i> Contact: ${lawyer.phone}</p>
                        <form action="${pageContext.request.contextPath}/client/book-appointment-page" method="get" style="margin:0;">
                            <input type="hidden" name="lawyerId" value="${lawyer.lawyerId}">
                            <button type="submit" class="book-button">Book now!</button>
                        </form>
                    </div>
                </div>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <!-- Fallback hardcoded lawyers -->
            <div class="lawyer-card">
                <div class="lawyer-image">
                    <img src="${pageContext.request.contextPath}/assets/images/zaina.png" alt="Zaina Rai" onerror="this.src='${pageContext.request.contextPath}/assets/images/profile_pic.png'">
                </div>
                <div class="lawyer-info">
                    <h2 class="lawyer-name">Zaina Rai</h2>
                    <p class="lawyer-title">Principal senior advisor</p>
                    <p class="lawyer-location"><i class="fas fa-map-marker-alt"></i> Itahari</p>
                    <p class="lawyer-phone"><i class="fas fa-phone"></i> Phone NO: +977-9086706541</p>
                    <form action="${pageContext.request.contextPath}/client/book-appointment-page" method="get" style="margin:0;">
                        <input type="hidden" name="lawyerId" value="1">
                        <button type="submit" class="book-button">Book her now!</button>
                    </form>
                </div>
            </div>
            <div class="lawyer-card">
                <div class="lawyer-image">
                    <img src="${pageContext.request.contextPath}/assets/images/rayan.png" alt="Rayan Rajbangsi" onerror="this.src='${pageContext.request.contextPath}/assets/images/profile_pic.png'">
                </div>
                <div class="lawyer-info">
                    <h2 class="lawyer-name">Rayan Rajbangsi</h2>
                    <p class="lawyer-title">Manager partner</p>
                    <p class="lawyer-location"><i class="fas fa-map-marker-alt"></i> Itahari</p>
                    <p class="lawyer-phone"><i class="fas fa-phone"></i> Phone NO: +977-9705523049</p>
                    <form action="${pageContext.request.contextPath}/client/book-appointment-page" method="get" style="margin:0;">
                        <input type="hidden" name="lawyerId" value="2">
                        <button type="submit" class="book-button">Book him now!</button>
                    </form>
                </div>
            </div>
            <div class="lawyer-card">
                <div class="lawyer-image">
                    <img src="${pageContext.request.contextPath}/assets/images/manish.png" alt="Manish Khanal" onerror="this.src='${pageContext.request.contextPath}/assets/images/profile_pic.png ваше имя'">
                </div>
                <div class="lawyer-info">
                    <h2 class="lawyer-name">Manish Khanal</h2>
                    <p class="lawyer-title">Legal Associate</p>
                    <p class="lawyer-location"><i class="fas fa-map-marker-alt"></i> Kathmandu</p>
                    <p class="lawyer-phone"><i class="fas fa-phone"></i> Contact NO: +977-9812395010</p>
                    <form action="${pageContext.request.contextPath}/client/book-appointment-page" method="get" style="margin:0;">
                        <input type="hidden" name="lawyerId" value="3">
                        <button type="submit" class="book-button">Book him now!</button>
                    </form>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
</div>
<jsp:include page="includes/footer.jsp" />
</body>
</html>