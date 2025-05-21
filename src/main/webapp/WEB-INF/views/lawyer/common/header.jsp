<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title><c:out value="${param.pageTitle}"/> - LawLink</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/lawyerStyle.css">
</head>
<body>
<header class="header">
  <div class="logo-container">
    <img src="${pageContext.request.contextPath}/assets/images/logo.png" alt="LawLink Logo" class="logo">
    <span class="logo-text">LawLink</span>
  </div>
  <div class="user-info">
    <c:choose>
      <c:when test="${not empty sessionScope.user.profileImage}">
        <img src="${pageContext.request.contextPath}/assets/images/${sessionScope.user.profileImage}" alt="Profile" class="user-avatar">
      </c:when>
      <c:otherwise>
        <img src="${pageContext.request.contextPath}/assets/images/default.png" alt="Profile" class="user-avatar">
      </c:otherwise>
    </c:choose>
    <span class="user-name"><c:out value="${sessionScope.user.fullName}"/></span>
    <span class="user-role">Lawyer</span>
    <form action="${pageContext.request.contextPath}/logout" method="post" style="display: inline;">
      <button type="submit" class="logout-btn">Logout</button>
    </form>
  </div>
</header>
</body>
</html>