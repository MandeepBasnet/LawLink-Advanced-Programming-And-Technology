<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard Add Lawyer - LawLink</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/adminStyle.css">
</head>
<body>
<jsp:include page="common/header.jsp" />

<div class="main-container">
    <jsp:include page="common/sidebar.jsp">
        <jsp:param name="activePage" value="add-lawyer" />
    </jsp:include>

    <div class="main-content">
        <div class="add-lawyer-section">
            <h2 class="section-title">Add Lawyer</h2>

            <form action="${pageContext.request.contextPath}/admin/add-Lawyer" method="post" class="add-lawyer-form" enctype="multipart/form-data">
                <div class="upload-section">
                    <div class="avatar-placeholder">
                        <img src="${pageContext.request.contextPath}/assets/images/upload_icon.png" alt="Upload Lawyer Image">
                    </div>
                    <label for="lawyer-image" class="upload-btn">Upload Lawyer Image</label>
                    <input type="file" id="lawyer-image" name="lawyerImage" style="display: none;">
                </div>

                <div class="form-grid">
                    <div class="form-group">
                        <label for="lawyer-name" class="form-label">Lawyer Name</label>
                        <input type="text" id="lawyer-name" name="lawyerName" class="form-input" placeholder="Full Name" required>
                    </div>

                    <div class="form-group">
                        <label for="license-number" class="form-label">License Number</label>
                        <input type="text" id="license-number" name="licenseNumber" class="form-input" placeholder="License Number" required>
                    </div>

                    <div class="form-group">
                        <label for="lawyer-username" class="form-label">Lawyer User Name</label>
                        <input type="text" id="lawyer-username" name="lawyerUsername" class="form-input" placeholder="Username" required>
                    </div>

                    <div class="form-group">
                        <label for="specialization" class="form-label">Specialization</label>
                        <input type="text" id="specialization" name="specialization" class="form-input" placeholder="Specialization" required>
                    </div>

                    <div class="form-group">
                        <label for="username" class="form-label">Username</label>
                        <input type="text" id="username" name="username" class="form-input" placeholder="Username" required>
                    </div>

                    <div class="form-group">
                        <label for="lawyer-password" class="form-label">Lawyer Password</label>
                        <input type="password" id="lawyer-password" name="lawyerPassword" class="form-input" placeholder="Password" required>
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