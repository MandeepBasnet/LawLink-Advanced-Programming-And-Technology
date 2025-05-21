```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile - LawLink</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/lawyerStyle.css">
</head>
<body>
<!-- Navigation Bar -->
<jsp:include page="common/header.jsp" />

<!-- Sidebar and Main Content -->
<div class="main-container">
    <jsp:include page="common/sidebar.jsp">
        <jsp:param name="activePage" value="profile" />
    </jsp:include>

    <!-- Main Content -->
    <div class="main-content">
        <div class="container">
            <h1>My Profile</h1>

            <!-- Success/Error Messages -->
            <div id="messageContainer">
                <c:if test="${not empty successMessage}">
                    <div class="success-message"><c:out value="${successMessage}"/></div>
                </c:if>
                <c:if test="${not empty errorMessage}">
                    <div class="error-message"><c:out value="${errorMessage}"/></div>
                </c:if>
            </div>

            <form id="profileForm" enctype="multipart/form-data">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td align="center" valign="top">
                            <div class="profile-picture-label">Profile Picture</div>
                            <div class="profile-pic-wrapper view-mode">
                                <img src="${pageContext.request.contextPath}/assets/images/${not empty lawyer.profileImage ? lawyer.profileImage : 'default.png'}" alt="Profile Picture" class="profile-picture" id="profilePicDisplay" style="width: 80px; height: 80px;">
                            </div>
                            <div class="profile-pic-edit edit-mode" style="display: none;">
                                <input type="file" name="profilePicture" id="profilePicture" accept="image/jpeg,image/png">
                                <p>Accepted formats: JPEG, PNG (Max size: 10MB)</p>
                                <div class="image-preview" id="imagePreview" style="display: none;">
                                    <img id="previewImage" alt="Image Preview" class="profile-pic-large" style="width: 80px; height: 80px;">
                                </div>
                                <div class="error-text" id="profilePictureError"></div>
                            </div>
                            <div class="profile-row view-mode" style="justify-content: center; margin-top: 10px;">
                                <div class="profile-value" id="userName" style="font-weight: bold;"><c:out value="${lawyer.fullName}"/></div>
                            </div>
                            <div class="info-edit edit-mode" style="display: none; text-align: center; margin-top: 10px;">
                                <input type="text" name="fullName" id="fullName" value="${lawyer.fullName}" required style="width: 200px; padding: 8px; border: 1px solid #ccc; border-radius: 4px;">
                                <div class="error-text" id="fullNameError"></div>
                            </div>
                        </td>
                    </tr>
                </table>

                <table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 20px; border-top: 1px solid #ddd;">
                    <tr>
                        <td width="50%" valign="top" style="padding-top: 15px; padding-right: 15px; border-right: 1px solid #ddd;">
                            <div class="column-heading">Basic Information</div>

                            <div class="profile-row" style="align-items: center;">
                                <div class="profile-label" style="font-weight: bold; width: 120px;">Username:</div>
                                <div class="info-value"><c:out value="${lawyer.username}" default="N/A" /></div>
                            </div>

                            <div class="profile-row" style="align-items: center;">
                                <div class="profile-label" style="font-weight: bold; width: 120px;">Gender:</div>
                                <div class="info-value view-mode" id="genderDisplay"><c:out value="${lawyer.gender}" default="N/A" /></div>
                                <div class="info-edit edit-mode" style="display: none;">
                                    <select name="gender" id="gender" required style="width: 100%; padding: 8px; border: 1px solid #ccc; border-radius: 4px;">
                                        <option value="Male" ${lawyer.gender == 'Male' ? 'selected' : ''}>Male</option>
                                        <option value="Female" ${lawyer.gender == 'Female' ? 'selected' : ''}>Female</option>
                                        <option value="Other" ${lawyer.gender == 'Other' ? 'selected' : ''}>Other</option>
                                    </select>
                                    <div class="error-text" id="genderError"></div>
                                </div>
                            </div>

                            <div class="profile-row" style="align-items: center;">
                                <div class="profile-label" style="font-weight: bold; width: 120px;">Date of Birth:</div>
                                <div class="info-value view-mode" id="dateOfBirthDisplay"><c:out value="${lawyer.dateOfBirth != null ? lawyer.dateOfBirth : 'N/A'}" /></div>
                                <div class="info-edit edit-mode" style="display: none;">
                                    <input type="date" name="dateOfBirth" id="dateOfBirth" value="${lawyer.dateOfBirth}" style="width: 100%; padding: 8px; border: 1px solid #ccc; border-radius: 4px;">
                                    <div class="error-text" id="dateOfBirthError"></div>
                                </div>
                            </div>
                        </td>

                        <td width="50%" valign="top" style="padding-top: 15px; padding-left: 15px;">
                            <div class="column-heading">Contact Information</div>

                            <div class="profile-row" style="align-items: center;">
                                <div class="profile-label" style="font-weight: bold; width: 120px;">Email:</div>
                                <div class="info-value view-mode" id="emailDisplay"><c:out value="${lawyer.email}" default="N/A" /></div>
                                <div class="info-edit edit-mode" style="display: none;">
                                    <input type="email" name="email" id="email" value="${lawyer.email}" required style="width: 100%; padding: 8px; border: 1px solid #ccc; border-radius: 4px;">
                                    <div class="error-text" id="emailError"></div>
                                </div>
                            </div>

                            <div class="profile-row" style="align-items: center;">
                                <div class="profile-label" style="font-weight: bold; width: 120px;">Phone:</div>
                                <div class="info-value view-mode" id="phoneDisplay"><c:out value="${lawyer.phone}" default="N/A" /></div>
                                <div class="info-edit edit-mode" style="display: none;">
                                    <input type="text" name="phone" id="phone" value="${lawyer.phone}" required style="width: 100%; padding: 8px; border: 1px solid #ccc; border-radius: 4px;">
                                    <div class="error-text" id="phoneError"></div>
                                </div>
                            </div>

                            <div class="profile-row" style="align-items: center;">
                                <div class="profile-label" style="font-weight: bold; width: 120px;">Address:</div>
                                <div class="info-value view-mode" id="addressDisplay"><c:out value="${lawyer.address}" default="N/A" /></div>
                                <div class="info-edit edit-mode" style="display: none;">
                                    <input type="text" name="address" id="address" value="${lawyer.address}" required style="width: 100%; padding: 8px; border: 1px solid #ccc; border-radius: 4px;">
                                    <div class="error-text" id="addressError"></div>
                                </div>
                            </div>
                        </td>
                    </tr>
                </table>

                <div class="button-group" style="margin-top: 20px;">
                    <button type="button" id="editProfileBtn" class="btn btn-edit">Edit Profile</button>
                    <button type="submit" id="saveProfileBtn" class="btn btn-save" style="display: none;">Save Changes</button>
                    <button type="button" id="cancelEditBtn" class="btn btn-cancel" style="display: none;">Cancel</button>
                    <a href="${pageContext.request.contextPath}/lawyer/change-password" class="btn btn-password">Change Password</a>
                    <div class="spinner" id="spinner" style="display: none;">Saving...</div>
                </div>
            </form>
        </div>
    </div>
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
            profilePictureError.textContent = '';

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
                const response = await fetch('${pageContext.request.contextPath}/lawyer/lawyer-profile', {
                    method: 'POST',
                    body: new FormData(profileForm),
                    headers: {
                        'X-Requested-With': 'XMLHttpRequest'
                    }
                });

                // Check if response is OK (status 200-299)
                if (!response.ok) {
                    throw new Error(`HTTP error! Status: ${response.status}`);
                }

                const result = await response.json();
                console.log('Server response:', result);
                spinner.style.display = 'none';
                saveBtn.disabled = false;

                const messageDiv = document.createElement('div');
                messageDiv.className = result.success ? 'success-message' : 'error-message';
                messageDiv.textContent = result.message;
                messageContainer.appendChild(messageDiv);

                if (result.success) {
                    // Update displayed values
                    userNameDisplay.textContent = result.lawyer.fullName;
                    genderDisplay.textContent = result.lawyer.gender;
                    emailDisplay.textContent = result.lawyer.email;
                    phoneDisplay.textContent = result.lawyer.phone;
                    addressDisplay.textContent = result.lawyer.address;
                    dateOfBirthDisplay.textContent = result.lawyer.dateOfBirth || 'N/A';
                    profilePicDisplay.src = result.lawyer.profileImage ? '${pageContext.request.contextPath}/assets/images/' + result.lawyer.profileImage : '${pageContext.request.contextPath}/assets/images/default.png';

                    document.querySelector('header .profile-img').src = profilePicDisplay.src;

                    // Reset form and UI
                    profileForm.reset();
                    profilePictureInput.value = '';
                    imagePreview.style.display = 'none';
                    viewElements.forEach(el => el.style.display = 'block');
                    editElements.forEach(el => el.style.display = 'none');
                    editBtn.style.display = 'inline-block';
                    saveBtn.style.display = 'none';
                    cancelBtn.style.display = 'none';

                    // Reload page after a short delay to ensure UI updates
                    setTimeout(() => {
                        window.location.reload();
                    }, 1500);
                }
            } catch (error) {
                console.error('Form submission error:', error);
                spinner.style.display = 'none';
                saveBtn.disabled = false;
                const messageDiv = document.createElement('div');
                messageDiv.className = 'error-message';
                messageDiv.textContent = 'An error occurred while saving your profile. Please try again.';
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
```