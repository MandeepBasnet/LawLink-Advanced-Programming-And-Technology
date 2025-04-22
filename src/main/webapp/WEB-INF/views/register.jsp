<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up Form</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }

        body {
            background-color: #e5e5e5;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        .container {
            display: flex;
            max-width: 1000px;
            width: 100%;
            overflow: hidden;
            border-radius: 20px;
        }

        .image-container {
            flex: 1;
            background-color: #e5e5e5;
            position: relative;
        }

        .image-container img {
            width: 100%;
            height: 100%;
            object-fit: contain;
        }

        .form-container {
            flex: 1;
            background-color: #9ca3af;
            padding: 40px;
            border-radius: 20px;
        }

        .form-content {
            max-width: 400px;
            margin: 0 auto;
        }

        h1 {
            font-size: 42px;
            text-align: center;
            margin-bottom: 10px;
            font-weight: bold;
        }

        .subtitle {
            text-align: center;
            margin-bottom: 30px;
            font-size: 16px;
        }

        .form-group {
            margin-bottom: 15px;
        }

        input {
            width: 100%;
            padding: 15px;
            border: none;
            border-radius: 8px;
            background-color: #d1d5db;
            font-size: 16px;
        }

        button {
            width: 100%;
            padding: 15px;
            border: none;
            border-radius: 8px;
            background-color: #d1d5db;
            font-size: 16px;
            cursor: pointer;
            margin-top: 5px;
            font-weight: 500;
        }

        button:hover {
            background-color: #c7cad1;
        }

        .login-section {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 25px;
        }

        .login-text {
            font-weight: 500;
        }

        .login-btn {
            background-color: #d1d5db;
            border-radius: 50px;
            padding: 10px 20px;
            width: auto;
        }

        @media (max-width: 768px) {
            .container {
                flex-direction: column;
            }

            .image-container {
                display: none;
            }

            .form-container {
                width: 100%;
                padding: 20px;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="image-container">
        <img src="${pageContext.request.contextPath}/assets/images/lady%20justice.jpg" alt="Lady Justice statue">
    </div>
    <div class="form-container">
        <div class="form-content">
            <h1>SIGN UP</h1>
            <p class="subtitle">Enter your Personal details to create your account</p>

            <form action="${pageContext.request.contextPath}/register" method="post">
                <div class="form-group">
                    <input type="text" name="fullName" placeholder="Full Name" required>
                </div>
                <div class="form-group">
                    <input type="text" name="userName" placeholder="User Name" required>
                </div>
                <div class="form-group">
                    <input type="email" name="email" placeholder="Email Address" required>
                </div>
                <div class="form-group">
                    <input type="password" name="password" placeholder="Password" required>
                </div>
                <div class="form-group">
                    <input type="password" name="confirmPassword" placeholder="Confirm Password" required>
                </div>
                <div class="form-group">
                    <input type="text" name="profilePicture" placeholder="Profile Picture">
                </div>
                <button type="submit">Create Account</button>
            </form>

            <div class="login-section">
                <span class="login-text">Already Have An Account?</span>
                <a href="${pageContext.request.contextPath}/log-in">
                    <button type="button" class="login-btn">LOG IN</button>
                </a>
            </div>
        </div>
    </div>
</div>
</body>
</html>