<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reviews - LawLink</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/WEB-INF/views/lawyer/css/style.css">
</head>
<body>
    <jsp:include page="common/header.jsp" />
    
    <div class="main-container">
        <jsp:include page="common/sidebar.jsp">
            <jsp:param name="activePage" value="reviews" />
        </jsp:include>

        <div class="main-content">
            <h2 class="section-title">Your Reviews</h2>
            
            <div class="reviews-list">
                <div class="review-card">
                    <div class="review-header">
                        <img src="${pageContext.request.contextPath}/assets/images/client1.jpg" alt="Madhuri Shrestha" class="reviewer-avatar">
                        <div class="reviewer-info">
                            <div class="reviewer-name">Madhuri Shrestha</div>
                            <div class="review-date">Comment at: 18th Dec 2024, Tue</div>
                        </div>
                    </div>
                    <div class="review-content">
                        "Very professional and explained everything clearly."
                    </div>
                </div>

                <div class="review-card">
                    <div class="review-header">
                        <img src="${pageContext.request.contextPath}/assets/images/client2.jpg" alt="Madhuri Shrestha" class="reviewer-avatar">
                        <div class="reviewer-info">
                            <div class="reviewer-name">Madhuri Shrestha</div>
                            <div class="review-date">Comment at: 18th Dec 2024, Tue</div>
                        </div>
                    </div>
                    <div class="review-content">
                        "Very professional and explained everything clearly."
                    </div>
                </div>

                <div class="review-card">
                    <div class="review-header">
                        <img src="${pageContext.request.contextPath}/assets/images/client3.jpg" alt="Madhuri Shrestha" class="reviewer-avatar">
                        <div class="reviewer-info">
                            <div class="reviewer-name">Madhuri Shrestha</div>
                            <div class="review-date">Comment at: 18th Dec 2024, Tue</div>
                        </div>
                    </div>
                    <div class="review-content">
                        "Very professional and explained everything clearly."
                    </div>
                </div>

                <div class="review-card">
                    <div class="review-header">
                        <img src="${pageContext.request.contextPath}/assets/images/client4.jpg" alt="Madhuri Shrestha" class="reviewer-avatar">
                        <div class="reviewer-info">
                            <div class="reviewer-name">Madhuri Shrestha</div>
                            <div class="review-date">Comment at: 18th Dec 2024, Tue</div>
                        </div>
                    </div>
                    <div class="review-content">
                        "Very professional and explained everything clearly."
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html> 