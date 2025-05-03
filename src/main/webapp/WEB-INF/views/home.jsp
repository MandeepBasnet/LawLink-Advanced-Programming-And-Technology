<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
            <p class="phone-number"><i class="fas fa-phone"></i> or call us at +977-9812345678</p>
        </div>
        <div class="hero-image">
            <img src="${pageContext.request.contextPath}/assets/images/jeniffer.png" alt="Professional Lawyer">
            <div class="experience-badge">10+ Year of experience</div>
        </div>
    </div>
    <div class="search-section">
        <p>Search by the name of attorney and practice areas.</p>
        <form action="${pageContext.request.contextPath}/search" method="get" class="search-form">
            <input type="text" name="query" placeholder="Search" class="search-input">
            <select name="practiceArea" class="search-dropdown">
                <option value="">Practice area</option>
                <option value="criminal">Criminal Law</option>
                <option value="labour">Labour Law</option>
                <option value="international">International Law</option>
                <option value="property">Property Law</option>
                <option value="corporate">Corporate Law</option>
                <option value="family">Family Law</option>
            </select>
            <button type="submit" class="search-button">Search</button>
        </form>
    </div>
</section>

<!-- Attorneys Section -->
<section class="attorneys-section">
    <div class="attorneys-heading">
        <h2>MEET OUR MOST TALANTED ATTORNEYS</h2>
    </div>
    <div class="attorneys-description">
        <p>Their work involves legal research, courtroom representation, and the protection of both civil and criminal rights. With deep knowledge of the law, they stand as protectors of individual and public rights.</p>
    </div>
    <div class="attorneys-cta">
        <a href="${pageContext.request.contextPath}/appointment" class="book-appointment-btn">Book appointment</a>
    </div>
    <div class="attorney-profiles">
        <c:forEach var="attorney" items="${attorneys}" varStatus="status">
            <div class="attorney-card">
                <img src="${pageContext.request.contextPath}/images/attorneys/${attorney.imageFile}" alt="${attorney.name}">
                <div class="attorney-info">
                    <h3>${attorney.name}</h3>
                    <p>${attorney.description}</p>
                    <a href="${pageContext.request.contextPath}/book/${attorney.id}" class="book-button">Book now!</a>
                </div>
            </div>
        </c:forEach>
        <c:if test="${empty attorneys}">
            <div class="attorney-card">
                <img src="${pageContext.request.contextPath}/assets/images/zaina-rai.png" alt="Zaina Rai">
                <div class="attorney-info">
                    <h3>Zaina Rai</h3>
                    <p>She has won 100+ cases till now, one of the most demanding attorneys at your service.</p>
                    <a href="${pageContext.request.contextPath}/book/1" class="book-button">Book now!</a>
                </div>
            </div>
            <div class="attorney-card">
                <img src="${pageContext.request.contextPath}/assets/images/rayan-rajbangsi.png" alt="Rayan Rajbangsi">
                <div class="attorney-info">
                    <h3>Rayan Rajbangsi</h3>
                    <p>With the experience of 5 years, he has been thriving in our company.</p>
                    <a href="${pageContext.request.contextPath}/book/2" class="book-button">Book now!</a>
                </div>
            </div>
            <div class="attorney-card">
                <img src="${pageContext.request.contextPath}/assets/images/baviyan-koirala.png" alt="Baviyan Koirala">
                <div class="attorney-info">
                    <h3>Baviyan Koirala</h3>
                    <p>One of our most demanding attorneys, with a 95% success rate.</p>
                    <a href="${pageContext.request.contextPath}/book/3" class="book-button">Book now!</a>
                </div>
            </div>
        </c:if>
    </div>
</section>

<!-- Testimonials Section -->
<section class="testimonials-section">
    <h2 class="testimonials-heading">What does our client have to say about us?</h2>
    <div class="testimonial-container">
        <c:forEach var="testimonial" items="${testimonials}" varStatus="status">
            <div class="testimonial-card">
                <div class="testimonial-image">
                    <img src="${pageContext.request.contextPath}/images/clients/${testimonial.imageFile}" alt="${testimonial.name}">
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
                    <img src="${pageContext.request.contextPath}/images/clients/client1.jpg" alt="Jhon Basnet">
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
                if (searchInput.value.trim() === '') {
                    e.preventDefault();
                    alert('Please enter a search term');
                }
            });
        }
    });
</script>
</body>
</html>