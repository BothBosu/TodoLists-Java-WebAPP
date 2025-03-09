<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isErrorPage="true" %>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error | Todo Management App</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
          rel="stylesheet"
          integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM"
          crossorigin="anonymous">

    <!-- Font Awesome -->
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"
          integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA=="
          crossorigin="anonymous"
          referrerpolicy="no-referrer">
</head>
<body class="d-flex flex-column min-vh-100">
<jsp:include page="/common/header.jsp"></jsp:include>

<div class="container py-5 text-center">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card shadow-lg border-danger">
                <div class="card-body py-5">
                    <i class="fa-solid fa-circle-exclamation text-danger mb-4" style="font-size: 4rem;"></i>
                    <h2 class="text-danger mb-4">Oops! Something went wrong</h2>

                    <c:choose>
                        <c:when test="${not empty errorMessage}">
                            <p class="lead mb-4">${errorMessage}</p>
                        </c:when>
                        <c:when test="${pageContext.exception != null}">
                            <p class="lead mb-4">${pageContext.exception.message}</p>
                        </c:when>
                        <c:otherwise>
                            <p class="lead mb-4">An unexpected error occurred. Please try again later.</p>
                        </c:otherwise>
                    </c:choose>

                    <div class="mt-4">
                        <a href="${pageContext.request.contextPath}/index" class="btn btn-primary btn-lg">
                            <i class="fa-solid fa-home me-2"></i>Go Home
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/common/footer.jsp"></jsp:include>
</body>
</html>