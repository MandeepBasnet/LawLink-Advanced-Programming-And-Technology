<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>My Profile - LawLink</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/clientStyle.css?v=1">
</head>
<body>
<!-- Navigation Bar -->
<header>
  <div class="container header-content">
    <div class="logo-container">
      <img src="${pageContext.request.contextPath}/assets/images/logo.png" alt="LawLink Logo" class="logo">
      <span class="logo-text">LawLink</span>
    </div>
    <nav>
      <ul>
        <li><a href="${pageContext.request.contextPath}/home">Home</a></li>
        <li><a href="${pageContext.request.contextPath}/appointment">Appointments</a></li>
        <li><a href="${pageContext.request.contextPath}/lawyers">Lawyers</a></li>
        <li><a href="${pageContext.request.contextPath}/about-us">About Us</a></li>
        <li><a href="${pageContext.request.contextPath}/contact-us">Contact Us</a></li>
        <c:choose>
          <c:when test="${empty sessionScope.user}">
            <li><a href="${pageContext.request.contextPath}/log-in" class="login-btn">Log In</a></li>
          </c:when>
          <c:otherwise>
            <li>
              <div class="profile">
                <img src="${pageContext.request.contextPath}/${not empty sessionScope.user.profileImage ? sessionScope.user.profileImage : 'images/default-user.jpg'}?v=${System.currentTimeMillis()}" alt="Profile" class="profile-img">
                <div class="profile-menu">
                  <a href="${pageContext.request.contextPath}/client/my-appointments">My Appointments</a>
                  <a href="${pageContext.request.contextPath}/client/my-profile">My Profile</a>
                  <form action="${pageContext.request.contextPath}/logout" method="post" style="margin:0;">
                    <button type="submit">Logout</button>
                  </form>
                </div>
              </div>
            </li>
          </c:otherwise>
        </c:choose>
      </ul>
    </nav>
  </div>
</header>

<!-- Main Content -->
<div class="container">
  <h1>My Profile</h1>

  <!-- Success/Error Messages -->
  <div id="messageContainer"></div>

  <form id="profileForm" enctype="multipart/form-data">
    <div class="profile-pic-container">
      <div class="info-heading">Profile Picture</div>
      <div class="profile-pic-wrapper view-mode">
        <img src="${pageContext.request.contextPath}/${not empty user.profileImage ? user.profileImage : 'images/default-user.jpg'}?v=${System.currentTimeMillis()}" alt="Profile Picture" class="profile-pic-large" id="profilePicDisplay">
        <label class="profile-pic-overlay" for="profilePicture">
          <i class="fas fa-camera"></i> Change Photo
        </label>
      </div>
      <div class="profile-pic-edit edit-mode" style="display: none;">
        <input type="file" name="profilePicture" id="profilePicture" accept="image/*">
        <p>Accepted formats: JPEG, PNG (Max size: 10MB)</p>
        <div class="image-preview" id="imagePreview" style="display: none;">
          <img id="previewImage" alt="Image Preview" class="profile-pic-large">
        </div>
        <div class="error-text" id="profilePictureError"></div>
      </div>
    </div>

    <div class="info-item">
      <div class="info-label">Full Name:</div>
      <div class="info-value view-mode" id="userName"><c:out value="${user.fullName}"/></div>
      <div class="info-edit edit-mode" style="display: none;">
        <input type="text" name="fullName" id="fullName" value="${user.fullName}" required>
        <div class="error-text" id="fullNameError"></div>
      </div>
    </div>

    <div class="info-container">
      <div class="info-column">
        <div class="info-heading">Basic Information</div>

        <div class="info-item">
          <div class="info-label">Username:</div>
          <div class="info-value"><c:out value="${user.username}"/></div>
        </div>

        <div class="info-item">
          <div class="info-label">Gender:</div>
          <div class="info-value view-mode" id="genderDisplay"><c:out value="${user.gender}"/></div>
          <div class="info-edit edit-mode" style="display: none;">
            <select name="gender" id="gender" required>
              <option value="Male" ${user.gender == 'Male' ? 'selected' : ''}>Male</option>
              <option value="Female" ${user.gender == 'Female' ? 'selected' : ''}>Female</option>
              <option value="Other" ${user.gender == 'Other' ? 'selected' : ''}>Other</option>
            </select>
            <div class="error-text" id="genderError"></div>
          </div>
        </div>

        <div class="info-item">
          <div class="info-label">Date of Birth:</div>
          <div class="info-value view-mode" id="dateOfBirthDisplay"><c:out value="${user.dateOfBirth}"/></div>
          <div class="info-edit edit-mode" style="display: none;">
            <input type="date" name="dateOfBirth" id="dateOfBirth" value="${user.dateOfBirth}">
            <div class="error-text" id="dateOfBirthError"></div>
          </div>
        </div>
      </div>

      <div class="info-column">
        <div class="info-heading">Contact Information</div>

        <div class="info-item">
          <div class="info-label">Email:</div>
          <div class="info-value view-mode" id="emailDisplay"><c:out value="${user.email}"/></div>
          <div class="info-edit edit-mode" style="display: none;">
            <input type="email" name="email" id="email" value="${user.email}" required>
            <div class="error-text" id="emailError"></div>
          </div>
        </div>

        <div class="info-item">
          <div class="info-label">Phone:</div>
          <div class="info-value view-mode" id="phoneDisplay"><c:out value="${user.phone}"/></div>
          <div class="info-edit edit-mode" style="display: none;">
            <input type="text" name="phone" id="phone" value="${user.phone}" required>
            <div class="error-text" id="phoneError"></div>
          </div>
        </div>

        <div class="info-item">
          <div class="info-label">Address:</div>
          <div class="info-value view-mode" id="addressDisplay"><c:out value="${user.address}"/></div>
          <div class="info-edit edit-mode" style="display: none;">
            <input type="text" name="address" id="address" value="${user.address}" required>
            <div class="error-text" id="addressError"></div>
          </div>
        </div>
      </div>
    </div>

    <div class="button-group">
      <button type="button" id="editProfileBtn" class="btn btn-edit">Edit Profile</button>
      <button type="submit" id="saveProfileBtn" class="btn btn-save" style="display: none;">Save Changes</button>
      <button type="button" id="cancelEditBtn" class="btn btn-cancel" style="display: none;">Cancel</button>
      <div class="spinner" id="spinner" style="display: none;">Saving...</div>
    </div>
  </form>
</div>

<script>
  document.addEventListener('DOMContentLoaded', () => {
    // Toggle profile menu on click for mobile devices
    const profile = document.querySelector('.profile');
    const profileImg = document.querySelector('.profile-img');
    if (profile && profileImg) {
      profileImg.addEventListener('click', () => {
        profile.classList.toggle('active');
      });
      document.addEventListener('click', (e) => {
        if (!profile.contains(e.target)) {
          profile.classList.remove('active');
        }
      });
    }

    // Profile form handling
    const editBtn = document.getElementById('editProfileBtn');
    const saveBtn = document.getElementById('saveProfileBtn');
    const cancelBtn = document.getElementById('cancelEditBtn');
    const profileForm = document.getElementById('profileForm');
    const spinner = document.getElementById('spinner');
    const messageContainer = document.getElementById('messageContainer');
    const viewElements = document.querySelectorAll('.view-mode');
    const editElements = document.querySelectorAll('.edit-mode');
    const profilePictureInput = document.getElementById('profilePicture');
    const imagePreview = document.getElementById('imagePreview');
    const previewImage = document.getElementById('previewImage');
    const profilePicDisplay = document.getElementById('profilePicDisplay');
    const profilePictureError = document.getElementById('profilePictureError');
    const fullNameInput = document.getElementById('fullName');
    const emailInput = document.getElementById('email');
    const phoneInput = document.getElementById('phone');
    const addressInput = document.getElementById('address');
    const genderInput = document.getElementById('gender');
    const dateOfBirthInput = document.getElementById('dateOfBirth');
    const fullNameError = document.getElementById('fullNameError');
    const emailError = document.getElementById('emailError');
    const phoneError = document.getElementById('phoneError');
    const addressError = document.getElementById('addressError');
    const genderError = document.getElementById('genderError');
    const dateOfBirthError = document.getElementById('dateOfBirthError');
    const userNameDisplay = document.getElementById('userName');
    const genderDisplay = document.getElementById('genderDisplay');
    const emailDisplay = document.getElementById('emailDisplay');
    const phoneDisplay = document.getElementById('phoneDisplay');
    const addressDisplay = document.getElementById('addressDisplay');
    const dateOfBirthDisplay = document.getElementById('dateOfBirthDisplay');

    if (!editBtn) {
      console.error('Edit Profile button not found');
      return;
    }

    const emailPattern = /^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$/;
    const phonePattern = /^(\+\d{1,3}\s?)?\(?\d{3}\)?[-.\s]?\d{3}[-.\s]?\d{4}$/;
    const datePattern = /^\d{4}-\d{2}-\d{2}$/;

    profilePictureInput.addEventListener('change', (e) => {
      profilePictureError.textContent = '';
      const file = e.target.files[0];
      if (file) {
        if (!['image/jpeg', 'image/png'].includes(file.type)) {
          profilePictureError.textContent = 'Only JPEG or PNG images are allowed.';
          e.target.value = '';
          imagePreview.style.display = 'none';
          return;
        }
        if (file.size > 10 * 1024 * 1024) {
          profilePictureError.textContent = 'File size must be less than 10MB.';
          e.target.value = '';
          imagePreview.style.display = 'none';
          return;
        }
        const reader = new FileReader();
        reader.onload = (event) => {
          previewImage.src = event.target.result;
          imagePreview.style.display = 'block';
        };
        reader.readAsDataURL(file);
      } else {
        imagePreview.style.display = 'none';
      }
    });

    editBtn.addEventListener('click', () => {
      viewElements.forEach(el => el.style.display = 'none');
      editElements.forEach(el => el.style.display = 'block');
      editBtn.style.display = 'none';
      saveBtn.style.display = 'inline-block';
      cancelBtn.style.display = 'inline-block';
    });

    cancelBtn.addEventListener('click', () => {
      viewElements.forEach(el => el.style.display = 'block');
      editElements.forEach(el => el.style.display = 'none');
      editBtn.style.display = 'inline-block';
      saveBtn.style.display = 'none';
      cancelBtn.style.display = 'none';
      profileForm.reset();
      profilePictureInput.value = '';
      imagePreview.style.display = 'none';
      profilePictureError.textContent = '';
      fullNameError.textContent = '';
      emailError.textContent = '';
      phoneError.textContent = '';
      addressError.textContent = '';
      genderError.textContent = '';
      dateOfBirthError.textContent = '';
    });

    profileForm.addEventListener('submit', async (e) => {
      e.preventDefault();
      messageContainer.innerHTML = '';

      let isValid = true;
      fullNameError.textContent = '';
      emailError.textContent = '';
      phoneError.textContent = '';
      addressError.textContent = '';
      genderError.textContent = '';
      dateOfBirthError.textContent = '';

      if (!fullNameInput.value.trim()) {
        fullNameError.textContent = 'Full name is required.';
        isValid = false;
      }

      if (!emailInput.value.trim()) {
        emailError.textContent = 'Email is required.';
        isValid = false;
      } else if (!emailPattern.test(emailInput.value.trim())) {
        emailError.textContent = 'Invalid email format.';
        isValid = false;
      }

      if (!phoneInput.value.trim()) {
        phoneError.textContent = 'Phone number is required.';
        isValid = false;
      } else if (!phonePattern.test(phoneInput.value.trim())) {
        phoneError.textContent = 'Invalid phone number format.';
        isValid = false;
      }

      if (!addressInput.value.trim()) {
        addressError.textContent = 'Address is required.';
        isValid = false;
      }

      if (!genderInput.value) {
        genderError.textContent = 'Gender is required.';
        isValid = false;
      }

      if (dateOfBirthInput.value && !datePattern.test(dateOfBirthInput.value)) {
        dateOfBirthError.textContent = 'Invalid date format (YYYY-MM-DD).';
        isValid = false;
      }

      if (!isValid) {
        return;
      }

      spinner.style.display = 'block';
      saveBtn.disabled = true;

      try {
        const formData = new FormData(profileForm);
        const response = await fetch('${pageContext.request.contextPath}/client/my-profile', {
          method: 'POST',
          body: formData,
          headers: {
            'X-Requested-With': 'XMLHttpRequest'
          }
        });

        const result = await response.json();
        spinner.style.display = 'none';
        saveBtn.disabled = false;

        const messageDiv = document.createElement('div');
        messageDiv.className = result.success ? 'success-message' : 'error-message';
        messageDiv.textContent = result.message;
        messageContainer.appendChild(messageDiv);

        if (result.success) {
          viewElements.forEach(el => el.style.display = 'block');
          editElements.forEach(el => el.style.display = 'none');
          editBtn.style.display = 'inline-block';
          saveBtn.style.display = 'none';
          cancelBtn.style.display = 'none';

          userNameDisplay.textContent = result.user.fullName;
          genderDisplay.textContent = result.user.gender;
          emailDisplay.textContent = result.user.email;
          phoneDisplay.textContent = result.user.phone;
          addressDisplay.textContent = result.user.address;
          dateOfBirthDisplay.textContent = result.user.dateOfBirth || '';

          // Fixed image update logic
          if (result.user.profileImage) {
            profilePicDisplay.src = '${pageContext.request.contextPath}/' + result.user.profileImage + '?v=' + new Date().getTime();
            document.querySelector('header .profile-img').src = '${pageContext.request.contextPath}/' + result.user.profileImage + '?v=' + new Date().getTime();
          } else {
            profilePicDisplay.src = '${pageContext.request.contextPath}/images/default-user.jpg';
            document.querySelector('header .profile-img').src = '${pageContext.request.contextPath}/images/default-user.jpg';
          }

          profileForm.reset();
          profilePictureInput.value = '';
          imagePreview.style.display = 'none';
        }
      } catch (error) {
        console.error('Form submission error:', error);
        spinner.style.display = 'none';
        saveBtn.disabled = false;
        const messageDiv = document.createElement('div');
        messageDiv.className = 'error-message';
        messageDiv.textContent = 'An error occurred while saving your profile.';
        messageContainer.appendChild(messageDiv);

        viewElements.forEach(el => el.style.display = 'block');
        editElements.forEach(el => el.style.display = 'none');
        editBtn.style.display = 'inline-block';
        saveBtn.style.display = 'none';
        cancelBtn.style.display = 'none';
      }
    });
  });
</script>
</body>
</html>