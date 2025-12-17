<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>

        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Admin Dashboard - CollabBeats</title>
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

                .stat-card {
                    border: none;
                    border-radius: 10px;
                    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
                    transition: transform 0.2s;
                }

                .stat-card:hover {
                    transform: translateY(-5px);
                }

                .icon-box {
                    width: 48px;
                    height: 48px;
                    border-radius: 10px;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    font-size: 1.5rem;
                }
            </style>
        </head>

        <body>

            <!-- Sidebar -->
            <jsp:include page="includes/admin_sidebar.jsp" />

            <!-- Main Content -->
            <div class="main-content">
                <!-- Top Bar -->
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <div>
                        <h2 class="fw-bold text-dark">Admin Dashboard</h2>
                        <p class="text-muted">Welcome back, ${sessionScope.user.name}</p>
                    </div>
                    <div class="d-flex align-items-center gap-3">
                        <div class="input-group">
                            <span class="input-group-text bg-white border-end-0"><i class="bi bi-search"></i></span>
                            <input type="text" class="form-control border-start-0 ps-0" placeholder="Search...">
                        </div>
                        <button class="btn btn-light position-relative">
                            <i class="bi bi-bell"></i>
                            <span
                                class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
                                ${notifications.size()}
                            </span>
                        </button>
                    </div>
                </div>

                <!-- Stat Cards -->
                <div class="row g-4 mb-4">
                    <div class="col-md-3">
                        <div class="card stat-card bg-white">
                            <div class="card-body d-flex align-items-center">
                                <div class="icon-box bg-primary bg-opacity-10 text-primary me-3">
                                    <i class="bi bi-people"></i>
                                </div>
                                <div>
                                    <h6 class="text-muted mb-1">Total Users</h6>
                                    <h4 class="mb-0 fw-bold">${allUsers.size()}</h4>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card stat-card bg-white">
                            <div class="card-body d-flex align-items-center">
                                <div class="icon-box bg-success bg-opacity-10 text-success me-3">
                                    <i class="bi bi-music-note-beamed"></i>
                                </div>
                                <div>
                                    <h6 class="text-muted mb-1">Total Projects</h6>
                                    <h4 class="mb-0 fw-bold">12</h4> <!-- Placeholder -->
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card stat-card bg-white">
                            <div class="card-body d-flex align-items-center">
                                <div class="icon-box bg-warning bg-opacity-10 text-warning me-3">
                                    <i class="bi bi-hourglass-split"></i>
                                </div>
                                <div>
                                    <h6 class="text-muted mb-1">Pending Content</h6>
                                    <h4 class="mb-0 fw-bold">${pendingMusic.size()}</h4>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card stat-card bg-white">
                            <div class="card-body d-flex align-items-center">
                                <div class="icon-box bg-info bg-opacity-10 text-info me-3">
                                    <i class="bi bi-activity"></i>
                                </div>
                                <div>
                                    <h6 class="text-muted mb-1">System Status</h6>
                                    <h4 class="mb-0 fw-bold text-success">Healthy</h4>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Activity Monitoring & Shortcuts -->
                <div class="row g-4">
                    <!-- Recent Activity -->
                    <div class="col-md-8">
                        <div class="card border-0 shadow-sm rounded-3">
                            <div class="card-header bg-white border-0 py-3">
                                <h5 class="mb-0 fw-bold"><i class="bi bi-list-check me-2"></i>Recent Activity</h5>
                            </div>
                            <div class="card-body p-0">
                                <div class="list-group list-group-flush">
                                    <!-- Placeholder Activity Items -->
                                    <div class="list-group-item px-4 py-3 d-flex align-items-center">
                                        <div class="icon-box bg-light rounded-circle me-3"
                                            style="width: 40px; height: 40px;">
                                            <i class="bi bi-upload text-primary"></i>
                                        </div>
                                        <div class="flex-grow-1">
                                            <h6 class="mb-0">Artist One uploaded "Summer Vibes"</h6>
                                            <small class="text-muted">2 hours ago</small>
                                        </div>
                                    </div>
                                    <div class="list-group-item px-4 py-3 d-flex align-items-center">
                                        <div class="icon-box bg-light rounded-circle me-3"
                                            style="width: 40px; height: 40px;">
                                            <i class="bi bi-person-plus text-success"></i>
                                        </div>
                                        <div class="flex-grow-1">
                                            <h6 class="mb-0">New user "ProducerX" registered</h6>
                                            <small class="text-muted">5 hours ago</small>
                                        </div>
                                    </div>
                                    <div class="list-group-item px-4 py-3 d-flex align-items-center">
                                        <div class="icon-box bg-light rounded-circle me-3"
                                            style="width: 40px; height: 40px;">
                                            <i class="bi bi-gear text-secondary"></i>
                                        </div>
                                        <div class="flex-grow-1">
                                            <h6 class="mb-0">System settings updated</h6>
                                            <small class="text-muted">1 day ago</small>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Quick Actions -->
                    <div class="col-md-4">
                        <div class="card border-0 shadow-sm rounded-3">
                            <div class="card-header bg-white border-0 py-3">
                                <h5 class="mb-0 fw-bold">Quick Actions</h5>
                            </div>
                            <div class="card-body">
                                <div class="d-grid gap-3">
                                    <a href="${pageContext.request.contextPath}/admin/users.jsp"
                                        class="btn btn-outline-primary text-start p-3">
                                        <i class="bi bi-people me-2"></i> Manage Users
                                    </a>
                                    <a href="${pageContext.request.contextPath}/admin/moderation.jsp"
                                        class="btn btn-outline-warning text-start p-3">
                                        <i class="bi bi-shield-check me-2"></i> Moderate Content
                                    </a>
                                    <a href="${pageContext.request.contextPath}/admin/settings.jsp"
                                        class="btn btn-outline-secondary text-start p-3">
                                        <i class="bi bi-gear me-2"></i> System Settings
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>