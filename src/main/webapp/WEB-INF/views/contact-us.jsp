<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us - Law Link</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
</head>
<body>
<jsp:include page="includes/header.jsp" />

<!-- Main Content -->
<div class="main-content">
    <div class="container">
        <h1 class="page-title">Contact Us</h1>

        <div class="contact-info">
            <div class="contact-item">
                <div class="contact-icon">
                    <i class="fas fa-map-marker-alt"></i>
                </div>
                <h3 class="contact-title">Office location</h3>
                <p class="contact-text">
                    Itahari-12, Sunsari, Sagarmatha chowk,<br>
                    Central mall, 1st floor, Dharan line, Nepal
                </p>
            </div>

            <div class="contact-item">
                <div class="contact-icon">
                    <i class="fas fa-phone-alt"></i>
                </div>
                <h3 class="contact-title">Phone Number</h3>
                <p class="contact-text">
                    +9802778377
                </p>
            </div>

            <div class="contact-item">
                <div class="contact-icon">
                    <i class="fas fa-envelope"></i>
                </div>
                <h3 class="contact-title">Email</h3>
                <p class="contact-text">
                    lawlinkprivatelimited@lawlink.com
                </p>
            </div>
        </div>
    </div>
</div>

<!-- Footer -->
<jsp:include page="includes/footer.jsp" />

<!-- Bootstrap JS Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>