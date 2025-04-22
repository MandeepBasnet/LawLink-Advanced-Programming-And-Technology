<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard Add Lawyer - LawLink</title>
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
            background-color: #C8CDD0;
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

        .add-lawyer-section {
            margin: 20px;
        }

        .section-title {
            font-size: 20px;
            margin-bottom: 15px;
        }

        .add-lawyer-form {
            background-color: #C8CDD0;
            border-radius: 10px;
            padding: 20px;
        }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        .upload-section {
            display: flex;
            flex-direction: column;
            align-items: center;
            margin-bottom: 30px;
        }

        .avatar-placeholder {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            background-color: #f5f5f5;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 15px;
            overflow: hidden;
            border: 3px solid #4F5B63;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .avatar-placeholder:hover {
            transform: scale(1.05);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.3);
        }

        .avatar-placeholder img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .upload-btn {
            background-color: #4F5B63;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
            letter-spacing: 0.5px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
            transition: background-color 0.3s ease, transform 0.2s ease;
        }

        .upload-btn:hover {
            background-color: #3a444b;
            transform: translateY(-2px);
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }

        .form-input {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }

        .form-select {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }

        .form-textarea {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 5px;
            resize: vertical;
            height: 100px;
        }

        .submit-btn {
            background-color: #4F5B63;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 20px;
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
            <img src="${pageContext.request.contextPath}/assets/images/client_icon.svg" alt="Clients">
            Clients
        </a>
        <a href="${pageContext.request.contextPath}/admin/admin-lawyers" class="sidebar-item ">
            <img src="${pageContext.request.contextPath}/assets/images/clients_icon.svg" alt="Lawyers">
            Lawyers
        </a>
        <a href="${pageContext.request.contextPath}/admin/admin-add-lawyer" class="sidebar-item ">
            <img src="${pageContext.request.contextPath}/assets/images/add_icon.svg" alt="Add Lawyer">
            Add Lawyer
        </a>
        <a href="${pageContext.request.contextPath}/admin/admin-appointments" class="sidebar-item ">
            <img src="${pageContext.request.contextPath}/assets/images/appointment_icon.svg" alt="Appointments">
            Appointments
        </a>
    </div>

    <div class="main-content">
        <div class="add-lawyer-section">
            <h2 class="section-title">Add Lawyer</h2>

            <form action="${pageContext.request.contextPath}/admin/add-Lawyer" method="post" class="add-lawyer-form"
                  enctype="multipart/form-data">
                <div class="upload-section">
                    <div class="avatar-placeholder">
                        <img
                                src="${pageContext.request.contextPath}/assets/images/upload_icon.png"
                                alt="Upload Lawyer Image">
                    </div>
                    <label for="lawyer-image" class="upload-btn">Upload Lawyer Image</label>
                    <input type="file" id="lawyer-image" name="lawyerImage" style="display: none;">
                </div>

                <div class="form-grid">
                    <div class="form-group">
                        <label for="lawyer-name" class="form-label">Lawyer Name</label>
                        <input type="text" id="lawyer-name" name="lawyerName" class="form-input" placeholder="Full Name"
                               required>
                    </div>

                    <div class="form-group">
                        <label for="license-number" class="form-label">License Number</label>
                        <input type="text" id="license-number" name="licenseNumber" class="form-input"
                               placeholder="License Number" required>
                    </div>

                    <div class="form-group">
                        <label for="lawyer-username" class="form-label">Lawyer User Name</label>
                        <input type="text" id="lawyer-username" name="lawyerUsername" class="form-input" placeholder="Username"
                               required>
                    </div>

                    <div class="form-group">
                        <label for="specialization" class="form-label">Specialization</label>
                        <input type="text" id="specialization" name="specialization" class="form-input"
                               placeholder="Specialization" required>
                    </div>

                    <div class="form-group">
                        <label for="username" class="form-label">Username</label>
                        <input type="text" id="username" name="username" class="form-input" placeholder="Username" required>
                    </div>

                    <div class="form-group">
                        <label for="lawyer-password" class="form-label">Lawyer Password</label>
                        <input type="password" id="lawyer-password" name="lawyerPassword" class="form-input"
                               placeholder="Password" required>
                    </div>

                    <div class="form-group">
                        <label for="practice-area" class="form-label">Practice Area</label>
                        <select id="practice-area" name="practiceArea" class="form-select" required>
                            <option value="">Select Practice Area</option>
                            <option value="Criminal Law">Criminal Law</option>
                            <option value="Family Law">Family Law</option>
                            <option value="Property Law">Property Law</option>
                            <option value="Labour Law">Labour Law</option>
                            <option value="International Law">International Law</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="experience" class="form-label">Experience</label>
                        <select id="experience" name="experience" class="form-select" required>
                            <option value="">Select Experience</option>
                            <option value="1 Year">1 Year</option>
                            <option value="2 Years">2 Years</option>
                            <option value="3 Years">3 Years</option>
                            <option value="5+ Years">5+ Years</option>
                            <option value="10+ Years">10+ Years</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="phone" class="form-label">Phone</label>
                        <input type="tel" id="phone" name="phone" class="form-input" placeholder="Phone" required>
                    </div>

                    <div class="form-group">
                        <label for="fees" class="form-label">Fees</label>
                        <input type="text" id="fees" name="fees" class="form-input" placeholder="Fee" required>
                    </div>

                    <div class="form-group">
                        <label for="address" class="form-label">Address</label>
                        <input type="text" id="address" name="address" class="form-input" placeholder="Address" required>
                    </div>

                    <div class="form-group">
                        <label for="education" class="form-label">Education</label>
                        <input type="text" id="education" name="education" class="form-input" placeholder="Education" required>
                    </div>
                </div>

                <div class="form-group">
                    <label for="about-me" class="form-label">About me</label>
                    <textarea id="about-me" name="aboutMe" class="form-textarea" placeholder="About me"></textarea>
                </div>

                <button type="submit" class="submit-btn">Add Lawyer</button>
            </form>
        </div>
    </div>
</div>
</body>

</html>