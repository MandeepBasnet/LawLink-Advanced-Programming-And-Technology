<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard Add Lawyer - LawLink</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/adminStyle.css">
    <script>
        function validateForm() {
            const phone = document.getElementById('phone').value;
            const phonePattern = /^(\+\d{1,3}\s?)?\(?\d{3}\)?[-.\s]?\d{3}[-.\s]?\d{4}$/;
            if (!phonePattern.test(phone)) {
                alert('Please enter a valid phone number (e.g., 123-456-7890 or +1 123-456-7890).');
                return false;
            }
            const consultationFee = document.getElementById('consultationFee').value;
            if (isNaN(consultationFee) || consultationFee <= 0) {
                alert('Please enter a valid consultation fee.');
                return false;
            }
            return true;
        }
    </script>
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

            <% if (request.getAttribute("error") != null) { %>
            <div class="error-message" style="color: red;"><%= request.getAttribute("error") %></div>
            <% } %>
            <% if (request.getAttribute("success") != null) { %>
            <div class="success-message" style="color: green;"><%= request.getAttribute("success") %></div>
            <% } %>

            <form action="${pageContext.request.contextPath}/admin/admin-add-lawyer" method="post" class="add-lawyer-form" enctype="multipart/form-data" onsubmit="return validateForm()">
                <div class="upload-section">
                    <div class="avatar-placeholder">
                        <img src="${pageContext.request.contextPath}/assets/images/upload_icon.png" alt="Upload Lawyer Image">
                    </div>
                    <label for="lawyer-image" class="upload-btn">Upload Lawyer Image</label>
                    <input type="file" id="lawyer-image" name="lawyerImage" accept="image/*" style="display: none;">
                </div>

                <div class="form-grid">
                    <div class="form-group">
                        <label for="fullName" class="form-label">Full Name</label>
                        <input type="text" id="fullName" name="fullName" class="form-input" placeholder="Full Name" required>
                    </div>

                    <div class="form-group">
                        <label for="licenseNumber" class="form-label">License Number</label>
                        <input type="text" id="licenseNumber" name="licenseNumber" class="form-input" placeholder="License Number" required>
                    </div>

                    <div class="form-group">
                        <label for="username" class="form-label">Username</label>
                        <input type="text" id="username" name="username" class="form-input" placeholder="Username" required>
                    </div>

                    <div class="form-group">
                        <label for="specialization" class="form-label">Specialization</label>
                        <input type="text" id="specialization" name="specialization" class="form-input" placeholder="Specialization" required>
                    </div>

                    <div class="form-group">
                        <label for="email" class="form-label">Email</label>
                        <input type="email" id="email" name="email" class="form-input" placeholder="Email" required>
                    </div>

                    <div class="form-group">
                        <label for="password" class="form-label">Password</label>
                        <input type="password" id="password" name="password" class="form-input" placeholder="Password" required>
                    </div>

                    <div class="form-group">
                        <label for="practiceAreas" class="form-label">Practice Area</label>
                        <select id="practiceAreas" name="practiceAreas" class="form-select" required>
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
                            <option value="1">1 Year</option>
                            <option value="2">2 Years</option>
                            <option value="3">3 Years</option>
                            <option value="5">5+ Years</option>
                            <option value="10">10+ Years</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="phone" class="form-label">Phone</label>
                        <input type="tel" id="phone" name="phone" class="form-input" placeholder="Phone (e.g., 123-456-7890)" required>
                    </div>

                    <div class="form-group">
                        <label for="consultationFee" class="form-label">Consultation Fee</label>
                        <input type="number" id="consultationFee" name="consultationFee" class="form-input" placeholder="Fee" step="0.01" required>
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
                    <label for="aboutMe" class="form-label">About Me</label>
                    <textarea id="aboutMe" name="aboutMe" class="form-textarea" placeholder="About Me"></textarea>
                </div>

                <button type="submit" class="submit-btn">Add Lawyer</button>
            </form>
        </div>
    </div>
</div>
</body>
</html>