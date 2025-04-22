<jsp:include page="../includes/header.jsp">
    <jsp:param name="title" value="Access Denied" />
</jsp:include>

<div class="error-container">
    <div class="error-content">
        <h1>403</h1>
        <h2>Access Denied</h2>
        <p>You do not have permission to access this page.</p>
        <a href="${pageContext.request.contextPath}/" class="btn btn-primary">Go Home</a>
    </div>
</div>

<jsp:include page="../includes/footer.jsp" />
