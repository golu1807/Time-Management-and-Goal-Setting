<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>

        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Notifications - CollabBeats</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/modern.css">
            <style>
                body {
                    background-color: #f4f6f9;
                }

                .main-content {
                    margin-left: 240px;
                    padding: 2rem;
                }

                .notification-item {
                    transition: background 0.2s;
                    cursor: pointer;
                }

                .notification-item:hover {
                    background-color: #f8f9fa;
                }

                .notification-item.unread {
                    background-color: #e7f3ff;
                    border-left: 3px solid #e94560;
                }
            </style>
        </head>

        <body>

            <!-- Sidebar -->
            <jsp:include page="includes/musician_sidebar.jsp" />

            <!-- Main Content -->
            <div class="main-content">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <div>
                        <h2 class="fw-bold text-dark">Notifications</h2>
                        <p class="text-muted">Stay updated with your musical journey</p>
                    </div>
                    <button class="btn btn-outline-secondary btn-sm">Mark All as Read</button>
                </div>

                <div class="row">
                    <div class="col-lg-8">
                        <div class="card border-0 shadow-sm">
                            <div class="card-body p-0">
                                <div class="list-group list-group-flush">
                                    <!-- New Comment -->
                                    <div class="list-group-item notification-item unread p-4">
                                        <div class="d-flex">
                                            <div class="me-3">
                                                <div class="avatar-sm bg-info text-white rounded-circle d-flex align-items-center justify-content-center"
                                                    style="width:48px; height:48px;">
                                                    <i class="bi bi-chat-text fs-5"></i>
                                                </div>
                                            </div>
                                            <div class="flex-grow-1">
                                                <h6 class="mb-1"><span class="fw-bold">John Doe</span> commented on your
                                                    track</h6>
                                                <p class="text-muted mb-2 small">"This mix is absolutely amazing! Love
                                                    the reverb on the vocals."</p>
                                                <small class="text-muted">5 minutes ago</small>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Collaboration Request -->
                                    <div class="list-group-item notification-item unread p-4">
                                        <div class="d-flex">
                                            <div class="me-3">
                                                <div class="avatar-sm bg-warning text-white rounded-circle d-flex align-items-center justify-content-center"
                                                    style="width:48px; height:48px;">
                                                    <i class="bi bi-people fs-5"></i>
                                                </div>
                                            </div>
                                            <div class="flex-grow-1">
                                                <h6 class="mb-1"><span class="fw-bold">Alice Smith</span> invited you to
                                                    collaborate</h6>
                                                <p class="text-muted mb-2 small">Project: "Summer Vibes Album"</p>
                                                <div class="d-flex gap-2">
                                                    <button class="btn btn-sm btn-primary">Accept</button>
                                                    <button class="btn btn-sm btn-outline-secondary">Decline</button>
                                                </div>
                                                <small class="text-muted d-block mt-2">1 hour ago</small>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Version Update -->
                                    <div class="list-group-item notification-item p-4">
                                        <div class="d-flex">
                                            <div class="me-3">
                                                <div class="avatar-sm bg-success text-white rounded-circle d-flex align-items-center justify-content-center"
                                                    style="width:48px; height:48px;">
                                                    <i class="bi bi-file-earmark-music fs-5"></i>
                                                </div>
                                            </div>
                                            <div class="flex-grow-1">
                                                <h6 class="mb-1">New file version uploaded</h6>
                                                <p class="text-muted mb-2 small"><span class="fw-bold">ProducerX</span>
                                                    uploaded v3 of "Guitar_Solo.wav"</p>
                                                <small class="text-muted">3 hours ago</small>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Feedback Request -->
                                    <div class="list-group-item notification-item p-4">
                                        <div class="d-flex">
                                            <div class="me-3">
                                                <div class="avatar-sm bg-danger text-white rounded-circle d-flex align-items-center justify-content-center"
                                                    style="width:48px; height:48px;">
                                                    <i class="bi bi-megaphone fs-5"></i>
                                                </div>
                                            </div>
                                            <div class="flex-grow-1">
                                                <h6 class="mb-1">Feedback requested on <span class="fw-bold">Rock
                                                        Anthem</span></h6>
                                                <p class="text-muted mb-2 small">"Please review the final mix and let me
                                                    know your thoughts."</p>
                                                <small class="text-muted">Yesterday</small>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- System Notification -->
                                    <div class="list-group-item notification-item p-4">
                                        <div class="d-flex">
                                            <div class="me-3">
                                                <div class="avatar-sm bg-secondary text-white rounded-circle d-flex align-items-center justify-content-center"
                                                    style="width:48px; height:48px;">
                                                    <i class="bi bi-bell fs-5"></i>
                                                </div>
                                            </div>
                                            <div class="flex-grow-1">
                                                <h6 class="mb-1">Your track has been approved</h6>
                                                <p class="text-muted mb-2 small">"Midnight City" is now live on the
                                                    platform!</p>
                                                <small class="text-muted">2 days ago</small>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Sidebar: Notification Settings -->
                    <div class="col-lg-4">
                        <div class="card border-0 shadow-sm">
                            <div class="card-header bg-white py-3">
                                <h6 class="mb-0 fw-bold">Notification Settings</h6>
                            </div>
                            <div class="card-body">
                                <div class="form-check form-switch mb-3">
                                    <input class="form-check-input" type="checkbox" id="emailNotif" checked>
                                    <label class="form-check-label" for="emailNotif">
                                        Email Notifications
                                    </label>
                                </div>
                                <div class="form-check form-switch mb-3">
                                    <input class="form-check-input" type="checkbox" id="commentNotif" checked>
                                    <label class="form-check-label" for="commentNotif">
                                        New Comments
                                    </label>
                                </div>
                                <div class="form-check form-switch mb-3">
                                    <input class="form-check-input" type="checkbox" id="collabNotif" checked>
                                    <label class="form-check-label" for="collabNotif">
                                        Collaboration Requests
                                    </label>
                                </div>
                                <div class="form-check form-switch mb-3">
                                    <input class="form-check-input" type="checkbox" id="versionNotif" checked>
                                    <label class="form-check-label" for="versionNotif">
                                        Version Updates
                                    </label>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
            <script>
                // Mark notification as read on click
                document.querySelectorAll('.notification-item').forEach(item => {
                    item.addEventListener('click', function () {
                        this.classList.remove('unread');
                    });
                });
            </script>
        </body>

        </html>