<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${todo != null ? 'Edit' : 'Add'} Todo | Todo Management App</title>

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
<jsp:include page="../common/header.jsp"></jsp:include>

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-lg-7 col-md-9">
            <div class="card shadow-lg">
                <div class="card-header bg-primary text-white p-3">
                    <h4 class="mb-0">
                        <c:choose>
                            <c:when test="${todo != null}">
                                <i class="fa-solid fa-edit me-2"></i> Edit Todo
                            </c:when>
                            <c:otherwise>
                                <i class="fa-solid fa-plus me-2"></i> Add New Todo
                            </c:otherwise>
                        </c:choose>
                    </h4>
                </div>
                <div class="card-body p-4">
                    <c:choose>
                    <c:when test="${todo != null}">
                        <form action="${pageContext.request.contextPath}/todos/update" method="post">
                        <input type="hidden" name="id" value="${todo.id}" />
                        </c:when>
                        <c:otherwise>
                            <form action="${pageContext.request.contextPath}/todos/insert" method="post">
                            </c:otherwise>
                            </c:choose>

                            <div class="mb-3">
                                <label for="title" class="form-label">Title <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="title" name="title"
                                       value="${todo != null ? todo.title : ''}"
                                       placeholder="Enter todo title" required minlength="3">
                            </div>

                            <div class="mb-3">
                                <label for="description" class="form-label">Description</label>
                                <textarea class="form-control" id="description" name="description"
                                          rows="3" placeholder="Enter todo description">${todo != null ? todo.description : ''}</textarea>
                            </div>

                            <div class="mb-3">
                                <label for="targetDate" class="form-label">Target Date <span class="text-danger">*</span></label>
                                <input type="date" class="form-control" id="targetDate" name="targetDate"
                                       value="${todo != null ? todo.targetDate : ''}" required>
                            </div>

                            <div class="mb-4">
                                <label for="isDone" class="form-label">Status</label>
                                <select class="form-select" id="isDone" name="isDone">
                                    <option value="false" ${todo != null && !todo.status ? 'selected' : ''}>
                                        In Progress
                                    </option>
                                    <option value="true" ${todo != null && todo.status ? 'selected' : ''}>
                                        Complete
                                    </option>
                                </select>
                            </div>

                            <div class="d-flex justify-content-between">
                                <a href="${pageContext.request.contextPath}/todos/list" class="btn btn-secondary">
                                    <i class="fa-solid fa-arrow-left me-2"></i>Cancel
                                </a>
                                <button type="submit" class="btn btn-primary">
                                    <c:choose>
                                        <c:when test="${todo != null}">
                                            <i class="fa-solid fa-save me-2"></i>Update
                                        </c:when>
                                        <c:otherwise>
                                            <i class="fa-solid fa-plus me-2"></i>Save
                                        </c:otherwise>
                                    </c:choose>
                                </button>
                            </div>
                        </form>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../common/footer.jsp"></jsp:include>

<!-- Initialize today's date if it's a new todo -->
<c:if test="${todo == null}">
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const today = new Date();
            const formattedDate = today.toISOString().substring(0, 10);
            document.getElementById('targetDate').value = formattedDate;
        });
    </script>
</c:if>
</body>
</html>