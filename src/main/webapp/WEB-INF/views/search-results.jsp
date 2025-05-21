<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search Results - LawLink</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
</head>
<body>
<!-- Header Section -->
<jsp:include page="includes/header.jsp" />

<!-- Search Results -->
<div class="lawyers-container">
    <h2 style="text-align: center; color: #1e3a8a; margin: 20px 0;">
        <c:choose>
            <c:when test="${not empty practiceArea}">
                Lawyers Specializing in ${practiceArea}
            </c:when>
            <c:otherwise>
                Search Results
            </c:otherwise>
        </c:choose>
    </h2>

    <c:if test="${not empty errorMessage}">
        <p style="text-align: center; color: red; font-weight: bold;">${errorMessage}</p>
    </c:if>

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
            <p style="text-align: center;">No lawyers found. Please try a different search term or practice area.</p>
            <p style="text-align: center;">
                <a href="${pageContext.request.contextPath}/home" class="cta-button">Back to Home</a>
            </p>
        </c:otherwise>
    </c:choose>
</div>

<!-- Footer -->
<jsp:include page="includes/footer.jsp" />
</body>
</html>