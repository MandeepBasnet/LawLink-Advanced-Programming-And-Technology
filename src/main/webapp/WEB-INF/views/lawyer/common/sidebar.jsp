<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 5/2/2025
  Time: 9:03 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<nav class="sidebar">
  <ul>
    <li class="sidebar-item ${activePage eq 'dashboard' ? 'active' : ''}">
      <a href="${pageContext.request.contextPath}/lawyer/lawyer-dashboard">
        <img src="${pageContext.request.contextPath}/assets/images/home_icon.svg" alt="Dashboard">
        Dashboard
      </a>
    </li>
    <li class="sidebar-item ${activePage eq 'about' ? 'active' : ''}">
      <a href="${pageContext.request.contextPath}/lawyer/about">
        <img src="${pageContext.request.contextPath}/assets/images/people_icon.svg" alt="About Lawyer">
        About Lawyer
      </a>
    </li>
    <li class="sidebar-item ${activePage eq 'profile' ? 'active' : ''}">
      <a href="${pageContext.request.contextPath}/lawyer/lawyer-profile">
        <img src="${pageContext.request.contextPath}/assets/images/people_icon.svg" alt="Profile">
        Profile
      </a>
    </li>
    <li class="sidebar-item ${activePage eq 'reviews' ? 'active' : ''}">
      <a href="${pageContext.request.contextPath}/lawyer/all-reviews">
        <img src="${pageContext.request.contextPath}/assets/images/appointment_icon.svg" alt="Reviews">
        Reviews
      </a>
    </li>
  </ul>
</nav>
