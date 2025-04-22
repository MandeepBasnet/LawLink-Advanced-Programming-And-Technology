<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book Appointment - Law Link</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #556673;
            --secondary-color: #3d4a56;
            --text-color: #333;
            --light-text: #fff;
            --border-color: #ddd;
            --highlight-color: #4dabf7;
        }

        body {
            font-family: 'Arial', sans-serif;
            color: var(--text-color);
            line-height: 1.6;
        }

        /* Navbar Styles */
        .navbar {
            background-color: var(--primary-color);
        }

        /* Main Content Styles */
        .main-content {
            padding: 30px 0;
        }

        /* Lawyer Profile */
        .lawyer-profile {
            display: flex;
            margin-bottom: 30px;
        }

        .lawyer-image {
            width: 150px;
            height: 200px;
            object-fit: cover;
            border: 1px solid var(--border-color);
        }

        .lawyer-info {
            padding: 15px;
            border: 1px solid var(--border-color);
            border-left: none;
            width: 250px;
        }

        .lawyer-name {
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 5px;
        }

        .lawyer-title {
            font-size: 14px;
            color: #666;
            margin-bottom: 10px;
        }

        .lawyer-experience, .lawyer-fee {
            font-size: 14px;
            margin-bottom: 5px;
        }

        /* Appointment Form */
        .appointment-form {
            margin-bottom: 30px;
        }

        .form-label {
            font-weight: 600;
            margin-bottom: 10px;
        }

        .form-control {
            margin-bottom: 15px;
            padding: 10px;
        }

        /* Calendar */
        .calendar-section {
            margin-bottom: 30px;
        }

        .calendar-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }

        .calendar-title {
            font-size: 16px;
            font-weight: 600;
        }

        .calendar-month {
            display: flex;
            align-items: center;
        }

        .month-nav {
            cursor: pointer;
            color: var(--primary-color);
            font-size: 18px;
            padding: 0 10px;
        }

        .calendar-grid {
            background-color: #f9f9f9;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }

        .weekdays {
            display: grid;
            grid-template-columns: repeat(7, 1fr);
            text-align: center;
            font-weight: 600;
            color: #888;
            margin-bottom: 10px;
        }

        .days {
            display: grid;
            grid-template-columns: repeat(7, 1fr);
            gap: 10px;
        }

        .day {
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            border-radius: 50%;
            transition: all 0.2s;
        }

        .day:hover {
            background-color: #e9ecef;
        }

        .day.selected {
            background-color: var(--highlight-color);
            color: white;
        }

        .day.today {
            border: 2px solid var(--highlight-color);
        }

        /* Time Selection */
        .time-selection {
            margin-top: 20px;
        }

        .time-slots {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 10px;
            margin-top: 15px;
        }

        .time-slot {
            padding: 10px;
            text-align: center;
            background-color: #f1f3f5;
            border-radius: 5px;
            cursor: pointer;
            transition: all 0.2s;
        }

        .time-slot:hover {
            background-color: #e9ecef;
        }

        .time-slot.selected {
            background-color: var(--highlight-color);
            color: white;
        }

        .select-button {
            display: block;
            width: 150px;
            margin: 20px auto 0;
            padding: 10px;
            background-color: var(--primary-color);
            color: white;
            border: none;
            border-radius: 30px;
            cursor: pointer;
            transition: all 0.2s;
        }

        .select-button:hover {
            background-color: var(--secondary-color);
        }

        /* Reviews */
        .reviews-section {
            margin-top: 40px;
        }

        .reviews-title {
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 20px;
        }

        .reviews-container {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 20px;
        }

        .review-card {
            border: 1px solid var(--border-color);
            border-radius: 5px;
            padding: 15px;
        }

        .review-stars {
            color: #ffc107;
            margin-bottom: 10px;
        }

        .review-title {
            font-weight: 600;
            margin-bottom: 5px;
        }

        .review-body {
            color: #666;
            margin-bottom: 15px;
            font-size: 14px;
        }

        .reviewer {
            display: flex;
            align-items: center;
        }

        .reviewer-avatar {
            width: 30px;
            height: 30px;
            border-radius: 50%;
            margin-right: 10px;
        }

        .reviewer-info {
            font-size: 12px;
            color: #888;
        }

        .reviewer-name {
            font-weight: 600;
            color: #666;
        }
    </style>
</head>
<body>
<!-- NAVBAR -->
<nav class="navbar navbar-expand-lg px-5 py-3">
    <div class="container-fluid">
        <a class="navbar-brand d-flex align-items-center text-white" href="#">
            <img src=${pageContext.request.contextPath}/assets/images/logo.png  alt="LawLink Logo" height="30" class="me-2"/>
            <span class="fw-bold">Law Link</span>
        </a>
        <div class="ms-auto">
            <ul class="navbar-nav d-flex flex-row gap-4">
                <li class="nav-item"><a class="nav-link text-white" href="${pageContext.request.contextPath}/home">Home</a></li>
                <li class="nav-item"><a class="nav-link text-white" href="${pageContext.request.contextPath}/appointment">Appointments</a></li>
                <li class="nav-item"><a class="nav-link text-white" href="${pageContext.request.contextPath}/lawyers">Lawyers</a></li>
                <li class="nav-item"><a class="nav-link text-white" href="${pageContext.request.contextPath}/about-us">About Us</a></li>
                <li class="nav-item"><a class="nav-link text-white" href="${pageContext.request.contextPath}/contact-us">Contact Us</a></li>
            </ul>
        </div>
    </div>
</nav>

<!-- Main Content -->
<div class="main-content">
    <div class="container">
        <div class="row">
            <div class="col-md-6">
                <!-- Lawyer Profile -->
                <div class="lawyer-profile">
                    <img src="${pageContext.request.contextPath}/images/lawyer-zaina.jpg" alt="Zaina Rai" class="lawyer-image">
                    <div class="lawyer-info">
                        <h2 class="lawyer-name">Zaina Rai</h2>
                        <p class="lawyer-title">Principal senior adviser</p>
                        <p class="lawyer-experience">Experience: 5+ Years</p>
                        <p class="lawyer-fee">Booking fee: 120$</p>
                    </div>
                </div>

                <!-- Appointment Form -->
                <div class="appointment-form">
                    <label class="form-label">Appointment for:</label>
                    <input type="text" class="form-control" placeholder="Add your name">
                    <input type="text" class="form-control" placeholder="Add your phone number">
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
                                <img src="lawyer1.png" alt="Reviewer" class="reviewer-avatar">
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
                                <img src="${pageContext.request.contextPath}/images/avatar2.jpg" alt="Reviewer" class="reviewer-avatar">
                                <div class="reviewer-info">
                                    <div class="reviewer-name">Reviewer name</div>
                                    <div class="reviewer-date">Date</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-6">
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
                                // This would normally be calculated dynamically
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
                    </div>

                    <button class="select-button mt-4">Book Now</button>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<!-- Custom JavaScript for interactive elements -->
<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Day selection
        const days = document.querySelectorAll('.day');
        days.forEach(day => {
            day.addEventListener('click', function() {
                // Remove selected class from all days
                days.forEach(d => d.classList.remove('selected'));
                // Add selected class to clicked day
                this.classList.add('selected');
            });
        });

        // Time slot selection
        const timeSlots = document.querySelectorAll('.time-slot');
        timeSlots.forEach(slot => {
            slot.addEventListener('click', function() {
                // Remove selected class from all time slots
                timeSlots.forEach(s => s.classList.remove('selected'));
                // Add selected class to clicked time slot
                this.classList.add('selected');
            });
        });
    });
</script>
</body>
</html>