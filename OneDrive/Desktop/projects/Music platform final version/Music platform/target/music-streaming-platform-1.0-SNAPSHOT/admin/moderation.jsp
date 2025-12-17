<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>

        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Content Moderation - CollabBeats</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/modern.css">
            <style>
                body {
                    background-color: #f4f6f9;
                }

                .main-content {
                    margin-left: 280px;
                    padding: 2rem;
                }
            </style>
        </head>

        <body>

            <!-- Sidebar -->
            <jsp:include page="../includes/admin_sidebar.jsp" />

            <!-- Main Content -->
            <div class="main-content">
                <!-- Header -->
                <div class="mb-4">
                    <h2 class="fw-bold text-dark">Content Moderation</h2>
                    <p class="text-muted">Review and approve user-submitted content</p>
                </div>

                <!-- Filters -->
                <div class="card border-0 shadow-sm mb-4">
                    <div class="card-body">
                        <div class="row g-3">
                            <div class="col-md-4">
                                <div class="input-group">
                                    <span class="input-group-text bg-white"><i class="bi bi-search"></i></span>
                                    <input type="text" class="form-control border-start-0"
                                        placeholder="Search content...">
                                </div>
                            </div>
                            <div class="col-md-3">
                                <select class="form-select">
                                    <option selected>Status: Pending</option>
                                    <option value="approved">Approved</option>
                                    <option value="rejected">Rejected</option>
                                </select>
                            </div>
                            <div class="col-md-3">
                                <select class="form-select">
                                    <option selected>Type: All</option>
                                    <option value="music">Music Files</option>
                                    <option value="comments">Comments</option>
                                </select>
                            </div>
                            <div class="col-md-2">
                                <button class="btn btn-outline-secondary w-100">Apply</button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Content List -->
                <div class="card border-0 shadow-sm">
                    <div class="card-body p-0">
                        <div class="list-group list-group-flush">
                            <c:forEach var="song" items="${pendingMusic}">
                                <div class="list-group-item p-4 d-flex align-items-center justify-content-between">
                                    <div class="d-flex align-items-center">
                                        <div class="bg-light rounded p-3 me-3 text-center"
                                            style="width: 60px; height: 60px;">
                                            <i class="bi bi-music-note-beamed fs-4 text-primary"></i>
                                        </div>
                                        <div>
                                            <h5 class="mb-1 fw-bold">${song.title}</h5>
                                            <p class="mb-0 text-muted small">
                                                <i class="bi bi-person me-1"></i> ${song.artist} &bull;
                                                <i class="bi bi-calendar me-1"></i> Submitted today
                                            </p>
                                        </div>
                                    </div>
                                    <div class="d-flex align-items-center gap-2">
                                        <span class="badge bg-warning text-dark me-3">Pending</span>
                                        <form action="${pageContext.request.contextPath}/admin/action" method="post"
                                            style="display: inline;">
                                            <input type="hidden" name="action" value="approveMusic">
                                            <input type="hidden" name="id" value="${song.id}">
                                            <button type="submit" class="btn btn-success btn-sm px-3">
                                                <i class="bi bi-check-lg me-1"></i> Approve
                                            </button>
                                        </form>
                                        <form action="${pageContext.request.contextPath}/admin/action" method="post"
                                            style="display: inline;" onsubmit="return confirm('Reject this content?');">
                                            <input type="hidden" name="action" value="rejectMusic">
                                            <input type="hidden" name="id" value="${song.id}">
                                            <button type="submit" class="btn btn-outline-danger btn-sm px-3">
                                                <i class="bi bi-x-lg me-1"></i> Reject
                                            </button>
                                        </form>
                                    </div>
                                </div>
                            </c:forEach>
                            <c:if test="${empty pendingMusic}">
                                <div class="text-center py-5">
                                    <i class="bi bi-check-circle display-1 text-success opacity-25"></i>
                                    <p class="mt-3 text-muted">All caught up! No pending content.</p>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>