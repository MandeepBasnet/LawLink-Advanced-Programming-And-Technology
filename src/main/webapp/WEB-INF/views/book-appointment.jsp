<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book Appointment - Law Link</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
</head>
<body>
<jsp:include page="includes/header.jsp" />

<!-- Main Content -->
<div class="main-content book-appointment-page">
    <div class="container">
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>
        <div class="appointment-layout">
            <!-- Left Column: Lawyer Profile, Appointment Form, Latest Reviews -->
            <div class="left-section">
                <!-- Lawyer Profile -->
                <div class="lawyer-profile">
                    <img src="${pageContext.request.contextPath}/assets/images/zaina-rai.png" alt="Zaina Rai" class="lawyer-image">
                    <div class="lawyer-info">
                        <h2 class="lawyer-name">Zaina Rai</h2>
                        <p class="lawyer-title">Principal senior adviser</p>
                        <p class="lawyer-experience">Experience: 5+ Years</p>
                        <p class="lawyer-fee">Booking fee: 120$</p>
                    </div>
                </div>

                <!-- Appointment Form -->
                <div class="appointment-form">
                    <form id="appointmentForm" action="${pageContext.request.contextPath}/client/book-appointment" method="post">
                        <input type="hidden" name="lawyerId" value="${lawyerId}">
                        <input type="hidden" id="appointmentDate" name="appointmentDate">
                        <input type="hidden" id="appointmentTime" name="appointmentTime">
                        <input type="hidden" name="duration" value="30"> <!-- Default duration -->
                        <div class="form-group">
                            <label for="clientName">Appointment for:</label>
                            <input type="text" id="clientName" name="clientName" class="form-control" placeholder="Add your name">
                        </div>
                        <div class="form-group">
                            <label for="clientPhone">Phone Number:</label>
                            <input type="text" id="clientPhone" name="clientPhone" class="form-control" placeholder="Add your phone number">
                        </div>
                    </form>
                </div>

                <!-- Reviews Section -->
                <div class="reviews-section">
                    <h3 class="reviews-title">Latest reviews</h3>
                    <div class="reviews-container">
                        <div class="review-card">
                            <div class="review-stars">
                                <i class="far fa-star"></i>
                                <i class="far fa-star"></i>
                                <i class="far fa-star"></i>
                                <i class="far fa-star"></i>
                                <i class="far fa-star"></i>
                            </div>
                            <h4 class="review-title">Review title</h4>
                            <p class="review-body">Review body</p>
                            <div class="reviewer">
                                <img src="${pageContext.request.contextPath}/assets/images/john.png" alt="Reviewer" class="reviewer-avatar">
                                <div class="reviewer-info">
                                    <div class="reviewer-name">Reviewer name</div>
                                    <div class="reviewer-date">Date</div>
                                </div>
                            </div>
                        </div>

                        <div class="review-card">
                            <div class="review-stars">
                                <i class="far fa-star"></i>
                                <i class="far fa-star"></i>
                                <i class="far fa-star"></i>
                                <i class="far fa-star"></i>
                                <i class="far fa-star"></i>
                            </div>
                            <h4 class="review-title">Review title</h4>
                            <p class="review-body">Review body</p>
                            <div class="reviewer">
                                <img src="${pageContext.request.contextPath}/assets/images/john.png" alt="Reviewer" class="reviewer-avatar">
                                <div class="reviewer-info">
                                    <div class="reviewer-name">Reviewer name</div>
                                    <div class="reviewer-date">Date</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Right Column: Calendar Section and Time Selection -->
            <div class="right-section">
                <!-- Calendar Section -->
                <div class="calendar-section">
                    <div class="calendar-header">
                        <h3 class="calendar-title">Select appointment date:</h3>
                        <div class="calendar-month">
                            <span class="month-nav"><i class="fas fa-chevron-left"></i></span>
                            <span>June 2024</span>
                            <span class="month-nav"><i class="fas fa-chevron-right"></i></span>
                        </div>
                    </div>

                    <div class="calendar-grid">
                        <div class="weekdays">
                            <div>SUN</div>
                            <div>MON</div>
                            <div>TUE</div>
                            <div>WED</div>
                            <div>THU</div>
                            <div>FRI</div>
                            <div>SAT</div>
                        </div>

                        <div class="days">
                            <%
                                String[] days = {"", "", "2", "3", "4", "5", "6", "7", "8",
                                        "9", "10", "11", "12", "13", "14", "15",
                                        "16", "17", "18", "19", "20", "21", "22",
                                        "23", "24", "25", "26", "27", "28", "29", "30", "", ""};

                                for(String day : days) {
                                    if(day.equals("")) {
                            %>
                            <div></div>
                            <% } else if(day.equals("26")) { %>
                            <div class="day selected"><%= day %></div>
                            <% } else if(day.equals("10")) { %>
                            <div class="day" style="color: var(--highlight-color);"><%= day %></div>
                            <% } else { %>
                            <div class="day"><%= day %></div>
                            <% } } %>
                        </div>
                    </div>

                    <button class="select-button">select date</button>
                </div>

                <!-- Time Selection -->
                <div class="time-selection">
                    <h3 class="calendar-title">Select appointment time:</h3>
                    <div class="time-slots">
                        <div class="time-slot">10 AM</div>
                        <div class="time-slot">11 AM</div>
                        <div class="time-slot">12 PM</div>
                        <div class="time-slot">1 PM</div>
                        <div class="time-slot">2 PM</div>
                        <div class="time-slot">3 PM</div>
                        <div class="time-slot">4 PM</div>
                        <div class="time-slot">5 PM</div>
                    </div>
                    <button class="select-button mt-4">select time</button>
                </div>

                <!-- Book Appointment Button -->
                <button class="select-button mt-4 book-appointment-btn">Book Appointment</button>
            </div>
        </div>
    </div>
</div>

<jsp:include page="includes/footer.jsp" />

<!-- Custom JavaScript for interactive elements -->
<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Day selection
        const days = document.querySelectorAll('.day');
        const selectDateButton = document.querySelector('.calendar-section .select-button');
        let selectedDate = null;

        days.forEach(day => {
            day.addEventListener('click', function() {
                days.forEach(d => d.classList.remove('selected'));
                this.classList.add('selected');
                selectedDate = '2024-06-' + this.textContent.padStart(2, '0');
            });
        });

        selectDateButton.addEventListener('click', function() {
            if (selectedDate) {
                document.getElementById('appointmentDate').value = selectedDate;
                alert('Date selected: ' + selectedDate);
            } else {
                alert('Please select a date.');
            }
        });

        // Time slot selection
        const timeSlots = document.querySelectorAll('.time-slot');
        const selectTimeButton = document.querySelector('.time-selection + .select-button');
        let selectedTime = null;

        timeSlots.forEach(slot => {
            slot.addEventListener('click', function() {
                timeSlots.forEach(s => s.classList.remove('selected'));
                this.classList.add('selected');
                let time = this.textContent;
                let hour = parseInt(time.split(' ')[0]);
                let period = time.split(' ')[1];
                if (period === 'PM' && hour !== 12) hour += 12;
                if (period === 'AM' && hour === 12) hour = 0;
                selectedTime = hour.toString().padStart(2, '0') + ':00';
            });
        });

        selectTimeButton.addEventListener('click', function() {
            if (selectedTime) {
                document.getElementById('appointmentTime').value = selectedTime;
                alert('Time selected: ' + selectedTime);
            } else {
                alert('Please select a time.');
            }
        });

        // Book Appointment button submits the form
        const bookButton = document.querySelector('.book-appointment-btn');
        bookButton.addEventListener('click', function() {
            const form = document.getElementById('appointmentForm');
            if (!document.getElementById('appointmentDate').value) {
                alert('Please select an appointment date.');
            } else if (!document.getElementById('appointmentTime').value) {
                alert('Please select an appointment time.');
            } else {
                form.submit();
            }
        });
    });
</script>

<style>
    :root {
        --highlight-color: #3498db;
    }
</style>
</body>
</html>