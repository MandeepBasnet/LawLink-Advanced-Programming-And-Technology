<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Lawyer - LawLink</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/WEB-INF/views/lawyer/css/style.css">
</head>
<body>
    <jsp:include page="common/header.jsp" />
    
    <div class="main-container">
        <jsp:include page="common/sidebar.jsp">
            <jsp:param name="activePage" value="about" />
        </jsp:include>

        <div class="main-content">
            <div class="about-container">
                <div class="lawyer-profile">
                    <img src="${pageContext.request.contextPath}/assets/images/lawyer-profile.jpg" alt="Lawyer Profile" class="profile-avatar">
                </div>

                <div class="about-section">
                    <h2 class="section-title">About Me</h2>
                    <p class="about-content">
                        Advocate Ram Prasad is a seasoned legal professional with over 10 years of experience in handling complex legal matters. Known for his clear communication and client-focused approach, he has built a reputation for delivering results with integrity and dedication. He believes in educating clients about their rights and walking them through every step of the legal process.
                    </p>
                </div>

                <div class="about-section">
                    <h2 class="section-title">Education</h2>
                    <p class="about-content">
                        Ram Prasad holds a Bachelor of Laws (LL.B.) from Tribhuvan University and a Master's in Constitutional Law. He has also completed various certifications on international legal frameworks and negotiation skills, which enhance his ability to serve clients across diverse sectors.
                    </p>
                </div>

                <div class="about-section">
                    <h2 class="section-title">Specialization</h2>
                    <p class="about-content">
                        Advocate Ram Prasad specializes in Property Law, Family Disputes, and Criminal Defense. His practice includes representing clients in property settlements, divorce proceedings, child custody cases, and criminal appeals, offering both strategic guidance and courtroom representation.
                    </p>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
