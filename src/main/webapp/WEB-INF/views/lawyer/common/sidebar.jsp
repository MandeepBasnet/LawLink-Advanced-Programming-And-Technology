
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="sidebar">
  <a href="${pageContext.request.contextPath}/lawyer/lawyer-dashboard"
     class="sidebar-item ${param.activePage eq 'dashboard' ? 'active' : ''}">
    <img src="${pageContext.request.contextPath}/assets/images/home_icon.svg" alt="Dashboard">
    Dashboard
  </a>
  <a href="${pageContext.request.contextPath}/lawyer/about"
     class="sidebar-item ${param.activePage eq 'about' ? 'active' : ''}">
    <img src="${pageContext.request.contextPath}/assets/images/people_icon.svg" alt="About Lawyer">
    About
  </a>
  <a href="${pageContext.request.contextPath}/lawyer/lawyer-profile"
     class="sidebar-item ${param.activePage eq 'profile' ? 'active' : ''}">
    <img src="${pageContext.request.contextPath}/assets/images/people_icon.svg" alt="Profile">
    Profile
  </a>
</div>
