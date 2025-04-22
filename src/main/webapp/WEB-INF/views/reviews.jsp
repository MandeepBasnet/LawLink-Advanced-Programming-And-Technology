<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%--<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>--%>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Review - LawLink</title>
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      font-family: Arial, sans-serif;
    }

    body {
      background-color: #ffffff;
    }

    .header {
      background-color: #556673;
      color: white;
      padding: 15px 0;
      display: flex;
      justify-content: space-between;
      align-items: center;
    }

    .logo-container {
      display: flex;
      align-items: center;
      margin-left: 30px;
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

    .nav-links {
      display: flex;
      margin-right: 30px;
    }

    .nav-links a {
      color: white;
      text-decoration: none;
      margin-left: 25px;
    }

    .container {
      max-width: 900px;
      margin: 20px auto;
      background-color: rgba(42, 58, 71, 0.3);
      border-radius: 10px;
      padding: 20px;
    }

    .review-title {
      font-size: 28px;
      margin-bottom: 20px;
      border-bottom: 2px solid #333;
      padding-bottom: 10px;
    }

    .appointment-section {
      display: flex;
      margin-bottom: 20px;
    }

    .lawyer-image {
      width: 150px;
      height: 200px;
      object-fit: cover;
      margin-right: 20px;
    }

    .appointment-details {
      flex: 1;
    }

    .appointment-title {
      font-size: 22px;
      margin-bottom: 15px;
    }

    .appointment-info {
      margin-bottom: 8px;
      font-size: 16px;
    }

    .rating-section {
      margin-bottom: 20px;
    }

    .rating-title {
      font-size: 22px;
      margin-bottom: 10px;
    }

    .stars {
      display: flex;
      margin-bottom: 15px;
    }

    .star {
      color: #ccc;
      font-size: 24px;
      margin-right: 5px;
      cursor: pointer;
    }

    .comment-area {
      width: 100%;
      height: 100px;
      padding: 10px;
      border: 1px solid #ccc;
      border-radius: 5px;
      resize: none;
      margin-bottom: 15px;
      font-size: 16px;
    }

    .lawyer-info {
      margin-bottom: 15px;
    }

    .submit-btn {
      background-color: #4F5B63;
      color: white;
      border: none;
      padding: 10px 20px;
      border-radius: 5px;
      cursor: pointer;
      font-size: 16px;
      float: right;
    }

    .client-reviews {
      margin-top: 30px;
      background-color: #C8CDD0;
      border-radius: 10px;
      padding: 20px;
    }

    .reviews-title {
      font-size: 22px;
      margin-bottom: 15px;
      border-bottom: 2px solid #333;
      padding-bottom: 10px;
    }

    .review-date {
      text-align: right;
      background-color: #e2e2e2;
      padding: 5px 15px;
      border-radius: 20px;
      display: inline-block;
      float: right;
    }

    .review-client {
      margin-bottom: 5px;
    }

    .review-lawyer {
      margin-bottom: 15px;
    }

    .review-stars {
      margin: 10px 0;
    }

    .review-comment {
      background-color: #e2e2e2;
      padding: 15px;
      border-radius: 5px;
      margin-top: 10px;
    }
  </style>

</head>

<body>
<div class="header">
  <div class="logo-container">
    <img src="${pageContext.request.contextPath}/assets/images/logo.png" alt="LawLink Logo" class="logo">
    <span class="logo-text">LawLink</span>
  </div>
  <div class="nav-links">
    <a href="${pageContext.request.contextPath}/home">Home</a>
    <a href="${pageContext.request.contextPath}/appointment">Appointment</a>
    <a href="${pageContext.request.contextPath}/lawyers">Lawyers</a>
    <a href="${pageContext.request.contextPath}/about-us">About Us</a>
    <a href="${pageContext.request.contextPath}/contact-us">Contact Us</a>
  </div>
</div>

<div class="container">
  <h1 class="review-title">Submit Your Review</h1>

  <div class="appointment-section">
    <img src="${pageContext.request.contextPath}/assets/lawyers/${appointment.lawyerImage}" alt="Lawyer"
         class="lawyer-image"
         onerror="this.src='${pageContext.request.contextPath}/assets/default-lawyer.jpg'">

    <div class="appointment-details">
      <h2 class="appointment-title">Your Appointment</h2>
      <p class="appointment-info"><strong>Appointment ID:</strong> ${appointment.id}</p>
      <p class="appointment-info"><strong>Appointment Date:</strong> ${appointment.date}</p>
      <p class="appointment-info"><strong>Appointment Time:</strong> ${appointment.time}</p>
      <p class="appointment-info"><strong>Appointment Duration:</strong> ${appointment.duration}</p>
      <p class="appointment-info"><strong>Appointment Status:</strong> ${appointment.status}</p>

      <div class="rating-section">
        <h3 class="rating-title">Rating:</h3>
        <div class="stars">
          <span class="star" onclick="rateAppointment(1)">★</span>
          <span class="star" onclick="rateAppointment(2)">★</span>
          <span class="star" onclick="rateAppointment(3)">★</span>
          <span class="star" onclick="rateAppointment(4)">★</span>
          <span class="star" onclick="rateAppointment(5)">★</span>
        </div>

        <form action="${pageContext.request.contextPath}/submitReview" method="post">
          <input type="hidden" id="appointmentId" name="appointmentId" value="${appointment.id}">
          <input type="hidden" id="ratingValue" name="rating" value="0">
          <textarea class="comment-area" name="comment"
                    placeholder="Leave your comment here..."></textarea>

          <div class="lawyer-info">
            <p>Yusha Shrestha</p>
            <p>By: Hari Kumar</p>
          </div>

          <button type="submit" class="submit-btn">Submit Review</button>
        </form>
      </div>
    </div>
  </div>
</div>

<div class="container client-reviews">
  <h2 class="reviews-title">Client Reviews</h2>

  <div class="review-date">2005-2-20</div>
  <p class="review-client"><strong>Client:</strong> Ram Nepal</p>
  <p class="review-lawyer"><strong>Lawyer:</strong> Baviyan Koirala</p>

  <div class="review-stars">
    <%-- <c:forEach begin="1" end="5" var="i">--%>
    <%-- <span class="star" style="color: #D4AF37;">★</span>--%>
    <%-- </c:forEach>--%>
  </div>

  <div class="review-comment">
    This is comment
  </div>
</div>
</body>
<script>
  function rateAppointment(rating) {
    // Set all stars to default color
    const stars = document.querySelectorAll('.stars .star');
    stars.forEach((star, index) => {
      if (index < rating) {
        star.style.color = '#D4AF37'; // Gold color for selected stars
      } else {
        star.style.color = '#ccc'; // Default color for unselected stars
      }
    });

    // Store the rating value
    document.getElementById('ratingValue').value = rating;
  }
</script>

</html>