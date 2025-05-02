document.addEventListener("DOMContentLoaded", () => {
    // Mobile menu toggle
    const mobileMenuToggle = document.getElementById("mobile-menu-toggle")
    const navbarMenu = document.getElementById("navbar-menu")

    if (mobileMenuToggle && navbarMenu) {
        mobileMenuToggle.addEventListener("click", () => {
            navbarMenu.classList.toggle("show")
        })
    }

    // Password toggle
    const passwordToggles = document.querySelectorAll(".password-toggle")

    passwordToggles.forEach((toggle) => {
        toggle.addEventListener("click", function () {
            const targetId = this.getAttribute("data-target")
            const passwordInput = document.getElementById(targetId)

            if (passwordInput.type === "password") {
                passwordInput.type = "text"
                this.innerHTML = '<i class="fas fa-eye-slash"></i>'
            } else {
                passwordInput.type = "password"
                this.innerHTML = '<i class="fas fa-eye"></i>'
            }
        })
    })

    // Alert dismissal
    const alertCloseButtons = document.querySelectorAll(".alert .close")

    alertCloseButtons.forEach((button) => {
        button.addEventListener("click", function () {
            const alert = this.parentElement
            alert.style.display = "none"
        })
    })

    // Form validation
    const forms = document.querySelectorAll(".needs-validation")

    forms.forEach((form) => {
        form.addEventListener("submit", (event) => {
            if (!form.checkValidity()) {
                event.preventDefault()
                event.stopPropagation()
            }

            form.classList.add("was-validated")
        })
    })

    // Appointment date selection
    const appointmentDate = document.getElementById("appointment-date")

    if (appointmentDate) {
        appointmentDate.addEventListener("change", () => {
            updateAvailableTimeSlots()
        })
    }
})

// Function to update available time slots based on selected date
function updateAvailableTimeSlots() {
    const appointmentDate = document.getElementById("appointment-date")
    const timeSlotContainer = document.getElementById("time-slot-container")

    if (!appointmentDate || !timeSlotContainer) {
        return
    }

    const selectedDate = appointmentDate.value
    const lawyerId = document.getElementById("lawyer-id").value

    if (!selectedDate || !lawyerId) {
        return
    }

    // Get the context path
    const contextPath = document.querySelector('meta[name="contextPath"]').getAttribute("content")

    // Make AJAX request to get available time slots
    fetch(`${contextPath}/api/time-slots?lawyerId=${lawyerId}&date=${selectedDate}`)
        .then((response) => response.json())
        .then((data) => {
            if (data.success) {
                // Clear existing time slots
                timeSlotContainer.innerHTML = ""

                if (data.timeSlots.length > 0) {
                    // Create time slot elements
                    data.timeSlots.forEach((timeSlot) => {
                        const timeSlotElement = document.createElement("div")
                        timeSlotElement.className = "time-slot"
                        timeSlotElement.innerHTML = `
                            <input type="radio" id="time-${timeSlot}" name="appointmentTime" value="${timeSlot}" required>
                            <label for="time-${timeSlot}">${timeSlot}</label>
                        `
                        timeSlotContainer.appendChild(timeSlotElement)
                    })
                } else {
                    timeSlotContainer.innerHTML = "<p>No available time slots for the selected date.</p>"
                }
            } else {
                timeSlotContainer.innerHTML = "<p>Failed to load time slots. Please try again.</p>"
            }
        })
        .catch((error) => {
            console.error("Error fetching time slots:", error)
            timeSlotContainer.innerHTML = "<p>Failed to load time slots. Please try again.</p>"
        })
}
