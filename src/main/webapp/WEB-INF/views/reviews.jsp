<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Review - LawLink</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
</head>
<body>
<jsp:include page="includes/header.jsp" />


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

<jsp:include page="includes/footer.jsp" />

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