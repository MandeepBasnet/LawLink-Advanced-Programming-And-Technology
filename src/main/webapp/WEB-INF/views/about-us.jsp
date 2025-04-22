<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us - LawLink</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Inter', sans-serif;
        }

        body {
            background-color: #f5f5f5;
            color: #333;
            line-height: 1.6;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }

        /* Header styles */
        header {
            background-color: #556673;
            color: white;
            padding: 15px 0;
        }

        .header-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo-container {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .logo {
            width: 40px;
            height: 40px;
        }

        .logo-text {
            font-size: 1.5rem;
            font-weight: 600;
        }

        nav ul {
            display: flex;
            list-style: none;
            gap: 30px;
        }

        nav a {
            color: white;
            text-decoration: none;
            font-weight: 500;
            transition: opacity 0.3s;
        }

        nav a:hover {
            opacity: 0.8;
        }

        /* Hero section */
        .hero {
            background-color: #d1d5db;
            padding: 60px 0;
            text-align: center;
        }

        .hero h1 {
            color: #1e3a8a;
            font-size: 2.5rem;
            margin-bottom: 20px;
        }

        .hero p {
            font-size: 1.2rem;
            max-width: 800px;
            margin: 0 auto;
        }

        /* What we do section */
        .what-we-do {
            padding: 60px 0;
            text-align: center;
        }

        .what-we-do h2 {
            color: #1e3a8a;
            font-size: 2rem;
            margin-bottom: 20px;
        }

        .what-we-do p {
            font-size: 1.1rem;
            max-width: 900px;
            margin: 0 auto 40px;
        }

        .services {
            display: flex;
            justify-content: center;
            gap: 40px;
            flex-wrap: wrap;
            margin-top: 40px;
        }

        .service {
            width: 200px;
            text-align: center;
        }

        .service-icon {
            width: 60px;
            height: 60px;
            margin: 0 auto 15px;
        }

        .service h3 {
            font-size: 1rem;
            font-weight: 600;
        }

        /* The firm section */
        .the-firm {
            padding: 60px 0;
            text-align: center;
            background-color: #f9fafb;
        }

        .the-firm h2 {
            color: #1e3a8a;
            font-size: 2rem;
            margin-bottom: 20px;
        }

        .the-firm p {
            font-size: 1.1rem;
            max-width: 900px;
            margin: 0 auto;
        }

        /* Awards section */
        .awards {
            padding: 60px 0;
            text-align: center;
        }

        .awards h2 {
            color: #1e3a8a;
            font-size: 2rem;
            margin-bottom: 40px;
        }

        .award-logos {
            display: flex;
            justify-content: center;
            gap: 30px;
            flex-wrap: wrap;
            margin-bottom: 60px;
        }

        .award-logo {
            max-width: 180px;
            height: auto;
        }

        /* Testimonials section */
        .testimonials {
            display: flex;
            justify-content: space-between;
            gap: 40px;
            margin-bottom: 60px;
        }

        .testimonial-heading {
            flex: 1;
            display: flex;
            align-items: center;
        }

        .testimonial-heading h2 {
            color: #1e3a8a;
            font-size: 2rem;
            text-align: left;
        }

        .testimonial {
            flex: 1;
            background-color: #fff;
            border: 1px solid #e5e7eb;
            padding: 30px;
            border-radius: 8px;
            display: flex;
            gap: 20px;
        }

        .testimonial-image {
            width: 80px;
            height: 80px;
        }

        .testimonial-content {
            flex: 1;
        }

        .testimonial-name {
            font-weight: 600;
            margin-bottom: 5px;
        }

        .testimonial-position {
            color: #556673;
            font-size: 0.9rem;
            margin-bottom: 10px;
        }

        .testimonial-text {
            font-size: 0.95rem;
        }

        /* Footer */
        footer {
            background-color: #556673;
            color: white;
            padding: 40px 0;
        }

        .footer-content {
            display: flex;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 30px;
        }

        .footer-column {
            flex: 1;
            min-width: 200px;
        }

        .footer-column h3 {
            font-size: 1.1rem;
            margin-bottom: 20px;
            color: #f3f4f6;
        }

        .footer-column p, .footer-column a {
            color: #e5e7eb;
            margin-bottom: 10px;
            display: block;
            text-decoration: none;
        }

        .footer-column a:hover {
            text-decoration: underline;
        }

        .footer-icon {
            display: inline-block;
            margin-right: 10px;
            width: 16px;
            height: 16px;
            vertical-align: middle;
        }

        /* Responsive styles */
        @media (max-width: 768px) {
            .header-content {
                flex-direction: column;
                gap: 20px;
            }

            nav ul {
                gap: 15px;
            }

            .hero h1 {
                font-size: 2rem;
            }

            .testimonials {
                flex-direction: column;
            }

            .footer-content {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
<!-- Header -->
<header>
    <div class="container header-content">
        <div class="logo-container">
            <img src="${pageContext.request.contextPath}/assets/images/logo.png" alt="LawLink Logo" class="logo" onerror="this.src='${pageContext.request.contextPath}/assets/images/placeholder.svg'">
            <div class="logo-text">LawLink</div>
        </div>
        <nav>
            <ul>
                <li><a  href="${pageContext.request.contextPath}/home">Home</a></li>
                <li><a  href="${pageContext.request.contextPath}/appointment">Appointments</a></li>
                <li><a  href="${pageContext.request.contextPath}/lawyers">Lawyers</a></li>
                <li><a  href="${pageContext.request.contextPath}/about-us">About Us</a></li>
                <li><a  href="${pageContext.request.contextPath}/contact-us">Contact Us</a></li>
                <li><a  href="${pageContext.request.contextPath}/log-in" class="login-btn">Log In</a></li>
            </ul>
        </nav>
    </div>
</header>

<!-- Hero Section -->
<section class="hero">
    <div class="container">
        <h1>NEPAL'S LEADING LAW FIRM</h1>
        <p>We deliver the highest international standards with an extensive local expertise.</p>
    </div>
</section>

<!-- What We Do Section -->
<section class="what-we-do">
    <div class="container">
        <h2>WHAT WE DO</h2>
        <p>We combine our specialist legal knowledge, deep commercial understanding, and extensive local expertise to deliver the best results for our clients.</p>

        <div class="services">
            <c:forEach var="service" items="${services}">
                <div class="service">
                    <img src="${pageContext.request.contextPath}/assets/images/icons/${service.icon}" alt="${service.name}" class="service-icon" onerror="this.src='${pageContext.request.contextPath}/assets/images/placeholder.svg'">
                    <h3>${service.name}</h3>
                </div>
            </c:forEach>

            <!-- Fallback if services attribute is not set -->
            <c:if test="${empty services}">
                <div class="service">
                    <svg class="service-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <rect x="2" y="5" width="20" height="14" rx="2" />
                        <line x1="2" y1="10" x2="22" y2="10" />
                    </svg>
                    <h3>Banking & Finance</h3>
                </div>

                <div class="service">
                    <svg class="service-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <rect x="2" y="7" width="20" height="14" rx="2" ry="2" />
                        <path d="M16 21V5a2 2 0 0 0-2-2h-4a2 2 0 0 0-2 2v16" />
                    </svg>
                    <h3>Corporate & Commercial</h3>
                </div>

                <div class="service">
                    <svg class="service-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <line x1="12" y1="5" x2="12" y2="19" />
                        <line x1="5" y1="12" x2="19" y2="12" />
                        <line x1="5" y1="5" x2="19" y2="19" />
                        <line x1="19" y1="5" x2="5" y2="19" />
                    </svg>
                    <h3>Mergers & Acquisition</h3>
                </div>

                <div class="service">
                    <svg class="service-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M3 3h18v18H3zM8 12h8M12 8v8" />
                    </svg>
                    <h3>Litigation & Arbitration</h3>
                </div>
            </c:if>
        </div>
    </div>
</section>

<!-- The Firm Section -->
<section class="the-firm">
    <div class="container">
        <h2>THE FIRM</h2>
        <p>We are a group of lawyers who strive for excellence in providing legal services. We aim to offer the highest international standards and extensive local expertise. We have advised our clients in many notable transactions and disputes for over 15 years.</p>
    </div>
</section>

<!-- Awards Section -->
<section class="awards">
    <div class="container">
        <h2>Awards & Recognition</h2>

        <div class="award-logos">
            <c:forEach var="award" items="${awards}">
                <img src="${pageContext.request.contextPath}/assets/images/awards/${award.image}" alt="${award.name}" class="award-logo">
            </c:forEach>

            <!-- Fallback if awards attribute is not set -->
            <c:if test="${empty awards}">
                <img src="${pageContext.request.contextPath}/assets/images/2024-legal-award.png" alt="Legal Awards 2024" class="award-logo" onerror="this.src='${pageContext.request.contextPath}/assets/images/placeholder.svg'">
                <img src="${pageContext.request.contextPath}/assets/images/LawFirmLeaders2025.png" alt="Law Firm Leaders 2025" class="award-logo" onerror="this.src='${pageContext.request.contextPath}/assets/images/placeholder.svg'">
                <img src="${pageContext.request.contextPath}/assets/images/top-lawyer-2015.jpeg" alt="Top Lawyers 2015" class="award-logo" onerror="this.src='${pageContext.request.contextPath}/assets/images/placeholder.svg'">
                <img src="${pageContext.request.contextPath}/assets/images/leading-firm-2022.png" alt="Legal 500 Asia Pacific 2022" class="award-logo" onerror="this.src='${pageContext.request.contextPath}/assets/images/placeholder.svg'">
            </c:if>
        </div>

        <div class="testimonials">
            <div class="testimonial-heading">
                <h2>What does our client has to say about us?</h2>
            </div>

            <div class="testimonial">
                <c:choose>
                    <c:when test="${not empty testimonial}">
                        <img src="${pageContext.request.contextPath}/assets/images/testimonials/${testimonial.image}" alt="${testimonial.name}" class="testimonial-image" onerror="this.src='${pageContext.request.contextPath}/assets/images/placeholder.svg'">
                        <div class="testimonial-content">
                            <div class="testimonial-name">${testimonial.name}</div>
                            <div class="testimonial-position">${testimonial.position}</div>
                            <div class="testimonial-text">${testimonial.text}</div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <img src="${pageContext.request.contextPath}/assets/images/john.png" alt="John Basnet" class="testimonial-image" onerror="this.src='${pageContext.request.contextPath}/assets/images/placeholder.svg'">
                        <div class="testimonial-content">
                            <div class="testimonial-name">John Basnet</div>
                            <div class="testimonial-position">Property Developer</div>
                            <div class="testimonial-text">
                                I was going through a complex property dispute, unsure of if I ever had justice. But from the moment I consulted with Zaina, I knew I was in capable hands. They deeply understood my case, provided clear guidance, and ultimately achieved a favorable outcome. I'm incredibly grateful for their support and highly recommend their services to anyone seeking legal guidance.
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</section>

<!-- Footer -->
<footer>
    <div class="container footer-content">
        <div class="footer-column">
            <h3>LAWLINK ASSOCIATION</h3>
            <p>LAWLINK register number: 006901901</p>
            <p>
                <svg class="footer-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z" />
                    <circle cx="12" cy="10" r="3" />
                </svg>
                Gyaneshwor, Kathmandu, Nepal
            </p>
            <p>Central road, In front dharan bus, Nepal</p>
            <p>
                <svg class="footer-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z" />
                </svg>
                Contact Information: +9801278937
            </p>
            <p>
                <svg class="footer-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z" />
                    <polyline points="22,6 12,13 2,6" />
                </svg>
                lawlinkbusiness@lawlink.com
            </p>
        </div>

        <div class="footer-column">
            <h3>OFFICE HOUR</h3>
            <p>10 AM - 5 PM</p>
        </div>

        <div class="footer-column">
            <h3>PRACTICE AREA</h3>
            <c:forEach var="area" items="${practiceAreas}">
                <a href="${pageContext.request.contextPath}/practice-areas/${area.slug}">${area.name}</a>
            </c:forEach>

            <!-- Fallback if practiceAreas attribute is not set -->
            <c:if test="${empty practiceAreas}">
                <a>Banking & Financial</a>
                <a>Corporate & Commercial</a>
                <a>Litigation & Arbitration</a>
                <a>Mergers & Acquisitions</a>
            </c:if>
        </div>
    </div>
</footer>
</body>
</html>