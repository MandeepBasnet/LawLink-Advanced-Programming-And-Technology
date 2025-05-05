<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="sidebar">
    <a href="${pageContext.request.contextPath}/admin/admin-dashboard" 
       class="sidebar-item ${param.activePage eq 'dashboard' ? 'active' : ''}">
        <img src="${pageContext.request.contextPath}/assets/images/home_icon.svg" alt="Dashboard">
        Dashboard
    </a>
    <a href="${pageContext.request.contextPath}/admin/admin-clients" 
       class="sidebar-item ${param.activePage eq 'clients' ? 'active' : ''}">
        <img src="${pageContext.request.contextPath}/assets/images/client_icon.svg" alt="Clients">
        Clients
    </a>
    <a href="${pageContext.request.contextPath}/admin/admin-lawyers" 
       class="sidebar-item ${param.activePage eq 'lawyers' ? 'active' : ''}">
        <img src="${pageContext.request.contextPath}/assets/images/people_icon.svg" alt="Lawyers">
        Lawyers
    </a>
    <a href="${pageContext.request.contextPath}/admin/admin-add-lawyer" 
       class="sidebar-item ${param.activePage eq 'add-lawyer' ? 'active' : ''}">
        <img src="${pageContext.request.contextPath}/assets/images/add_icon.svg" alt="Add Lawyer">
        Add Lawyer
    </a>
    <a href="${pageContext.request.contextPath}/admin/admin-appointments" 
       class="sidebar-item ${param.activePage eq 'appointments' ? 'active' : ''}">
        <img src="${pageContext.request.contextPath}/assets/images/appointment_icon.svg" alt="Appointments">
        Appointments
    </a>
</div>
