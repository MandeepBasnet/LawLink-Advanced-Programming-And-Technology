<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<header>
    <div class="container header-content">
        <div class="logo-container">
            <img src="${pageContext.request.contextPath}/assets/images/logo.png" alt="LawLink Logo" class="logo">
            <span class="logo-text">LawLink</span>
        </div>
        <nav>
            <ul>
                <li><a href="${pageContext.request.contextPath}/home">Home</a></li>
                <li><a href="${pageContext.request.contextPath}/appointment">Appointments</a></li>
                <li><a href="${pageContext.request.contextPath}/lawyers">Lawyers</a></li>
                <li><a href="${pageContext.request.contextPath}/about-us">About Us</a></li>
                <li><a href="${pageContext.request.contextPath}/contact-us">Contact Us</a></li>
                <c:choose>
                    <c:when test="${empty sessionScope.user}">
                        <!-- Show these links only when user is NOT logged in -->
                        <li><a href="${pageContext.request.contextPath}/log-in" class="login-btn">Log In</a></li>
                    </c:when>
                    <c:otherwise>
                        <!-- Show profile dropdown only when user IS logged in -->
                        <li>
                            <div class="profile">
                                <img src="${pageContext.request.contextPath}/assets/images/<c:out value="${sessionScope.user.getProfileImage()}" default="profile_pic.png" />" alt="Profile" class="profile-img">
                                <div class="profile-menu">
                                    <a href="${pageContext.request.contextPath}/client/my-appointments">My Appointments</a>
                                    <a href="${pageContext.request.contextPath}/client/my-profile">My Profile</a>
                                    <form action="${pageContext.request.contextPath}/logout" method="post" style="margin:0;">
                                        <button type="submit">Logout</button>
                                    </form>
                                </div>
                            </div>
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </nav>
    </div>
</header>