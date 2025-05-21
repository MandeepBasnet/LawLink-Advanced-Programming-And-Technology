<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>All Reviews - LawLink</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/lawyerStyle.css">
    <style>
        .reviews-title {
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 30px;
            color: #333;
        }

        .no-reviews {
            font-size: 16px;
            color: #333;
        }

        .reviews-container {
            max-width: 800px;
            margin: 0 auto;
        }

        .review-card {
            background-color: #a8b2b7;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            display: flex;
            flex-direction: column;
            gap: 10px;
            width: 100%;
            margin-bottom: 20px;
            position: relative;
        }

        .review-header {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .reviewer-avatar {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            object-fit: cover;
        }

        .reviewer-info {
            flex: 1;
        }

        .reviewer-name {
            font-weight: bold;
            color: #333;
            font-size: 18px;
            word-break: break-word;
        }

        .review-date {
            font-size: 12px;
            color: #555;
            position: absolute;
            right: 20px;
            bottom: 20px;
            word-break: break-word;
        }

        .review-rating {
            position: absolute;
            top: 20px;
            right: 20px;
            font-size: 16px;
            color: #FFD700; /* Gold color for stars */
        }

        @media (max-width: 768px) {
            .review-card {
                max-width: 100%;
                padding: 15px;
            }

            .review-header {
                flex-direction: column;
                align-items: flex-start;
            }

            .reviewer-info {
                margin-top: 10px;
            }

            .review-date {
                position: static;
                align-self: flex-end;
                margin-top: 10px;
            }

            .review-rating {
                position: static;
                align-self: flex-end;
                margin-bottom: 10px;
            }
        }
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/lawyer/common/header.jsp" />

<div class="main-container">
    <jsp:include page="common/sidebar.jsp"/>

    <div class="main-content">
        <h1 class="reviews-title">Your Reviews</h1>

        <div class="reviews-container">
            <c:choose>
                <c:when test="${empty reviews}">
                    <p class="no-reviews">No reviews available.</p>
                </c:when>
                <c:otherwise>
                    <c:forEach items="${reviews}" var="review">
                        <div class="review-card">
                            <div class="review-header">
                                <img src="${pageContext.request.contextPath}/assets/images/profile_pic.png" alt="${review.clientName}" class="reviewer-avatar">
                                <div class="reviewer-info">
                                    <div class="reviewer-name"><c:out value="${review.clientName}" /></div>
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
                            <div class="review-comment"><c:out value="${review.comment}" /></div>
                            <div class="review-date">Comment at: <fmt:formatDate value="${review.reviewDate}" pattern="dd MMMM, yyyy" /></div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>

            <!-- Placeholder reviews matching the Figma design -->
            <c:if test="${empty reviews}">
                <div class="review-card">
                    <div class="review-header">
                        <img src="${pageContext.request.contextPath}/assets/images/profile_pic.png" alt="Madhuri Shrestha" class="reviewer-avatar">
                        <div class="reviewer-info">
                            <div class="reviewer-name">Madhuri Shrestha</div>
                        </div>
                    </div>
                    <div class="review-rating">
                        <span>★</span><span>★</span><span>★</span><span>★</span><span>☆</span>
                    </div>
                    <div class="review-comment">"Very professional and explained everything clearly."</div>
                    <div class="review-date">Comment at: 18th Dec 2024, Tue</div>
                </div>

                <div class="review-card">
                    <div class="review-header">
                        <img src="${pageContext.request.contextPath}/assets/images/profile_pic.png" alt="Madhuri Shrestha" class="reviewer-avatar">
                        <div class="reviewer-info">
                            <div class="reviewer-name">Madhuri Shrestha</div>
                        </div>
                    </div>
                    <div class="review-rating">
                        <span>★</span><span>★</span><span>★</span><span>★</span><span>☆</span>
                    </div>
                    <div class="review-comment">"Very professional and explained everything clearly."</div>
                    <div class="review-date">Comment at: 18th Dec 2024, Tue</div>
                </div>

                <div class="review-card">
                    <div class="review-header">
                        <img src="${pageContext.request.contextPath}/assets/images/profile_pic.png" alt="Madhuri Shrestha" class="reviewer-avatar">
                        <div class="reviewer-info">
                            <div class="reviewer-name">Madhuri Shrestha</div>
                        </div>
                    </div>
                    <div class="review-rating">
                        <span>★</span><span>★</span><span>★</span><span>★</span><span>☆</span>
                    </div>
                    <div class="review-comment">"Very professional and explained everything clearly."</div>
                    <div class="review-date">Comment at: 18th Dec 2024, Tue</div>
                </div>

                <div class="review-card">
                    <div class="review-header">
                        <img src="${pageContext.request.contextPath}/assets/images/profile_pic.png" alt="Madhuri Shrestha" class="reviewer-avatar">
                        <div class="reviewer-info">
                            <div class="reviewer-name">Madhuri Shrestha</div>
                        </div>
                    </div>
                    <div class="review-rating">
                        <span>★</span><span>★</span><span>★</span><span>★</span><span>☆</span>
                    </div>
                    <div class="review-comment">"Very professional and explained everything clearly."</div>
                    <div class="review-date">Comment at: 18th Dec 2024, Tue</div>
                </div>
            </c:if>
        </div>
    </div>
</div>
</body>
</html>