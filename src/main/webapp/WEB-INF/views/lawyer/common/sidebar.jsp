<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<aside class="sidebar">
    <a href="${pageContext.request.contextPath}/lawyer-dashboard" class="sidebar-item ${param.activePage == 'dashboard' ? 'active' : ''}">
        <img src="${pageContext.request.contextPath}/assets/icons/dashboard.png" alt="Dashboard">
        Dashboard
    </a>
    <a href="${pageContext.request.contextPath}/about-lawyer" class="sidebar-item ${param.activePage == 'about' ? 'active' : ''}">
        <img src="${pageContext.request.contextPath}/assets/icons/about.png" alt="About Lawyer">
        About Lawyer
    </a>
    <a href="${pageContext.request.contextPath}/lawyer-profile" class="sidebar-item ${param.activePage == 'profile' ? 'active' : ''}">
        <img src="${pageContext.request.contextPath}/assets/icons/profile.png" alt="Profile">
        Profile
    </a>
</aside> 