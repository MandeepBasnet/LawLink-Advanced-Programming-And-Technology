<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Our Lawyers - LawLink</title>
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
            background-color: #f5f5f5;
        }

        a {
            text-decoration: none;
            color: inherit;
        }

        /* Header Styles */
        header {
            background-color: #556673;
            padding: 15px 50px;
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

        /* Lawyers Grid */
        .lawyers-container {
            max-width: 1200px;
            margin: 30px auto;
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
            padding: 0 15px;
        }

        .lawyer-card {
            display: flex;
            background-color: #fff;
            border-radius: 5px;
            overflow: hidden;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }

        .lawyer-image {
            width: 120px;
            height: 150px;
        }

        .lawyer-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .lawyer-info {
            padding: 15px;
            flex-grow: 1;
            display: flex;
            flex-direction: column;
        }

        .lawyer-name {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 5px;
        }

        .lawyer-title {
            font-size: 14px;
            color: #666;
            margin-bottom: 10px;
        }

        .lawyer-location, .lawyer-phone {
            font-size: 14px;
            display: flex;
            align-items: center;
            margin-bottom: 5px;
        }

        .lawyer-location i, .lawyer-phone i {
            margin-right: 8px;
            color: #556673;
        }

        .book-button {
            margin-top: auto;
            background-color: #556673;
            color: white;
            padding: 8px 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            text-align: center;
            transition: background-color 0.3s;
        }

        .book-button:hover {
            background-color: #3a4651;
        }

        /* Responsive */
        @media (max-width: 992px) {
            .lawyers-container {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 768px) {
            header {
                flex-direction: column;
                padding: 15px;
            }

            nav ul {
                margin-top: 15px;
                flex-wrap: wrap;
                justify-content: center;
            }

            nav ul li {
                margin: 5px 10px;
            }

            .lawyers-container {
                grid-template-columns: 1fr;
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
            <li><a href="${pageContext.request.contextPath}/log-in">Log In</a></li>
        </ul>
    </nav>
</header>

<!-- Lawyers Grid -->
<div class="lawyers-container">
<%--    &lt;%&ndash; Dynamic lawyers from database &ndash;%&gt;--%>
<%--    <c:forEach var="lawyer" items="${lawyers}">--%>
<%--        <div class="lawyer-card">--%>
<%--            <div class="lawyer-image">--%>
<%--                <img src="${pageContext.request.contextPath}/images/lawyers/${lawyer.imageFile}"--%>
<%--                     alt="${lawyer.name}"--%>
<%--                     onerror="this.src='${pageContext.request.contextPath}/images/placeholder.svg?height=150&width=120'">--%>
<%--            </div>--%>
<%--            <div class="lawyer-info">--%>
<%--                <h2 class="lawyer-name">${lawyer.name}</h2>--%>
<%--                <p class="lawyer-title">${lawyer.title}</p>--%>
<%--                <p class="lawyer-location"><i class="fas fa-map-marker-alt"></i> ${lawyer.location}</p>--%>
<%--                <p class="lawyer-phone"><i class="fas fa-phone"></i> ${lawyer.phoneLabel}: ${lawyer.phone}</p>--%>
<%--                <a href="${pageContext.request.contextPath}/client/book-appointment?id=${lawyer.id}" class="book-button">--%>
<%--                    Book ${lawyer.gender == 'female' ? 'her' : 'him'} now!--%>
<%--                </a>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </c:forEach>--%>

    <%-- Fallback if no lawyers are loaded from the database --%>
    <c:if test="${empty lawyers}">
        <!-- Lawyer 1 -->
        <div class="lawyer-card">
            <div class="lawyer-image">
                <img src="${pageContext.request.contextPath}/assets/images/zaina-rai.png"
                     alt="Zaina Raj"
                     onerror="this.src='${pageContext.request.contextPath}/assets/images/profile_pic.png'">
            </div>
            <div class="lawyer-info">
                <h2 class="lawyer-name">Zaina Raj</h2>
                <p class="lawyer-title">Principal senior advisor</p>
                <p class="lawyer-location"><i class="fas fa-map-marker-alt"></i> Itahari</p>
                <p class="lawyer-phone"><i class="fas fa-phone"></i> Phone NO: +977-9086706541</p>
                <a href="${pageContext.request.contextPath}/client/book-appointment" class="book-button">Book her now!</a>
            </div>
        </div>

        <!-- Lawyer 2 -->
        <div class="lawyer-card">
            <div class="lawyer-image">
                <img src="${pageContext.request.contextPath}/assets/images/rayan-rajbangsi.png"
                     alt="Rayan Rajbangsi"
                     onerror="this.src='${pageContext.request.contextPath}/assets/images/profile_pic.png'">
            </div>
            <div class="lawyer-info">
                <h2 class="lawyer-name">Rayan Rajbangsi</h2>
                <p class="lawyer-title">Manager partner</p>
                <p class="lawyer-location"><i class="fas fa-map-marker-alt"></i> Itahari</p>
                <p class="lawyer-phone"><i class="fas fa-phone"></i> Phone NO: +977-9705523049</p>
                <a href="${pageContext.request.contextPath}/client/book-appointment" class="book-button">Book him now!</a>
            </div>
        </div>

        <!-- Lawyer 3 -->
        <div class="lawyer-card">
            <div class="lawyer-image">
                <img src="${pageContext.request.contextPath}/assets/images/manish-khanal.png"
                     alt="MANISH KHANAL"
                     onerror="this.src='${pageContext.request.contextPath}/assets/images/profile_pic.png'">
            </div>
            <div class="lawyer-info">
                <h2 class="lawyer-name">MANISH KHANAL</h2>
                <p class="lawyer-title">LEGAL ASSOCIATE</p>
                <p class="lawyer-location"><i class="fas fa-map-marker-alt"></i> Kathmandu</p>
                <p class="lawyer-phone"><i class="fas fa-phone"></i> Contact NO: +977-9812395010</p>
                <a href="${pageContext.request.contextPath}/client/book-appointment" class="book-button">Book him now!</a>
            </div>
        </div>

        <!-- Lawyer 4 -->
        <div class="lawyer-card">
            <div class="lawyer-image">
                <img src="${pageContext.request.contextPath}/assets/images/baviyan-koirala.png"
                     alt="Baviyan Koirala"
                     onerror="this.src='${pageContext.request.contextPath}/assets/images/profile_pic.png'">
            </div>
            <div class="lawyer-info">
                <h2 class="lawyer-name">Baviyan Koirala</h2>
                <p class="lawyer-title">Founding partner</p>
                <p class="lawyer-location"><i class="fas fa-map-marker-alt"></i> Itahari</p>
                <p class="lawyer-phone"><i class="fas fa-phone"></i> Phone NO: +977-9867063791</p>
                <a href="${pageContext.request.contextPath}/client/book-appointment" class="book-button">Book him now!</a>
            </div>
        </div>

        <!-- Lawyer 5 -->
        <div class="lawyer-card">
            <div class="lawyer-image">
                <img src="${pageContext.request.contextPath}/assets/images/lalita-puri.png"
                     alt="Lalita Puri"
                     onerror="this.src='${pageContext.request.contextPath}/assets/images/profile_pic.png'">
            </div>
            <div class="lawyer-info">
                <h2 class="lawyer-name">Lalita Puri</h2>
                <p class="lawyer-title">Principal senior advisor</p>
                <p class="lawyer-location"><i class="fas fa-map-marker-alt"></i> Biratnagar</p>
                <p class="lawyer-phone"><i class="fas fa-phone"></i> Contact NO: +977-9706146926</p>
                <a href="${pageContext.request.contextPath}/client/book-appointment" class="book-button">Book her now!</a>
            </div>
        </div>

        <!-- Lawyer 6 -->
        <div class="lawyer-card">
            <div class="lawyer-image">
                <img src="${pageContext.request.contextPath}/assets/images/ashutosh-srivastava.png"
                     alt="Ashutosh Srivastava"
                     onerror="this.src='${pageContext.request.contextPath}/assets/images/profile_pic.png'">
            </div>
            <div class="lawyer-info">
                <h2 class="lawyer-name">Ashutosh Srivastava</h2>
                <p class="lawyer-title">ADVOCATE & LEGAL ADVISOR</p>
                <p class="lawyer-location"><i class="fas fa-map-marker-alt"></i> Morang</p>
                <p class="lawyer-phone"><i class="fas fa-phone"></i> Contact No: +977-9823543129</p>
                <a href="${pageContext.request.contextPath}/client/book-appointment" class="book-button">Book him now!</a>
            </div>
        </div>

        <!-- Lawyer 7 -->
        <div class="lawyer-card">
            <div class="lawyer-image">
                <img src="${pageContext.request.contextPath}/images/lawyers/yusha.jpg"
                     alt="Yusha Shrestha"
                     onerror="this.src='${pageContext.request.contextPath}/assets/images/profile_pic.png'">
            </div>
            <div class="lawyer-info">
                <h2 class="lawyer-name">Yusha Shrestha</h2>
                <p class="lawyer-title">Junior associate</p>
                <p class="lawyer-location"><i class="fas fa-map-marker-alt"></i> Tarahara</p>
                <p class="lawyer-phone"><i class="fas fa-phone"></i> Contact NO: +977-9703304911</p>
                <a href="${pageContext.request.contextPath}/client/book-appointment" class="book-button">Book her now!</a>
            </div>
        </div>

        <!-- Lawyer 8 -->
        <div class="lawyer-card">
            <div class="lawyer-image">
                <img src="${pageContext.request.contextPath}/assets/images/anish-basnet.png"
                     alt="Anish Basnet"
                     onerror="this.src='${pageContext.request.contextPath}/assets/images/profile_pic.png'">
            </div>
            <div class="lawyer-info">
                <h2 class="lawyer-name">Anish Basnet</h2>
                <p class="lawyer-title">Legal Associate</p>
                <p class="lawyer-location"><i class="fas fa-map-marker-alt"></i> Jhapa</p>
                <p class="lawyer-phone"><i class="fas fa-phone"></i> Contact NO: +977-9708203041</p>
                <a href="${pageContext.request.contextPath}/client/book-appointment" class="book-button">Book him now!</a>
            </div>
        </div>

        <!-- Lawyer 9 -->
        <div class="lawyer-card">
            <div class="lawyer-image">
                <img src="${pageContext.request.contextPath}/assets/images/susasa-acharaya.png"
                     alt="SUSASA ACHARYA"
                     onerror="this.src='${pageContext.request.contextPath}/assets/images/profile_pic.png'">
            </div>
            <div class="lawyer-info">
                <h2 class="lawyer-name">SUSASA ACHARYA</h2>
                <p class="lawyer-title">LEGAL ASSOCIATE</p>
                <p class="lawyer-location"><i class="fas fa-map-marker-alt"></i> Biratnagar</p>
                <p class="lawyer-phone"><i class="fas fa-phone"></i> Contact NO: +977-9703129941</p>
                <a href="${pageContext.request.contextPath}/client/book-appointment" class="book-button">Book her now!</a>
            </div>
        </div>
    </c:if>
</div>
</body>
</html>