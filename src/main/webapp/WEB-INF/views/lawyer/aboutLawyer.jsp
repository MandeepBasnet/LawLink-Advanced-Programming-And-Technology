<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Lawyer - LawLink</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/lawyerStyle.css">
    <style>
        .profile-container {
            background-color: #f2f2f2;
            border-radius: 12px;
            padding: 30px;
            margin: 0 auto;
            display: flex;
            gap: 30px;
            flex-wrap: wrap;
        }

        .profile-image {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            border: 2px solid #fff;
            object-fit: cover;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            align-self: flex-start;
        }

        .content-blocks {
            flex: 1;
            display: flex;
            flex-direction: column;
            gap: 20px;
            min-width: 300px;
        }

        .info-block {
            background-color: #335791;
            border-radius: 8px;
            padding: 20px;
            color: #fff;
        }

        .info-block h2 {
            font-size: 20px;
            font-weight: 600;
            margin-bottom: 10px;
        }

        .info-block p {
            font-size: 14px;
            line-height: 1.5;
            color: #fff;
        }

        @media (max-width: 768px) {
            .profile-container {
                flex-direction: column;
                align-items: center;
                padding: 20px;
            }

            .profile-image {
                margin-bottom: 20px;
            }
        }
    </style>
</head>
<body>
<jsp:include page="common/header.jsp">
    <jsp:param name="pageTitle" value="About Lawyer" />
</jsp:include>

<div class="main-container">
    <jsp:include page="common/sidebar.jsp">
        <jsp:param name="activePage" value="about" />
    </jsp:include>

    <div class="main-content">
        <div class="profile-container">
            <img src="${pageContext.request.contextPath}/${lawyer.profileImage != null ? lawyer.profileImage : 'images/default-user.jpg'}?v=${System.currentTimeMillis()}" alt="Lawyer Profile" class="profile-image">

            <div class="content-blocks">
                <div class="info-block">
                    <h2>About Me</h2>
                    <p><c:out value="${lawyer.aboutMe}" default="Advocate Ram Prasad is a seasoned legal professional with over 10 years of experience in handling complex legal matters. Known for his clear communication and client-focused approach, he has built a reputation for delivering results with integrity and dedication. He believes in educating clients about their rights and walking them through every step of the legal process." /></p>
                </div>

                <div class="info-block">
                    <h2>Education</h2>
                    <p><c:out value="${lawyer.education}" default="Ram Prasad holds a Bachelor of Laws (LL.B.) from Tribhuvan University and a Master's in Constitutional Law. He has also completed various certifications on international legal frameworks and negotiation skills, which enhance his ability to serve clients across diverse sectors." /></p>
                </div>

                <div class="info-block">
                    <h2>Specialization</h2>
                    <p><c:out value="${lawyer.specialization}" default="Advocate Ram Prasad specializes in Property Law, Family Disputes, and Criminal Defense. His practice includes representing clients in property settlements, divorce proceedings, child custody cases, and criminal appeals, offering both strategic guidance and courtroom representation." /></p>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>