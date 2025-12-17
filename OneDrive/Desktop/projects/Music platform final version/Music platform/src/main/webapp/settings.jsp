<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>

        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Settings - CollabBeats</title>
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
            </style>
        </head>

        <body>

            <!-- Sidebar -->
            <jsp:include page="includes/musician_sidebar.jsp" />

            <!-- Main Content -->
            <div class="main-content">
                <h2 class="fw-bold text-dark mb-4">Settings</h2>

                <div class="row">
                    <div class="col-lg-8">
                        <!-- Profile Settings -->
                        <div class="card border-0 shadow-sm mb-4">
                            <div class="card-header bg-white py-3">
                                <h5 class="mb-0 fw-bold">Profile Settings</h5>
                            </div>
                            <div class="card-body p-4">
                                <div class="row g-3">
                                    <div class="col-md-6">
                                        <label class="form-label">Full Name</label>
                                        <input type="text" class="form-control" value="${sessionScope.user.name}">
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label">Email</label>
                                        <input type="email" class="form-control" value="${sessionScope.user.email}"
                                            readonly>
                                    </div>
                                    <div class="col-md-12">
                                        <label class="form-label">Bio</label>
                                        <textarea class="form-control" rows="3"
                                            placeholder="Tell us about yourself..."></textarea>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label">Genre Specialization</label>
                                        <select class="form-select">
                                            <option>Pop</option>
                                            <option>Rock</option>
                                            <option>Hip Hop</option>
                                            <option>Electronic</option>
                                            <option>Jazz</option>
                                        </select>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label">Years of Experience</label>
                                        <input type="number" class="form-control" placeholder="5">
                                    </div>
                                </div>
                                <div class="mt-4">
                                    <button class="btn btn-primary">Save Changes</button>
                                </div>
                            </div>
                        </div>

                        <!-- Privacy Settings -->
                        <div class="card border-0 shadow-sm mb-4">
                            <div class="card-header bg-white py-3">
                                <h5 class="mb-0 fw-bold">Privacy Settings</h5>
                            </div>
                            <div class="card-body p-4">
                                <div class="form-check form-switch mb-3">
                                    <input class="form-check-input" type="checkbox" id="publicProfile" checked>
                                    <label class="form-check-label" for="publicProfile">
                                        <strong>Public Profile</strong>
                                        <div class="text-muted small">Allow others to view your profile and portfolio
                                        </div>
                                    </label>
                                </div>
                                <div class="form-check form-switch mb-3">
                                    <input class="form-check-input" type="checkbox" id="showEmail">
                                    <label class="form-check-label" for="showEmail">
                                        <strong>Show Email</strong>
                                        <div class="text-muted small">Display email address on your public profile</div>
                                    </label>
                                </div>
                                <div class="form-check form-switch mb-3">
                                    <input class="form-check-input" type="checkbox" id="allowMessages" checked>
                                    <label class="form-check-label" for="allowMessages">
                                        <strong>Allow Direct Messages</strong>
                                        <div class="text-muted small">Let other musicians contact you directly</div>
                                    </label>
                                </div>
                            </div>
                        </div>

                        <!-- Account Settings -->
                        <div class="card border-0 shadow-sm">
                            <div class="card-header bg-white py-3">
                                <h5 class="mb-0 fw-bold">Account Settings</h5>
                            </div>
                            <div class="card-body p-4">
                                <div class="mb-3">
                                    <label class="form-label">Change Password</label>
                                    <button class="btn btn-outline-secondary btn-sm">Update Password</button>
                                </div>
                                <hr>
                                <div>
                                    <h6 class="text-danger">Danger Zone</h6>
                                    <p class="text-muted small">Once you delete your account, there is no going back.
                                    </p>
                                    <button class="btn btn-outline-danger btn-sm">Delete Account</button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Quick Info -->
                    <div class="col-lg-4">
                        <div class="card border-0 shadow-sm mb-4">
                            <div class="card-header bg-white py-3">
                                <h6 class="mb-0 fw-bold">Profile Badge</h6>
                            </div>
                            <div class="card-body text-center">
                                <div class="avatar-lg bg-primary text-white rounded-circle d-inline-flex align-items-center justify-content-center mb-3"
                                    style="width:80px; height:80px; font-size: 2rem;">
                                    ${sessionScope.user.name.substring(0,1)}
                                </div>
                                <h5 class="mb-1">${sessionScope.user.name}</h5>
                                <p class="text-muted small mb-3">${sessionScope.user.email}</p>
                                <div class="d-flex justify-content-center gap-2">
                                    <span class="badge bg-success">Verified Musician</span>
                                    <span class="badge bg-warning">Top Collaborator</span>
                                </div>
                            </div>
                        </div>

                        <div class="card border-0 shadow-sm">
                            <div class="card-header bg-white py-3">
                                <h6 class="mb-0 fw-bold">Quick Stats</h6>
                            </div>
                            <div class="card-body">
                                <div class="d-flex justify-content-between mb-2">
                                    <span class="text-muted">Projects</span>
                                    <span class="fw-bold">12</span>
                                </div>
                                <div class="d-flex justify-content-between mb-2">
                                    <span class="text-muted">Albums</span>
                                    <span class="fw-bold">5</span>
                                </div>
                                <div class="d-flex justify-content-between mb-2">
                                    <span class="text-muted">Collaborations</span>
                                    <span class="fw-bold">28</span>
                                </div>
                                <div class="d-flex justify-content-between">
                                    <span class="text-muted">Member Since</span>
                                    <span class="fw-bold">2024</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>