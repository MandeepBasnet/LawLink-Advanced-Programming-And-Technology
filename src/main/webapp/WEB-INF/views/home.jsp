<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page import="model.User" %>
<%@ page session="true" %>

<%
    User loggedInUser = (User) session.getAttribute("user");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body>
<!-- Header Section -->
<jsp:include page="includes/header.jsp" />

<!-- Hero Section -->
<section class="hero">
    <div class="hero-container">
        <div class="hero-content">
            <h1>Innocent until proven guilty.</h1>
            <p>Organize your task through our LawLink.<br>We provide the best services.</p>
            <a href="${pageContext.request.contextPath}/appointment" class="cta-button">Book your appointment</a>
            <p class="phone-number"><i class="fas fa-phone"></i> or call us at ${contactPhone}</p>
        </div>
        <div class="hero-image">
            <img src="${pageContext.request.contextPath}/assets/images/jeniffer.png" alt="Professional Lawyer">
            <div class="experience-badge">10+ Year of experience</div>
        </div>
    </div>
    <div class="search-section">
        <p>Search by the name of attorney or practice areas.</p>
        <form action="${pageContext.request.contextPath}/search" method="get" class="search-form">
            <input type="text" name="query" placeholder="Search by name" class="search-input">
            <select name="practiceArea" class="search-dropdown">
                <option value="">Select practice area</option>
                <c:forEach var="practiceArea" items="${practiceAreas}">
                    <option value="${practiceArea.areaName}">${practiceArea.areaName}</option>
                </c:forEach>
            </select>
            <button type="submit" class="search-button">Search</button>
        </form>
    </div>
</section>

<!-- Attorneys Section -->
<section class="attorneys-section">
    <div class="attorneys-heading">
        <h2>MEET OUR MOST TALENTED ATTORNEYS</h2>
    </div>
    <div class="attorneys-description">
        <p>Their work involves legal research, courtroom representation, and the protection of both civil and criminal rights. With deep knowledge of the law, they stand as protectors of individual and public rights.</p>
    </div>
    <div class="attorneys-cta">
        <a href="${pageContext.request.contextPath}/appointment" class="book-appointment-btn">Book appointment</a>
    </div>
    <div class="attorney-profiles">
        <c:choose>
            <c:when test="${not empty attorneys}">
                <c:forEach var="attorney" items="${attorneys}">
                    <div class="attorney-card">
                        <img src="${pageContext.request.contextPath}/assets/images/${attorney.profileImage}" alt="${attorney.fullName}" onerror="this.src='${pageContext.request.contextPath}/assets/images/profile_pic.png'">
                        <div class="attorney-info">
                            <h3>${attorney.fullName}</h3>
                            <p>${attorney.aboutMe}</p>
                            <form action="${pageContext.request.contextPath}/client/book-appointment-page" method="get" style="margin:0;">
                                <input type="hidden" name="lawyerId" value="${attorney.lawyerId}">
                                <button type="submit" class="book-button">Book now!</button>
                            </form>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <!-- Fallback hardcoded attorneys -->
                <div class="attorney-card">
                    <img src="${pageContext.request.contextPath}/assets/images/zaina.png" alt="Zaina Rai" onerror="this.src='${pageContext.request.contextPath}/assets/images/profile_pic.png'">
                    <div class="attorney-info">
                        <h3>Zaina Rai</h3>
                        <p>She has won 100+ cases till now, one of the most demanding attorneys at your service.</p>
                        <form action="${pageContext.request.contextPath}/client/book-appointment-page" method="get" style="margin:0;">
                            <input type="hidden" name="lawyerId" value="1">
                            <button type="submit" class="book-button">Book now!</button>
                        </form>
                    </div>
                </div>
                <div class="attorney-card">
                    <img src="${pageContext.request.contextPath}/assets/images/rayan.png" alt="Rayan Rajbangsi" onerror="this.src='${pageContext.request.contextPath}/assets/images/profile_pic.png'">
                    <div class="attorney-info">
                        <h3>Rayan Rajbangsi</h3>
                        <p>With the experience of 5 years, he has been thriving in our company.</p>
                        <form action="${pageContext.request.contextPath}/client/book-appointment-page" method="get" style="margin:0;">
                            <input type="hidden" name="lawyerId" value="2">
                            <button type="submit" class="book-button">Book now!</button>
                        </form>
                    </div>
                </div>
                <div class="attorney-card">
                    <img src="${pageContext.request.contextPath}/assets/images/manish.png" alt="Manish Khanal" onerror="this.src='${pageContext.request.contextPath}/assets/images/profile_pic.png'">
                    <div class="attorney-info">
                        <h3>Manish Khanal</h3>
                        <p>Experienced lawyer specializing in Family Law.</p>
                        <form action="${pageContext.request.contextPath}/client/book-appointment-page" method="get" style="margin:0;">
                            <input type="hidden" name="lawyerId" value="3">
                            <button type="submit" class="book-button">Book now!</button>
                        </form>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</section>

<!-- Testimonials Section -->
<section class="testimonials-section">
    <h2 class="testimonials-heading">What does our client have to say about us?</h2>
    <div class="testimonial-container">
        <c:forEach var="testimonial" items="${testimonials}" varStatus="status">
            <div class="testimonial-card">
                <div class="testimonial-image">
                    <img src="${pageContext.request.contextPath}/assets/images/upload_area.png" alt="${testimonial.name}">
                </div>
                <div class="testimonial-content">
                    <h3>${testimonial.name}</h3>
                    <p class="position">${testimonial.position}</p>
                    <p>${testimonial.content}</p>
                </div>
            </div>
        </c:forEach>
        <c:if test="${empty testimonials}">
            <div class="testimonial-card">
                <div class="testimonial-image">
                    <img src="${pageContext.request.contextPath}/assets/images/john.png" alt="Jhon Basnet">
                </div>
                <div class="testimonial-content">
                    <h3>Jhon Basnet</h3>
                    <p class="position">Civil case client</p>
                    <p>I was facing a long and stressful property dispute, unsure if I'd ever find justice. But from the moment I consulted with Zaina, I knew I was in capable hands. Their deep understanding of the law, attention to detail, and calm professionalism helped me win the case confidently. I'm incredibly grateful for their support and highly recommend their services to anyone seeking legal guidance.</p>
                </div>
            </div>
        </c:if>
    </div>
</section>

<!-- Footer -->
<jsp:include page="includes/footer.jsp" />

<script>
    document.addEventListener('DOMContentLoaded', function() {
        console.log('Page loaded successfully');
        const searchForm = document.querySelector('.search-form');
        if (searchForm) {
            searchForm.addEventListener('submit', function(e) {
                const searchInput = document.querySelector('.search-input');
                const practiceArea = document.querySelector('.search-dropdown');
                if (searchInput.value.trim() === '' && practiceArea.value === '') {
                    e.preventDefault();
                    alert('Please enter a search term or select a practice area');
                }
            });
        }
    });
</script>
</body>
</html>