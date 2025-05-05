<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Book Appointment - Law Link</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" />
</head>
<body>
<jsp:include page="includes/header.jsp" />

<!-- Main Content -->
<div class="main-content book-appointment-page">
    <div class="container">
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>
        <c:if test="${not empty success}">
            <div class="alert alert-success">${success}</div>
        </c:if>
        <div class="appointment-layout">
            <!-- Left Column: Lawyer Profile, Appointment Form, Latest Reviews -->
            <div class="left-section">
                <!-- Lawyer Profile -->
                <div class="lawyer-profile">
                    <c:choose>
                        <c:when test="${not empty lawyer}">
                            <img src="${pageContext.request.contextPath}/assets/images/${lawyer.profileImage}" alt="${lawyer.fullName}'s profile picture" class="lawyer-image" onerror="this.src='${pageContext.request.contextPath}/assets/images/profile_pic.png'" />
                            <div class="lawyer-info">
                                <h2 class="lawyer-name">${lawyer.fullName}</h2>
                                <p class="lawyer-title">${lawyer.specialization}</p>
                                <p class="lawyer-experience">Experience: ${lawyer.experienceYears} Years</p>
                                <p class="lawyer-fee">Booking fee: $${lawyer.consultationFee}</p>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <img src="${pageContext.request.contextPath}/assets/images/zaina.png" alt="Zaina Rai's profile picture" class="lawyer-image" />
                            <div class="lawyer-info">
                                <h2 class="lawyer-name">Zaina Rai</h2>
                                <p class="lawyer-title">Principal senior adviser</p>
                                <p class="lawyer-experience">Experience: 5+ Years</p>
                                <p class="lawyer-fee">Booking fee: $120</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- Appointment Form -->
                <div class="appointment-form">
                    <form id="appointmentForm" action="${pageContext.request.contextPath}/client/book-appointment" method="post">
                        <input type="hidden" name="lawyerId" value="${lawyer.lawyerId}" />
                        <input type="hidden" id="appointmentDate" name="appointmentDate" />
                        <input type="hidden" id="appointmentTime" name="appointmentTime" />
                        <input type="hidden" name="duration" value="30" />
                        <div class="form-group">
                            <label for="clientName">Appointment for:</label>
                            <input type="text" id="clientName" name="clientName" class="form-control" placeholder="Add your name" required />
                        </div>
                        <div class="form-group">
                            <label for="clientPhone">Phone Number:</label>
                            <input type="tel" id="clientPhone" name="clientPhone" class="form-control" placeholder="Add your phone number" pattern="[0-9]{10}" title="Please enter a valid 10-digit phone number" required />
                        </div>
                        <div class="form-group">
                            <label for="notes">Notes:</label>
                            <textarea id="notes" name="notes" class="form-control" placeholder="Add any additional notes"></textarea>
                        </div>
                    </form>
                </div>

                <!-- Reviews Section -->
                <div class="reviews-section">
                    <h3 class="reviews-title">Latest reviews</h3>
                    <div class="reviews-container" id="reviewsContainer">
                        <!-- Reviews populated via JavaScript -->
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
                            <span class="month-nav prev-month"><i class="fas fa-chevron-left"></i></span>
                            <span id="currentMonth"></span>
                            <span class="month-nav next-month"><i class="fas fa-chevron-right"></i></span>
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
                        <div class="days" id="calendarDays"></div>
                    </div>

                    <button class="select-button" id="selectDateButton">Select Date</button>
                </div>

                <!-- Time Selection -->
                <div class="time-selection">
                    <h3 class="calendar-title">Select appointment time:</h3>
                    <div class="time-slots" id="timeSlots"></div>
                    <button class="select-button mt-4" id="selectTimeButton">Select Time</button>
                </div>

                <!-- Book Appointment Button -->
                <button class="select-button mt-4 book-appointment-btn" id="bookAppointmentButton">Book Appointment</button>
            </div>
        </div>
    </div>
</div>

<jsp:include page="includes/footer.jsp" />

<!-- Custom JavaScript for interactive elements -->
<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Calendar Logic
        const today = new Date();
        let currentMonth = today.getMonth();
        let currentYear = today.getFullYear();
        const monthNames = ["January", "February", "March", "April", "May", "June",
            "July", "August", "September", "October", "November", "December"];

        function renderCalendar() {
            const firstDay = new Date(currentYear, currentMonth, 1);
            const lastDay = new Date(currentYear, currentMonth + 1, 0);
            const firstDayOfWeek = firstDay.getDay();
            const daysInMonth = lastDay.getDate();

            document.getElementById('currentMonth').textContent = monthNames[currentMonth] + ' ' + currentYear;
            const calendarDays = document.getElementById('calendarDays');
            calendarDays.innerHTML = '';

            // Add empty slots for days before the first day
            for (let i = 0; i < firstDayOfWeek; i++) {
                calendarDays.innerHTML += '<div></div>';
            }

            // Add days of the month
            for (let day = 1; day <= daysInMonth; day++) {
                const date = new Date(currentYear, currentMonth, day);
                const isPast = date < new Date(today.getFullYear(), today.getMonth(), today.getDate());
                const isToday = date.toDateString() === today.toDateString();
                calendarDays.innerHTML += '<div class="day ' + (isPast ? 'disabled' : '') + ' ' + (isToday ? 'today' : '') + '">' + day + '</div>';
            }
        }

        renderCalendar();

        // Navigation for previous/next month
        document.querySelector('.prev-month').addEventListener('click', function() {
            if (currentMonth === today.getMonth() && currentYear === today.getFullYear()) return;
            currentMonth--;
            if (currentMonth < 0) {
                currentMonth = 11;
                currentYear--;
            }
            renderCalendar();
            bindDayEvents();
        });

        document.querySelector('.next-month').addEventListener('click', function() {
            currentMonth++;
            if (currentMonth > 11) {
                currentMonth = 0;
                currentYear++;
            }
            renderCalendar();
            bindDayEvents();
        });

        // Day selection
        let selectedDate = null;
        function bindDayEvents() {
            const days = document.querySelectorAll('.day:not(.disabled)');
            days.forEach(day => {
                day.addEventListener('click', function() {
                    document.querySelectorAll('.day').forEach(d => d.classList.remove('selected'));
                    this.classList.add('selected');
                    const dayStr = ('0' + this.textContent).slice(-2);
                    const monthStr = ('0' + (currentMonth + 1)).slice(-2);
                    selectedDate = currentYear + '-' + monthStr + '-' + dayStr;
                    document.getElementById('appointmentDate').value = selectedDate;
                    fetchTimeSlots(selectedDate);
                });
            });
        }

        bindDayEvents();

        document.getElementById('selectDateButton').addEventListener('click', function() {
            if (selectedDate) {
                alert('Date selected: ' + selectedDate);
            } else {
                alert('Please select a date.');
            }
        });

        // Fetch time slots dynamically
        function fetchTimeSlots(selectedDate) {
            const lawyerId = ${lawyer.lawyerId != null ? lawyer.lawyerId : 0};
            fetch('${pageContext.request.contextPath}/client/book-appointment-page?lawyerId=' + lawyerId + '&action=getTimeSlots&date=' + selectedDate)
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Network response was not ok: ' + response.status);
                    }
                    return response.json();
                })
                .then(data => {
                    const timeSlotsContainer = document.getElementById('timeSlots');
                    timeSlotsContainer.innerHTML = '';
                    const hours = ['09:00', '10:00', '11:00', '12:00', '13:00', '14:00', '15:00', '16:00', '17:00'];

                    hours.forEach(hour => {
                        const isBooked = data.bookedSlots.includes(hour);
                        timeSlotsContainer.innerHTML += '<div class="time-slot ' + (isBooked ? 'disabled' : '') + '">' + hour + '</div>';
                    });

                    // Bind time slot events
                    const timeSlots = document.querySelectorAll('.time-slot:not(.disabled)');
                    timeSlots.forEach(slot => {
                        slot.addEventListener('click', function() {
                            document.querySelectorAll('.time-slot').forEach(s => s.classList.remove('selected'));
                            this.classList.add('selected');
                            const selectedTime = this.textContent + ':00';
                            document.getElementById('appointmentTime').value = selectedTime;
                        });
                    });
                })
                .catch(error => {
                    console.error('Error fetching time slots:', error);
                    alert('Failed to load available time slots.');
                });
        }

        // Fetch reviews dynamically
        function fetchReviews() {
            const lawyerId = ${lawyer.lawyerId != null ? lawyer.lawyerId : 0};
            const reviewsContainer = document.getElementById('reviewsContainer');
            reviewsContainer.innerHTML = '<p>Loading reviews...</p>';

            if (lawyerId <= 0) {
                reviewsContainer.innerHTML = '<p>No reviews available.</p>';
                return;
            }

            fetch('${pageContext.request.contextPath}/client/reviews?lawyerId=' + lawyerId, {
                method: 'GET',
                headers: {
                    'Accept': 'application/json'
                }
            })
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Failed to fetch reviews: HTTP ' + response.status);
                    }
                    return response.json();
                })
                .then(reviews => {
                    reviewsContainer.innerHTML = '';
                    if (Array.isArray(reviews) && reviews.length > 0) {
                        reviews.forEach(review => {
                            const stars = Array(5).fill(0).map((_, i) =>
                                '<i class="fa' + (review.rating > i ? 's' : 'r') + ' fa-star"></i>'
                            ).join('');
                            const comment = review.comment || 'No comment provided';
                            const title = comment.length > 20 ? comment.substring(0, 20) + '...' : comment;
                            const date = new Date(review.reviewDate).toLocaleDateString('en-US', {
                                month: 'short', day: 'numeric', year: 'numeric'
                            });

                            reviewsContainer.innerHTML +=
                                '<div class="review-card">' +
                                '<div class="review-stars">' + stars + '</div>' +
                                '<h4 class="review-title">' + title + '</h4>' +
                                '<p class="review-body">' + comment + '</p>' +
                                '<div class="reviewer">' +
                                '<img src="' + window.location.origin + '/assets/images/default-reviewer.png" alt="Reviewer avatar" class="reviewer-avatar" />' +
                                '<div class="reviewer-info">' +
                                '<div class="reviewer-name">' + (review.reviewerName || 'Anonymous') + '</div>' +
                                '<div class="reviewer-date">' + date + '</div>' +
                                '</div>' +
                                '</div>' +
                                '</div>';
                        });
                    } else {
                        reviewsContainer.innerHTML = '<p>No reviews available.</p>';
                    }
                })
                .catch(error => {
                    console.error('Error fetching reviews:', error.message);
                    reviewsContainer.innerHTML = '<p>Failed to load reviews.</p>';
                });
        }

        fetchReviews();

        document.getElementById('selectTimeButton').addEventListener('click', function() {
            const selectedTime = document.getElementById('appointmentTime').value;
            if (selectedTime) {
                alert('Time selected: ' + selectedTime);
            } else {
                alert('Please select a time.');
            }
        });

        // Book Appointment button
        document.getElementById('bookAppointmentButton').addEventListener('click', function() {
            const form = document.getElementById('appointmentForm');
            const appointmentDate = document.getElementById('appointmentDate').value;
            const appointmentTime = document.getElementById('appointmentTime').value;
            const clientName = document.getElementById('clientName').value;
            const clientPhone = document.getElementById('clientPhone').value;

            if (!appointmentDate) {
                alert('Please select an appointment date.');
                return;
            }
            if (!appointmentTime) {
                alert('Please select an appointment time.');
                return;
            }
            if (!clientName) {
                alert('Please enter your name.');
                return;
            }
            if (!clientPhone || !/^[0-9]{10}$/.test(clientPhone)) {
                alert('Please enter a valid 10-digit phone number.');
                return;
            }

            form.submit();
        });
    });
</script>

<style>
    :root {
        --highlight-color: #3498db;
    }
    .day.disabled {
        color: #ccc;
        cursor: not-allowed;
    }
    .day.today {
        color: var(--highlight-color);
        font-weight: bold;
    }
    .time-slot.disabled {
        color: #ccc;
        cursor: not-allowed;
    }
    .time-slot.selected, .day.selected {
        background-color: var(--highlight-color);
        color: white;
    }
    .alert {
        padding: 15px;
        margin-bottom: 20px;
        border-radius: 4px;
    }
    .alert-success {
        background-color: #d4edda;
        color: #155724;
        border: 1px solid #c3e6cb;
    }
    .alert-danger {
        background-color: #f8d7da;
        color: #721c24;
        border: 1px solid #f5c6cb;
    }
</style>
</body>
</html>