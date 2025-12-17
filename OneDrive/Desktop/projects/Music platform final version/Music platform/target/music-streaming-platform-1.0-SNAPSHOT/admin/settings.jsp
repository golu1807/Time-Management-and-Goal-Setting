<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>

        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>System Settings - CollabBeats</title>
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

                .setting-card {
                    margin-bottom: 2rem;
                }
            </style>
        </head>

        <body>

            <!-- Sidebar -->
            <jsp:include page="../includes/admin_sidebar.jsp" />

            <!-- Main Content -->
            <div class="main-content">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <div>
                        <h2 class="fw-bold text-dark">System Settings</h2>
                        <p class="text-muted">Configure global application preferences</p>
                    </div>
                    <div>
                        <button class="btn btn-outline-secondary me-2">Reset to Defaults</button>
                        <button class="btn btn-primary">Save Changes</button>
                    </div>
                </div>

                <!-- General Settings -->
                <div class="card border-0 shadow-sm setting-card">
                    <div class="card-header bg-white py-3">
                        <h5 class="mb-0 fw-bold"><i class="bi bi-sliders me-2"></i>General Settings</h5>
                    </div>
                    <div class="card-body">
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label class="form-label">Application Name</label>
                                <input type="text" class="form-control" value="CollabBeats">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Default Language</label>
                                <select class="form-select">
                                    <option selected>English (US)</option>
                                    <option>Spanish</option>
                                    <option>French</option>
                                </select>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Logo Upload</label>
                            <input type="file" class="form-control">
                        </div>
                    </div>
                </div>

                <!-- Music & File Settings -->
                <div class="card border-0 shadow-sm setting-card">
                    <div class="card-header bg-white py-3">
                        <h5 class="mb-0 fw-bold"><i class="bi bi-music-note-list me-2"></i>Music & File Settings</h5>
                    </div>
                    <div class="card-body">
                        <div class="mb-4">
                            <label class="form-label d-flex justify-content-between">
                                <span>Max File Size (MB)</span>
                                <span class="fw-bold text-primary">50 MB</span>
                            </label>
                            <input type="range" class="form-range" min="10" max="500" value="50">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Allowed File Formats</label>
                            <div class="d-flex gap-3">
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" value="" id="mp3" checked>
                                    <label class="form-check-label" for="mp3">MP3</label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" value="" id="wav" checked>
                                    <label class="form-check-label" for="wav">WAV</label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" value="" id="flac">
                                    <label class="form-check-label" for="flac">FLAC</label>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Access Controls -->
                <div class="card border-0 shadow-sm setting-card">
                    <div class="card-header bg-white py-3">
                        <h5 class="mb-0 fw-bold"><i class="bi bi-shield-lock me-2"></i>Access Controls</h5>
                    </div>
                    <div class="card-body">
                        <div class="form-check form-switch mb-3">
                            <input class="form-check-input" type="checkbox" id="projectCreation" checked>
                            <label class="form-check-label" for="projectCreation">Allow musicians to create
                                projects</label>
                        </div>
                        <div class="form-check form-switch mb-3">
                            <input class="form-check-input" type="checkbox" id="fileSharing">
                            <label class="form-check-label" for="fileSharing">Allow file sharing outside
                                projects</label>
                        </div>
                        <div class="form-check form-switch">
                            <input class="form-check-input" type="checkbox" id="contentApproval" checked>
                            <label class="form-check-label" for="contentApproval">Require approval for new
                                content</label>
                        </div>
                    </div>
                </div>
            </div>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>