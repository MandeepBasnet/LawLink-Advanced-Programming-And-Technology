<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard Clients - LawLink</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }

        body {
            background-color: #ffffff;
            display: flex;
            flex-direction: column;
        }

        .header {
            background-color: #556673;
            color: white;
            padding: 15px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            width: 100%;
            border-radius: 0 0 8px 8px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            z-index: 10;
        }

        .main-container {
            display: flex;
            width: 100%;
            height: calc(100vh - 65px);
            /* Adjust based on navbar height */
        }

        .sidebar {
            width: 175px;
            background-color: rgba(42, 58, 71, 0.5);
            height: 100%;
            padding-top: 20px;
        }

        .sidebar-item {
            padding: 15px 20px;
            display: flex;
            align-items: center;
            color: #333;
            text-decoration: none;
            margin-bottom: 5px;
        }

        .sidebar-item.active {
            background-color: #ffffff;
            border-top-left-radius: 25px;
            border-bottom-left-radius: 25px;
            border-top-right-radius: 0;
            border-bottom-right-radius: 0;
        }

        .sidebar-item img {
            width: 20px;
            height: 20px;
            margin-right: 10px;
        }

        .main-content {
            flex: 1;
            overflow-y: auto;
            padding: 0 15px;
        }

        .logo-container {
            display: flex;
            align-items: center;
        }

        .logo {
            width: 40px;
            height: 40px;
        }

        .logo-text {
            color: white;
            font-size: 20px;
            margin-left: 10px;
        }

        .user-info {
            display: flex;
            align-items: center;
        }

        .user-avatar {
            width: 35px;
            height: 35px;
            border-radius: 50%;
            margin-right: 10px;
        }

        .logout-btn {
            background-color: #333;
            color: white;
            border: none;
            padding: 5px 10px;
            border-radius: 5px;
            margin-left: 15px;
            cursor: pointer;
        }

        .dashboard-stats {
            display: flex;
            justify-content: space-around;
            margin: 20px;
        }

        .stat-card {
            background-color: #f5f5f5;
            border-radius: 10px;
            padding: 15px;
            width: 150px;
            text-align: center;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .stat-icon {
            width: 40px;
            height: 40px;
            margin: 0 auto 10px;
        }

        .stat-number {
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 5px;
        }

        .stat-label {
            color: #555;
        }

        .clients-section {
            margin: 20px;
        }

        .section-title {
            font-size: 20px;
            margin-bottom: 15px;
        }

        .clients-table {
            width: 100%;
            border-collapse: collapse;
            background-color: #C8CDD0;
            border-radius: 10px;
            overflow: hidden;
        }

        .clients-table th {
            background-color: #4F5B63;
            color: white;
            text-align: left;
            padding: 12px 15px;
        }

        .clients-table td {
            padding: 12px 15px;
            border-bottom: 1px solid #ddd;
        }

        .clients-table tr:last-child td {
            border-bottom: none;
        }

        .client-avatar {
            width: 30px;
            height: 30px;
            border-radius: 50%;
            margin-right: 10px;
            vertical-align: middle;
        }
    </style>
</head>

<body>
<div class="header">
    <div class="logo-container">
        <img src="${pageContext.request.contextPath}/assets/images/logo.png" alt="LawLink Logo" class="logo">
        <span class="logo-text">LawLink</span>
    </div>
    <div class="user-info">
        <img src="${pageContext.request.contextPath}/assets/images/profile_pic.png"
             alt="Admin" class="user-avatar">
        <span>John Doe</span>
        <span>Admin</span>
        <form action="${pageContext.request.contextPath}/logout" method="post" style="display: inline;">
            <button type="submit" class="logout-btn">Logout</button>
        </form>
    </div>
</div>

<div class="main-container">
    <div class="sidebar">
        <a href="${pageContext.request.contextPath}/admin/admin-dashboard" class="sidebar-item ">
            <img src="${pageContext.request.contextPath}/assets/images/home_icon.svg" alt="Dashboard">
            Dashboard
        </a>
        <a href="${pageContext.request.contextPath}/admin/admin-clients" class="sidebar-item ">
            <img src="${pageContext.request.contextPath}/assets/images/client_icon.svg" alt="Client">
            Clients
        </a>
        <a href="${pageContext.request.contextPath}/admin/admin-lawyers" class="sidebar-item ">
            <img src="${pageContext.request.contextPath}/assets/images/people_icon.svg" alt="lawyer">
            Lawyers
        </a>
        <a href="${pageContext.request.contextPath}/admin/admin-add-lawyer" class="sidebar-item ">
            <img src="${pageContext.request.contextPath}/assets/images/add_icon.svg" alt="Add Lawyer">
            Add Lawyer
        </a>
        <a href="${pageContext.request.contextPath}/admin/admin-appointments" class="sidebar-item ">
            <img src="${pageContext.request.contextPath}/assets/images/appointment-img.png" alt="Appointments">
            Appointments
        </a>
    </div>

    <div class="main-content">
        <div class="dashboard-stats">
            <div class="stat-card">
                <img src="${pageContext.request.contextPath}/assets/images/clients_icon.svg" alt="Clients"
                     class="stat-icon">
                <div class="stat-number">12</div>
                <div class="stat-label">Clients</div>
            </div>
            <div class="stat-card">
                <img src="${pageContext.request.contextPath}/assets/images/lawyer_icon.png" alt="Lawyers"
                     class="stat-icon">
                <div class="stat-number">15</div>
                <div class="stat-label">Lawyers</div>
            </div>
            <div class="stat-card">
                <img src="${pageContext.request.contextPath}/assets/images/appointments_icon.svg"
                     alt="Appointments" class="stat-icon">
                <div class="stat-number">12</div>
                <div class="stat-label">Appointments</div>
            </div>
        </div>

        <div class="clients-section">
            <h2 class="section-title">Clients</h2>

            <table class="clients-table">
                <thead>
                <tr>
                    <th>S.N.</th>
                    <th>Client</th>
                    <th>Username</th>
                    <th>Address</th>
                    <th>Email</th>
                    <th>Phone</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>1</td>
                    <td>
                        <img
                                src="${pageContext.request.contextPath}/assets/images/john.png"
                                alt="John Thapa" class="client-avatar">
                        John Thapa
                    </td>
                    <td>john123</td>
                    <td>Itahari, Sunsari</td>
                    <td>johnthapa@gmail.com</td>
                    <td>9812345678</td>
                </tr>
                <tr>
                    <td>2</td>
                    <td>
                        <img
                                src="${pageContext.request.contextPath}/assets/images/profile_pic.png"
                                alt="Ram Rai" class="client-avatar">
                        Ram Rai
                    </td>
                    <td>ramrai</td>
                    <td>Biratnagar, Morang</td>
                    <td>ramrai@gmail.com</td>
                    <td>9786583211</td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>
</body>

</html>