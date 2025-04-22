<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 4/21/2025
  Time: 1:17 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="header">
    <div class="logo-container">
        <img src="${pageContext.request.contextPath}/assets/images/logo.png" alt="LawLink Logo" class="logo">
        <span class="logo-text">LawLink</span>
    </div>
    <div class="user-info">
        <img src="${pageContext.request.contextPath}/assets/images/profile_pic.png" alt="Admin" class="user-avatar">
        <span>John Doe</span>
        <span>Admin</span>

        <form action="${pageContext.request.contextPath}/logout" method="get" style="display:inline;">
            <button type="submit" class="logout-btn">Logout</button>
        </form>
    </div>
</div>

