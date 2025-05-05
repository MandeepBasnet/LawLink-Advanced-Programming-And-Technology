<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lawyers - LawLink</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
</head>
<body>
<!-- Header Section -->
<jsp:include page="includes/header.jsp" />

<!-- Team Members Grid -->
<div class="team-container">
    <c:choose>
        <c:when test="${not empty lawyers}">
            <c:forEach var="lawyer" items="${lawyers}">
                <div class="team-member">
                    <img src="${pageContext.request.contextPath}/assets/images/${lawyer.profileImage}" alt="${lawyer.fullName}" onerror="this.src='${pageContext.request.contextPath}/assets/images/profile_pic.png'">
                    <div class="member-info">
                        <h2 class="member-name">${lawyer.fullName}</h2>
                        <p class="member-title">${lawyer.specialization}</p>
                        <div class="member-contact">
                            <p>Contact No.: ${lawyer.phone}</p>
                            <p>Email: ${lawyer.email}</p>
                        </div>
                        <div class="member-bio">
                            <p>${lawyer.aboutMe}</p>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <!-- Fallback hardcoded team members -->
            <div class="team-member">
                <img src="${pageContext.request.contextPath}/assets/images/jeniffer.png" alt="Jalira Puri">
                <div class="member-info">
                    <h2 class="member-name">Jalira Puri</h2>
                    <p class="member-title">Principal Senior Advisor</p>
                    <div class="member-contact">
                        <p>Contact No.: +977 9765432180</p>
                        <p>Email: jalira@lawfirm.com</p>
                    </div>
                    <div class="member-bio">
                        <p>Jalira is a Senior Advisor licensed by Nepal Bar Council. She is a seasoned litigator with decades of legal practice.</p>
                    </div>
                </div>
            </div>
            <div class="team-member">
                <img src="${pageContext.request.contextPath}/assets/images/ashutosh-srivastava.png" alt="Aashutosh Srivastava">
                <div class="member-info">
                    <h2 class="member-name">Aashutosh Srivastava</h2>
                    <p class="member-title">Advocate & Legal Advisor</p>
                    <div class="member-contact">
                        <p>Contact No.: +977 9823843129</p>
                        <p>Email: aashutosh@lawfirm.com</p>
                    </div>
                    <div class="member-bio">
                        <p>Advocate Aashutosh Srivastava is a distinguished legal professional practicing before the Supreme Court.</p>
                    </div>
                </div>
            </div>
            <div class="team-member">
                <img src="${pageContext.request.contextPath}/assets/images/yusha-shrestha.png" alt="Yusha Shrestha">
                <div class="member-info">
                    <h2 class="member-name">Yusha Shrestha</h2>
                    <p class="member-title">Legal Associate</p>
                    <div class="member-contact">
                        <p>Contact No.: +977 9765432181</p>
                        <p>Email: yusha@lawfirm.com</p>
                    </div>
                    <div class="member-bio">
                        <p>Yusha is a Junior Associate at the firm and is engaged in litigation.</p>
                    </div>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<jsp:include page="includes/footer.jsp" />

</body>
</html>