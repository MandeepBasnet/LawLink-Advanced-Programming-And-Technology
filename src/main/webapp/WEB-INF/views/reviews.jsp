<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Review - LawLink</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
</head>
<body>
<jsp:include page="/WEB-INF/views/includes/header.jsp" />

<div class="container">
  <h1 class="review-title">Submit Your Review</h1>

  <div class="appointment-section">
    <img src="${pageContext.request.contextPath}/${appointment.lawyer.profileImage != null ? appointment.lawyer.profileImage : 'assets/images/profile_pic.png'}?v=${System.currentTimeMillis()}" alt="Lawyer" class="lawyer-image">

    <div class="appointment-details">
      <h2 class="appointment-title">Your Appointment</h2>
      <p class="appointment-info"><strong>Appointment ID:</strong> ${appointment.appointmentId}</p>
      <p class="appointment-info"><strong>Appointment Date:</strong>
        <fmt:formatDate value="${appointment.appointmentDate}" pattern="dd MMMM, yyyy" />
      </p>
      <p class="appointment-info"><strong>Appointment Time:</strong>
        <fmt:formatDate value="${appointment.appointmentTime}" pattern="hh:mm a" />
      </p>
      <p class="appointment-info"><strong>Lawyer:</strong> ${appointment.lawyer.fullName}</p>
      <p class="appointment-info"><strong>Specialization:</strong> ${appointment.lawyer.specialization}</p>
      <p class="appointment-info"><strong>Status:</strong> ${appointment.status}</p>

      <div class="rating-section">
        <h3 class="rating-title">Rating:</h3>
        <div class="stars">
          <span class="star" onclick="rateAppointment(1)">★</span>
          <span class="star" onclick="rateAppointment(2)">★</span>
          <span class="star" onclick="rateAppointment(3)">★</span>
          <span class="star" onclick="rateAppointment(4)">★</span>
          <span class="star" onclick="rateAppointment(5)">★</span>
        </div>

        <form action="${pageContext.request.contextPath}/client/submitReview" method="post">
          <input type="hidden" id="appointmentId" name="appointmentId" value="${appointment.appointmentId}">
          <input type="hidden" id="ratingValue" name="rating" value="0">
          <input type="hidden" name="csrfToken" value="${sessionScope.csrfToken}">
          <textarea class="comment-area" name="comment"
                    placeholder="Leave your comment here..."></textarea>

          <div class="lawyer-info">
            <p>${appointment.lawyer.fullName}</p>
            <p>By: ${sessionScope.user.fullName}</p>
          </div>

          <button type="submit" class="submit-btn">Submit Review</button>
        </form>
      </div>
    </div>
  </div>
</div>

<div class="container client-reviews">
  <h2 class="reviews-title">Client Reviews</h2>
  <c:forEach var="review" items="${reviews}">
    <div class="review-date">
      <fmt:formatDate value="${review.reviewDate}" pattern="dd MMMM, yyyy" />
    </div>
    <p class="review-client"><strong>Client:</strong> <c:out value="${review.clientName}" /></p>
    <p class="review-lawyer"><strong>Lawyer:</strong> <c:out value="${review.lawyerName}" /></p>
    <div class="review-stars">
      <c:forEach begin="1" end="${review.rating}">
        <span class="star" style="color: #D4AF37;">★</span>
      </c:forEach>
      <c:forEach begin="${review.rating + 1}" end="5">
        <span class="star" style="color: #ccc;">★</span>
      </c:forEach>
    </div>
    <div class="review-comment"><c:out value="${review.comment}" /></div>
  </c:forEach>
</div>

<jsp:include page="/WEB-INF/views/includes/footer.jsp" />

<script>
  function rateAppointment(rating) {
    const stars = document.querySelectorAll('.stars .star');
    stars.forEach((star, index) => {
      star.style.color = index < rating ? '#D4AF37' : '#ccc';
    });
    document.getElementById('ratingValue').value = rating;
  }
</script>
</body>
</html>