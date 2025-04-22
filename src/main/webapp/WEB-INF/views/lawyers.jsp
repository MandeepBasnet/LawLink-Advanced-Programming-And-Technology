<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lawyers</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }

        body {
            background-color: #f5f5f5;
        }

        header {
            background-color: #4d5b69;
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
            text-decoration: none;
            font-weight: 500;
        }

        .team-container {
            max-width: 1200px;
            margin: 30px auto;
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
            padding: 0 15px;
        }

        .team-member {
            background-color: #ccc;
            position: relative;
            height: 400px;
        }

        .team-member img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .member-info {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            padding: 20px;
            color: white;
        }

        .member-name {
            font-size: 24px;
            margin-bottom: 5px;
        }

        .member-title {
            font-size: 14px;
            text-transform: uppercase;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .member-contact {
            margin-top: 10px;
            font-size: 14px;
        }

        .member-contact p {
            margin-bottom: 5px;
        }

        .member-bio {
            margin-top: auto;
            font-size: 14px;
            line-height: 1.4;
        }

        @media (max-width: 992px) {
            .team-container {
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

            .team-container {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
<!-- Header Section -->
<header>
    <div class="logo-container">
        <img src="${pageContext.request.contextPath}/assets/images/logo.png" alt="LawLink Logo" class="logo-img">
        <div class="logo-text">LawLink</div>
    </div>
    <nav>
        <ul>
            <li><a href="${pageContext.request.contextPath}/home">Home</a></li>
            <li><a href="${pageContext.request.contextPath}/appointment">Appointment</a></li>
            <li><a href="${pageContext.request.contextPath}/lawyers">lawyers</a></li>
            <li><a href="${pageContext.request.contextPath}/about-us">About Us</a></li>
            <li><a href="${pageContext.request.contextPath}/contact-us">Contact Us</a></li>
            <li><a href="${pageContext.request.contextPath}/log-in">Log In</a></li>
        </ul>
    </nav>
</header>

<!-- Team Members Grid -->
<div class="team-container">
    <!-- Team Member 1 -->
    <div class="team-member">
        <img src="${pageContext.request.contextPath}/assets/images/jeniffer.png" alt="Jalira Puri">
        <div class="member-info">
            <h2 class="member-name">Jalira Puri</h2>
            <p class="member-title">PRINCIPAL SENIOR ADVISOR</p>
            <div class="member-contact">
                <p>Contact no.: +977 9765432180</p>
                <p>Email: jalira@lawfirm.com</p>
            </div>
            <div class="member-bio">
                <p>Jalira is a Senior Advisor licensed by Nepal Bar Council. She is a seasoned litigator with decades of legal practice.</p>
            </div>
        </div>
    </div>

    <!-- Team Member 2 -->
    <div class="team-member">
        <img src="${pageContext.request.contextPath}/assets/images/ashutosh-srivastava.png" alt="Aashutosh Srivastava">
        <div class="member-info">
            <h2 class="member-name">Aashutosh Srivastava</h2>
            <p class="member-title">ADVOCATE & LEGAL ADVISOR</p>
            <div class="member-contact">
                <p>Contact No.: +977 9823843129</p>
                <p>Email: aashutosh@lawfirm.com</p>
            </div>
            <div class="member-bio">
                <p>Advocate Aashutosh Srivastava is a distinguished legal professional practicing before the Supreme Court.</p>
            </div>
        </div>
    </div>

    <!-- Team Member 3 -->
    <div class="team-member">
        <img src="${pageContext.request.contextPath}/assets/images/yusha-shrestha.png" alt="Yusha Shrestha">
        <div class="member-info">
            <h2 class="member-name">Yusha Shrestha</h2>
            <p class="member-title">LEGAL ASSOCIATE</p>
            <div class="member-contact">
                <p>Contact NO.: +977 9765432181</p>
                <p>Email: yusha@lawfirm.com</p>
            </div>
            <div class="member-bio">
                <p>Yusha is a Junior Associate at the firm and is engaged in litigation.</p>
            </div>
        </div>
    </div>

    <!-- Team Member 4 -->
    <div class="team-member">
        <img src="${pageContext.request.contextPath}/assets/images/manish-khanal.png" alt="Manish Khanal">
        <div class="member-info">
            <h2 class="member-name">MANISH KHANAL</h2>
            <p class="member-title">LEGAL ASSOCIATE</p>
            <div class="member-contact">
                <p>Contact no.: +977 9812395010</p>
                <p>Email: manish@lawfirm.com</p>
            </div>
            <div class="member-bio">
                <p>Manish is a Legal Associate at the firm and is engaged in civil law.</p>
            </div>
        </div>
    </div>

    <!-- Team Member 5 -->
    <div class="team-member">
        <img src="${pageContext.request.contextPath}/assets/images/anish-basnet.png" alt="Anish Basnet">
        <div class="member-info">
            <h2 class="member-name">ANISH BASNET</h2>
            <p class="member-title">LEGAL ASSOCIATE</p>
            <div class="member-contact">
                <p>Contact NO.: +977 9765520041</p>
                <p>Email: anish@lawfirm.com</p>
            </div>
            <div class="member-bio">
                <p>Anish is a Legal Associate at the firm and is engaged in the litigation.</p>
            </div>
        </div>
    </div>

    <!-- Team Member 6 -->
    <div class="team-member">
        <img src="${pageContext.request.contextPath}/assets/images/susasa-acharaya.png" alt="Susasa Acharya">
        <div class="member-info">
            <h2 class="member-name">SUSASA ACHARYA</h2>
            <p class="member-title">LEGAL ASSOCIATE</p>
            <div class="member-contact">
                <p>Contact NO.: +977 9765520041</p>
                <p>Email: susasa@lawfirm.com</p>
            </div>
            <div class="member-bio">
                <p>Susasa is a Junior Associate at the firm and is engaged in corporate law.</p>
            </div>
        </div>
    </div>
</div>
</body>
</html>