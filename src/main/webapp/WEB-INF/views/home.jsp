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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        /* Reset and Base Styles */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Arial', sans-serif;
        }

        body {
            line-height: 1.6;
            color: #333;
        }

        a {
            text-decoration: none;
            color: inherit;
        }


        /* Header Styles */
        header {
            background-color: #556673;
            padding: 20px 50px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo-container {
            display: flex;
            align-items: center;
        }

        .logo-img {
            width: 40px;
            height: 40px;
            margin-right: 10px;
        }

        .logo-text {
            font-size: 24px;
            font-weight: bold;
            color: white;
        }

        nav ul {
            display: flex;
            list-style: none;
        }

        nav ul li {
            margin-left: 30px;
        }

        nav ul li a {
            color: white;
            font-weight: 500;
        }

        /* Hero Section */
        .hero {
            display: flex;
            padding: 50px;
            background-color: white;
        }

        .hero-content {
            flex: 1;
            padding-right: 30px;
        }

        .hero-image {
            flex: 1;
            position: relative;
        }

        .hero-image img {
            width: 100%;
            height: auto;
        }

        .experience-badge {
            position: absolute;
            right: 0;
            bottom: 50px;
            background-color: rgba(220, 220, 220, 0.8);
            padding: 20px;
            font-size: 20px;
            font-weight: bold;
        }

        .hero h1 {
            font-size: 42px;
            margin-bottom: 20px;
            line-height: 1.2;
        }

        .hero p {
            font-size: 18px;
            margin-bottom: 30px;
            font-style: italic;
        }

        .cta-button {
            display: inline-block;
            background-color: #556673;
            color: white;
            padding: 15px 30px;
            font-weight: bold;
            margin-right: 20px;
        }

        .phone-number {
            display: inline-flex;
            align-items: center;
            margin-top: 20px;
        }

        .phone-icon {
            margin-right: 10px;
            font-size: 24px;
        }

        /* Search Section */
        .search-section {
            padding: 50px;
            border-top: 1px solid #e0e0e0;
            border-bottom: 1px solid #e0e0e0;
        }

        .search-heading {
            margin-bottom: 20px;
            font-size: 18px;
        }

        .search-form {
            display: flex;
            gap: 20px;
            margin-top: 20px;
        }

        .search-input {
            flex: 1;
            padding: 10px;
            border: 1px solid #ccc;
        }

        .search-dropdown {
            flex: 1;
            padding: 10px;
            border: 1px solid #ccc;
        }

        .search-button {
            padding: 10px 20px;
            background-color: #556673;
            color: white;
            border: none;
            cursor: pointer;
        }

        /* Attorneys Section */
        .attorneys-section {
            padding: 50px;
            display: flex;
        }

        .attorneys-heading {
            flex: 1;
        }

        .attorneys-heading h2 {
            font-size: 24px;
            margin-bottom: 10px;
        }

        .attorneys-description {
            flex: 1;
            padding: 0 20px;
        }

        .attorneys-cta {
            flex: 1;
            display: flex;
            justify-content: flex-end;
            align-items: center;
        }

        .book-appointment-btn {
            padding: 10px 20px;
            background-color: #556673;
            color: white;
            border: none;
            cursor: pointer;
        }

        /* Attorney Profiles */
        .attorney-profiles {
            display: flex;
            justify-content: space-between;
            padding: 50px;
            background-color: #f9f9f9;
        }

        .attorney-card {
            width: 30%;
            position: relative;
        }

        .attorney-card img {
            width: 100%;
            height: auto;
        }

        .attorney-info {
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            background-color: rgba(150, 150, 150, 0.7);
            color: white;
            padding: 15px;
        }

        .attorney-info h3 {
            margin-bottom: 5px;
            font-size: 20px;
        }

        .attorney-info p {
            font-size: 14px;
        }

        /* Testimonials Section */
        .testimonials-section {
            padding: 50px;
        }

        .testimonials-heading {
            font-size: 32px;
            margin-bottom: 30px;
        }

        .testimonial-container {
            display: flex;
            justify-content: center;
        }

        .testimonial-card {
            width: 50%;
            border: 1px solid #e0e0e0;
            padding: 20px;
            display: flex;
        }

        .testimonial-image {
            width: 100px;
            margin-right: 20px;
        }

        .testimonial-image img {
            width: 100%;
            height: auto;
        }

        .testimonial-content h3 {
            margin-bottom: 5px;
        }

        .testimonial-content .position {
            color: #666;
            font-size: 14px;
            margin-bottom: 10px;
        }

        .testimonial-content p {
            font-size: 14px;
            line-height: 1.5;
        }

        /* Footer */
        footer {
            background-color: #556673;
            color: white;
            padding: 50px;
            display: flex;
            justify-content: space-between;
        }

        .footer-column {
            flex: 1;
            margin-right: 20px;
        }

        .footer-column h3 {
            margin-bottom: 20px;
            font-size: 18px;
        }

        .footer-column p {
            margin-bottom: 10px;
            font-size: 14px;
        }

        .footer-column ul {
            list-style: none;
        }

        .footer-column ul li {
            margin-bottom: 10px;
            font-size: 14px;
        }

        .footer-column ul li:before {
            content: "- ";
        }

        .address-icon, .phone-icon, .email-icon {
            margin-right: 10px;
        }

        .profile {
            position: relative;
            display: inline-block;
        }

        .profile img {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            cursor: pointer;
        }

        .profile-menu {
            display: none;
            position: absolute;
            right: 0;
            background-color: white;
            color: black;
            min-width: 150px;
            box-shadow: 0px 8px 16px rgba(0,0,0,0.2);
            border-radius: 8px;
            z-index: 99;
        }

        .profile-menu a, .profile-menu form button {
            padding: 10px;
            text-align: left;
            text-decoration: none;
            display: block;
            background: none;
            border: none;
            color: black;
            width: 100%;
            font-size: 14px;
            cursor: pointer;
        }

        .profile-menu a:hover, .profile-menu form button:hover {
            background-color: #f1f1f1;
        }

        .profile:hover .profile-menu {
            display: block;
        }

        /* Media Queries for Responsiveness */
        @media (max-width: 768px) {
            header {
                flex-direction: column;
                padding: 20px;
            }

            nav ul {
                margin-top: 20px;
                flex-wrap: wrap;
                justify-content: center;
            }

            nav ul li {
                margin: 5px 10px;
            }

            .hero {
                flex-direction: column;
                padding: 30px;
            }

            .hero-content {
                padding-right: 0;
                margin-bottom: 30px;
            }

            .search-form {
                flex-direction: column;
            }

            .attorneys-section {
                flex-direction: column;
            }

            .attorneys-heading, .attorneys-description, .attorneys-cta {
                margin-bottom: 20px;
            }

            .attorney-profiles {
                flex-direction: column;
            }

            .attorney-card {
                width: 100%;
                margin-bottom: 30px;
            }

            .testimonial-card {
                width: 100%;
                flex-direction: column;
            }

            .testimonial-image {
                margin-bottom: 20px;
            }

            footer {
                flex-direction: column;
            }

            .footer-column {
                margin-bottom: 30px;
            }
        }
    </style>
</head>
<body>
<!-- Header Section -->
<header>
    <div class="logo-container">
        <img src="${pageContext.request.contextPath}/assets/images/logo.png" alt="LawLink Logo" class="logo-img" onerror="this.src='${pageContext.request.contextPath}/images/placeholder.svg'">
        <div class="logo-text">LawLink</div>
    </div>
    <nav>
        <ul>
            <li><a href="${pageContext.request.contextPath}/home">Home</a></li>
            <li><a href="${pageContext.request.contextPath}/appointment">Appointment</a></li>
            <li><a href="${pageContext.request.contextPath}/lawyers">Lawyers</a></li>
            <li><a href="${pageContext.request.contextPath}/about-us">About Us</a></li>
            <li><a href="${pageContext.request.contextPath}/contact-us">Contact Us</a></li>
            <% if (loggedInUser == null) { %>
            <li><a href="${pageContext.request.contextPath}/log-in">Log In</a></li>
            <% } else { %>
            <li>
                <div class="profile">
                    <img src="${pageContext.request.contextPath}/assets/images/<%= loggedInUser.getProfileImage() != null ? loggedInUser.getProfileImage() : "profile_pic.png" %>" alt="Profile">
                    <div class="profile-menu">
                        <a href="${pageContext.request.contextPath}/client/my-appointments">My Appointments</a>
                        <a href="${pageContext.request.contextPath}/client/my-profile">My Profile</a>
                        <form action="${pageContext.request.contextPath}/logout" method="post" style="margin:0;">
                            <button type="submit">Logout</button>
                        </form>
                    </div>
                </div>
            </li>
            <% } %>
        </ul>
    </nav>
</header>

<!-- Hero Section -->
<section class="hero">
    <div class="hero-content">
        <h1>Innocent until proven guilty.</h1>
        <p>Organize your task through our LawLink.<br>we provide the best services.</p>
        <a href="${pageContext.request.contextPath}/appointment" class="cta-button">Book your appointment</a>
        <div class="phone-number">
            <span class="phone-icon"><i class="fas fa-phone"></i></span>
            <span>or call us at<br>${contactPhone}</span>
        </div>
    </div>
    <div class="hero-image">
        <img src="${pageContext.request.contextPath}/assets/images/jeniffer.png" alt="Professional Lawyer">
        <div class="experience-badge">
            10+ Year<br>of<br>experience
        </div>
    </div>
</section>

<!-- Search Section -->
<section class="search-section">
    <div class="search-heading">
        <p>Search by the name of attorney<br>and practice areas.</p>
    </div>
    <form action="${pageContext.request.contextPath}/search" method="get" class="search-form">
        <input type="text" name="query" placeholder="Search" class="search-input">
        <select name="practiceArea" class="search-dropdown">
            <option value="">Practice area</option>
            <option value="">Criminal Law</option>
            <option value="">Labour Law</option>
            <option value="">International Law</option>
            <option value="">Property Law</option>
            <option value="">Corporate Law</option>
            <option value="">Family Law</option>
        </select>
        <button type="submit" class="search-button">Search</button>
    </form>
</section>

<!-- Attorneys Section -->
<section class="attorneys-section">
    <div class="attorneys-heading">
        <h2>MEET OUR MOST<br>TALANTED ATTORNEYS</h2>
    </div>
    <div class="attorneys-description">
        <p>Their work involves legal research, courtroom representation, and the protection of both civil and criminal rights. With deep knowledge of the law, they stand as protectors of individual and public rights.</p>
    </div>
    <div class="attorneys-cta">
        <a href="${pageContext.request.contextPath}/appointment" class="book-appointment-btn">Book appointment</a>
    </div>
</section>

<!-- Attorney Profiles -->
<section class="attorney-profiles">
<%--    <c:forEach var="attorney" items="${attorneys}" varStatus="status">--%>
<%--        <div class="attorney-card">--%>
<%--            <img src="${pageContext.request.contextPath}/images/attorneys/${attorney.imageFile}" alt="${attorney.name}">--%>
<%--            <div class="attorney-info">--%>
<%--                <h3>${attorney.name}</h3>--%>
<%--                <p>${attorney.description}</p>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </c:forEach>--%>

    <%-- Fallback if no attorneys are loaded from the database --%>
    <c:if test="${empty attorneys}">
        <div class="attorney-card">
            <img src="${pageContext.request.contextPath}/assets/images/zaina-rai.png" alt="Attorney Profile">
            <div class="attorney-info">
                <h3>Zaina Rai</h3>
                <p>She has won 100+ case till now one of the most demanding attorney at your service.</p>
            </div>
        </div>
        <div class="attorney-card">
            <img src="${pageContext.request.contextPath}/assets/images/rayan-rajbangsi.png" alt="Attorney Profile">
            <div class="attorney-info">
                <h3>Rayan Raibangsi</h3>
                <p>With the experience of 5 years he has been thriving in our company.</p>
            </div>
        </div>
        <div class="attorney-card">
            <img src="${pageContext.request.contextPath}/assets/images/baviyan-koirala.png" alt="Attorney Profile">
            <div class="attorney-info">
                <h3>Baviyan Koir</h3>
                <p>One of our most demanding attorney, with the 95% of success.</p>
            </div>
        </div>
    </c:if>
</section>

<!-- Testimonials Section -->
<section class="testimonials-section">
    <h2 class="testimonials-heading">What does our client has to say about us?</h2>
    <div class="testimonial-container">
<%--        <c:forEach var="testimonial" items="${testimonials}" varStatus="status">--%>
<%--            <div class="testimonial-card">--%>
<%--                <div class="testimonial-image">--%>
<%--                    <img src="${pageContext.request.contextPath}/images/clients/${testimonial.imageFile}" alt="${testimonial.name}">--%>
<%--                </div>--%>
<%--                <div class="testimonial-content">--%>
<%--                    <h3>${testimonial.name}</h3>--%>
<%--                    <p class="position">${testimonial.position}</p>--%>
<%--                    <p>${testimonial.content}</p>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </c:forEach>--%>

        <%-- Fallback if no testimonials are loaded from the database --%>
        <c:if test="${empty testimonials}">
            <div class="testimonial-card">
                <div class="testimonial-image">
                    <img src="${pageContext.request.contextPath}/images/clients/client1.jpg" alt="Client">
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
<footer>
    <div class="footer-content">
        <div class="footer-section">
            <h3>LAWLINK ASSOCIATION</h3>
            <p>LAWLINK register number: 805017120</p>
            <p>Sunsari itahari-12 Sagarmatha-chowk</p>
            <p>Central mall, 1st floor, Dharan line, Nepal</p>
            <p>Contact Information : +9802778377</p>
            <p>lawlinkprivatelimited@lawlink.com</p>
        </div>
        <div class="footer-section">
            <h3>OFFICE HOUR</h3>
            <p>10 AM - 5 PM</p>
        </div>
        <div class="footer-section">
            <h3>PRACTICE AREA</h3>
            <ul>
                <li>Banking & Financial</li>
                <li>Co-operate & Commercial</li>
                <li>Litigation & Arbitration</li>
                <li>Mergers & Acquisitions</li>
            </ul>
        </div>
    </div>
</footer>

<%-- Optional: Add JavaScript at the end of the body --%>
<script>
    // You can add your JavaScript here
    document.addEventListener('DOMContentLoaded', function() {
        console.log('Page loaded successfully');

        // Example: Form validation
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