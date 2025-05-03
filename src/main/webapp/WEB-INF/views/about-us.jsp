<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us - LawLink</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
</head>
<body>
<!-- Header -->
<jsp:include page="includes/header.jsp" />

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
                <h2>What does our client have to say about us?</h2>
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
<jsp:include page="includes/footer.jsp" />
</body>
</html>