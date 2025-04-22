<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<header class="header">
    <div class="logo-container">
        <img src="${pageContext.request.contextPath}/assets/images/logo.png" alt="LawLink Logo" class="logo">
        <span class="logo-text">LawLink</span>
    </div>
    <div class="user-info">
        <img src="${pageContext.request.contextPath}/assets/images/profile_pic.png" alt="Hari Narayan Acharya" class="user-avatar">
        <div class="user-details">
            <span class="user-name">Hari Narayan Acharya</span>
            <span class="user-role">Lawyer</span>
        </div>
        <form action="${pageContext.request.contextPath}/logout" method="get" style="display:inline;">
            <button type="submit" class="logout-btn">Logout</button>
        </form>
    </div>
</header> 