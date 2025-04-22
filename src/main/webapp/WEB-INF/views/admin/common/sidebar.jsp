<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 4/21/2025
  Time: 1:17 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="sidebar">
    <a href="${pageContext.request.contextPath}/admin-dashboard" class="sidebar-item ${param.activePage == 'dashboard' ? 'active' : ''}">
        <img src="${pageContext.request.contextPath}/assets/images/home_icon.svg" alt="Dashboard">
        Dashboard
    </a>
    <a href="${pageContext.request.contextPath}/admin-clients" class="sidebar-item ${param.activePage == 'clients' ? 'active' : ''}">
        <img src="${pageContext.request.contextPath}/assets/images/client_icon.svg" alt="Clients">
        Clients
    </a>
    <a href="${pageContext.request.contextPath}/admin-lawyers" class="sidebar-item ${param.activePage == 'lawyers' ? 'active' : ''}">
        <img src="${pageContext.request.contextPath}/assets/images/clients_icon.svg" alt="Lawyers">
        Lawyers
    </a>
    <a href="${pageContext.request.contextPath}/admin-add-lawyer" class="sidebar-item ${param.activePage == 'add-lawyer' ? 'active' : ''}">
        <img src="${pageContext.request.contextPath}/assets/images/add_icon.svg" alt="Add Lawyer">
        Add Lawyer
    </a>
    <a href="${pageContext.request.contextPath}/admin-appointments" class="sidebar-item ${param.activePage == 'appointments' ? 'active' : ''}">
        <img src="${pageContext.request.contextPath}/assets/images/appointment_icon.svg" alt="Appointments">
        Appointments
    </a>
</div>
