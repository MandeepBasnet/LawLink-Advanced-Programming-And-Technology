<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile - LawLink</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/lawyerStyle.css">
</head>
<body>
<jsp:include page="/WEB-INF/views/lawyer/common/header.jsp">
    <jsp:param name="pageTitle" value="My Profile"/>
</jsp:include>

<div class="main-container">
    <jsp:include page="/WEB-INF/views/lawyer/common/sidebar.jsp">
        <jsp:param name="pageTitle" value="My Profile"/>
    </jsp:include>

    <div class="main-content">
    <h1>My Profile</h1>

    <div id="messageContainer"></div>

    <form id="profileForm" enctype="multipart/form-data">
        <div class="profile-pic-container">
            <div class="info-heading">Profile Picture</div>
            <div class="profile-pic-wrapper view-mode">
                <img src="${pageContext.request.contextPath}/${not empty lawyer.profileImage ? lawyer.profileImage : 'images/default-user.jpg'}?v=${System.currentTimeMillis()}" alt="Profile Picture" class="profile-pic-large" id="profilePicDisplay">
                <label class="profile-pic-overlay" for="profilePicture">
                    <i class="fas fa-camera"></i> Change Photo
                </label>
            </div>
            <div class="profile-pic-edit edit-mode" style="display: none;">
                <input type="file" name="profilePicture" id="profilePicture" accept="image/jpeg,image/png">
                <p>Accepted formats: JPEG, PNG (Max size: 10MB)</p>
                <div class="image-preview" id="imagePreview" style="display: none;">
                    <img id="previewImage" alt="Image Preview" class="profile-pic-large">
                </div>
                <div class="error-text" id="profilePictureError"></div>
            </div>
        </div>

        <div class="info-item">
            <div class="info-label">Full Name:</div>
            <div class="info-value view-mode" id="userName"><c:out value="${lawyer.fullName}"/></div>
            <div class="info-edit edit-mode" style="display: none;">
                <input type="text" name="fullName" id="fullName" value="${lawyer.fullName}" required>
                <div class="error-text" id="fullNameError"></div>
            </div>
        </div>

        <div class="info-container">
            <div class="info-column">
                <div class="info-heading">Basic Information</div>

                <div class="info-item">
                    <div class="info-label">Username:</div>
                    <div class="info-value"><c:out value="${lawyer.username}"/></div>
                </div>

                <div class="info-item">
                    <div class="info-label">Gender:</div>
                    <div class="info-value view-mode" id="genderDisplay"><c:out value="${lawyer.gender}"/></div>
                    <div class="info-edit edit-mode" style="display: none;">
                        <select name="gender" id="gender" required>
                            <option value="Male" ${lawyer.gender == 'Male' ? 'selected' : ''}>Male</option>
                            <option value="Female" ${lawyer.gender == 'Female' ? 'selected' : ''}>Female</option>
                            <option value="Other" ${lawyer.gender == 'Other' ? 'selected' : ''}>Other</option>
                        </select>
                        <div class="error-text" id="genderError"></div>
                    </div>
                </div>

                <div class="info-item">
                    <div class="info-label">Date of Birth:</div>
                    <div class="info-value view-mode" id="dateOfBirthDisplay"><c:out value="${lawyer.dateOfBirth}"/></div>
                    <div class="info-edit edit-mode" style="display: none;">
                        <input type="date" name="dateOfBirth" id="dateOfBirth" value="${lawyer.dateOfBirth}">
                        <div class="error-text" id="dateOfBirthError"></div>
                    </div>
                </div>
            </div>

            <div class="info-column">
                <div class="info-heading">Contact Information</div>

                <div class="info-item">
                    <div class="info-label">Email:</div>
                    <div class="info-value view-mode" id="emailDisplay"><c:out value="${lawyer.email}"/></div>
                    <div class="info-edit edit-mode" style="display: none;">
                        <input type="email" name="email" id="email" value="${lawyer.email}" required>
                        <div class="error-text" id="emailError"></div>
                    </div>
                </div>

                <div class="info-item">
                    <div class="info-label">Phone:</div>
                    <div class="info-value view-mode" id="phoneDisplay"><c:out value="${lawyer.phone}"/></div>
                    <div class="info-edit edit-mode" style="display: none;">
                        <input type="text" name="phone" id="phone" value="${lawyer.phone}" required>
                        <div class="error-text" id="phoneError"></div>
                    </div>
                </div>

                <div class="info-item">
                    <div class="info-label">Address:</div>
                    <div class="info-value view-mode" id="addressDisplay"><c:out value="${lawyer.address}"/></div>
                    <div class="info-edit edit-mode" style="display: none;">
                        <input type="text" name="address" id="address" value="${lawyer.address}" required>
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
</div>

<script>
    document.addEventListener('DOMContentLoaded', () => {
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
                const response = await fetch('${pageContext.request.contextPath}/lawyer/lawyer-profile', {
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

                    userNameDisplay.textContent = result.lawyer.fullName;
                    genderDisplay.textContent = result.lawyer.gender;
                    emailDisplay.textContent = result.lawyer.email;
                    phoneDisplay.textContent = result.lawyer.phone;
                    addressDisplay.textContent = result.lawyer.address;
                    dateOfBirthDisplay.textContent = result.lawyer.dateOfBirth || '';

                    if (result.lawyer.profileImage) {
                        profilePicDisplay.src = '${pageContext.request.contextPath}/' + result.lawyer.profileImage + '?v=' + new Date().getTime();
                        document.querySelector('.user-avatar').src = '${pageContext.request.contextPath}/' + result.lawyer.profileImage + '?v=' + new Date().getTime();
                    } else {
                        profilePicDisplay.src = '${pageContext.request.contextPath}/images/default-user.jpg';
                        document.querySelector('.user-avatar').src = '${pageContext.request.contextPath}/images/default-user.jpg';
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