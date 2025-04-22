<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us - Law Link</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #556673;
            --secondary-color: #3d4a56;
            --text-color: #333;
            --light-text: #fff;
            --border-color: #ddd;
        }

        body {
            font-family: 'Arial', sans-serif;
            color: var(--text-color);
            line-height: 1.6;
        }

        /* Navbar Styles */
        .navbar {
            background-color: var(--primary-color);
        }

        /* Main Content Styles */
        .main-content {
            padding: 50px 0;
        }

        .page-title {
            text-align: center;
            margin-bottom: 50px;
            color: var(--text-color);
            font-weight: 600;
        }

        .contact-info {
            display: flex;
            justify-content: space-between;
            margin-bottom: 80px;
        }

        .contact-item {
            flex: 1;
            text-align: center;
            padding: 0 20px;
        }

        .contact-icon {
            font-size: 24px;
            margin-bottom: 15px;
            color: var(--primary-color);
        }

        .contact-title {
            font-weight: 600;
            margin-bottom: 10px;
        }

        .contact-text {
            color: #555;
        }

        /* Footer Styles */
        footer {
            background-color: var(--primary-color);
            color: var(--light-text);
            padding: 30px 0 15px;
        }

        .footer-content {
            display: flex;
            justify-content: space-between;
            flex-wrap: wrap;
        }

        .footer-section {
            flex: 1;
            min-width: 200px;
            margin-bottom: 20px;
            padding: 0 15px;
        }

        .footer-title {
            font-size: 16px;
            font-weight: 600;
            margin-bottom: 15px;
            color: #ddd;
            text-transform: uppercase;
        }

        .footer-text {
            color: #bbb;
            margin-bottom: 8px;
            font-size: 14px;
        }

        .footer-list {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .footer-list li {
            margin-bottom: 8px;
        }

        .copyright {
            text-align: center;
            padding-top: 15px;
            margin-top: 15px;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
            color: #bbb;
            font-size: 12px;
        }
    </style>
</head>
<body>
<!-- NAVBAR -->
<nav class="navbar navbar-expand-lg px-5 py-3">
    <div class="container-fluid">
        <a class="navbar-brand d-flex align-items-center text-white" href="#">
            <img src="${pageContext.request.contextPath}/assets/images/logo.png" alt="LawLink Logo" height="30" class="me-2"/>
            <span class="fw-bold">Law Link</span>
        </a>
        <div class="ms-auto">
            <ul class="navbar-nav d-flex flex-row gap-4">
                <li class="nav-item"><a class="nav-link text-white" href="${pageContext.request.contextPath}/home">Home</a></li>
                <li class="nav-item"><a class="nav-link text-white" href="${pageContext.request.contextPath}/appointment">Appointments</a></li>
                <li class="nav-item"><a class="nav-link text-white" href="${pageContext.request.contextPath}/lawyers">Lawyers</a></li>
                <li class="nav-item"><a class="nav-link text-white" href="${pageContext.request.contextPath}/about-us">About Us</a></li>
                <li class="nav-item"><a class="nav-link text-white" href="${pageContext.request.contextPath}/contact-us">Contact Us</a></li>
                <li class="nav-item"><a href="${pageContext.request.contextPath}/log-in" class="login-btn">Log In</a></li>
            </ul>
        </div>
    </div>
</nav>

<!-- Main Content -->
<div class="main-content">
    <div class="container">
        <h1 class="page-title">Contact Us</h1>

        <div class="contact-info">
            <div class="contact-item">
                <div class="contact-icon">
                    <i class="fas fa-map-marker-alt"></i>
                </div>
                <h3 class="contact-title">Office location</h3>
                <p class="contact-text">
                    Itahari-12, Sunsari, Sagarmatha chowk,<br>
                    Central mall, 1st floor, Dharan line, Nepal
                </p>
            </div>

            <div class="contact-item">
                <div class="contact-icon">
                    <i class="fas fa-phone-alt"></i>
                </div>
                <h3 class="contact-title">Phone Number</h3>
                <p class="contact-text">
                    +9802778377
                </p>
            </div>

            <div class="contact-item">
                <div class="contact-icon">
                    <i class="fas fa-envelope"></i>
                </div>
                <h3 class="contact-title">Email</h3>
                <p class="contact-text">
                    lawlinkprivatelimited@lawlink.com
                </p>
            </div>
        </div>
    </div>
</div>

<!-- Footer -->
<footer>
    <div class="container">
        <div class="footer-content">
            <div class="footer-section">
                <h3 class="footer-title">Law Firm Information</h3>
                <p class="footer-text"><i class="fas fa-id-card me-2"></i> Law Firm Register Number: 40202/077</p>
                <p class="footer-text"><i class="fas fa-map-marker-alt me-2"></i> Central Mall-12, Sagarmatha Chowk</p>
                <p class="footer-text"><i class="fas fa-globe me-2"></i> Dharan-Itahari Road, Itahari, Nepal</p>
                <p class="footer-text"><i class="fas fa-envelope me-2"></i> lawlinkprivatelimited@lawlink.com</p>
            </div>

            <div class="footer-section">
                <h3 class="footer-title">Office Hours</h3>
                <p class="footer-text">10 AM - 5 PM</p>
            </div>

            <div class="footer-section">
                <h3 class="footer-title">Practice Area</h3>
                <ul class="footer-list">
                    <li class="footer-text">Banking & Financial</li>
                    <li class="footer-text">Corporate & Commercial</li>
                    <li class="footer-text">Litigation & Arbitration</li>
                    <li class="footer-text">Mergers & Acquisitions</li>
                </ul>
            </div>
        </div>

        <div class="copyright">
            <p>Copyright © 2023. All Rights Reserved. Nepal Firm - Nepal. Our lawyers are licensed by the Bar Council of Nepal and are members of the Nepal Bar Association. This site is for information purpose only and should not be construed as advertisement or solicitation.</p>
            <p>Developed By: secondjaydev.com</p>
        </div>
    </div>
</footer>

<!-- Bootstrap JS Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>