<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<header class="header">
  <div class="logo-container">
    <img src="${pageContext.request.contextPath}/assets/images/logo.png" alt="LawLink Logo" class="logo">
    <span class="logo-text">LawLink</span>
  </div>
  <div class="user-info">
    <c:choose>
      <c:when test="${not empty sessionScope.user.profileImage}">
        <img src="${pageContext.request.contextPath}/${sessionScope.user.profileImage}?v=${System.currentTimeMillis()}" alt="Profile" class="user-avatar">
      </c:when>
      <c:otherwise>
        <img src="${pageContext.request.contextPath}/images/default-user.jpg" alt="Profile" class="user-avatar">
      </c:otherwise>
    </c:choose>
    <span class="user-name"><c:out value="${sessionScope.user.fullName}"/></span>
    <span class="user-role">Lawyer</span>
    <form action="${pageContext.request.contextPath}/logout" method="post" style="display: inline;">
      <button type="submit" class="logout-btn">Logout</button>
    </form>
  </div>
</header>