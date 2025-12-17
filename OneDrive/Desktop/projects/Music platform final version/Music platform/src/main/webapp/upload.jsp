<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Upload Track | Music Platform</title>
            <!-- Bootstrap 5 CSS -->
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <!-- Bootstrap Icons -->
            <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
            <!-- Google Fonts -->
            <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700&display=swap"
                rel="stylesheet">
            <!-- Custom CSS -->
            <link rel="stylesheet" href="assets/css/modern.css">
            <style>
                .upload-zone {
                    border: 2px dashed rgba(255, 255, 255, 0.2);
                    border-radius: 16px;
                    padding: 4rem 2rem;
                    text-align: center;
                    transition: all 0.3s ease;
                    background: rgba(255, 255, 255, 0.02);
                    cursor: pointer;
                }

                .upload-zone:hover,
                .upload-zone.dragover {
                    border-color: var(--primary-color);
                    background: rgba(0, 212, 255, 0.05);
                }

                .upload-icon {
                    font-size: 3rem;
                    color: var(--text-secondary);
                    margin-bottom: 1rem;
                }

                .form-label {
                    color: var(--text-secondary);
                    margin-bottom: 0.5rem;
                }

                .form-control,
                .form-select {
                    background: rgba(255, 255, 255, 0.05);
                    border: 1px solid rgba(255, 255, 255, 0.1);
                    color: var(--text-primary);
                    border-radius: 8px;
                    padding: 0.75rem 1rem;
                }

                .form-control:focus,
                .form-select:focus {
                    background: rgba(255, 255, 255, 0.1);
                    border-color: var(--primary-color);
                    color: var(--text-primary);
                    box-shadow: none;
                }
            </style>
        </head>

        <body class="dark-mode">

            <!-- Top Navigation -->
            <nav class="navbar navbar-expand-lg fixed-top"
                style="background: rgba(18, 18, 18, 0.95); backdrop-filter: blur(10px); border-bottom: 1px solid rgba(255,255,255,0.05);">
                <div class="container-fluid px-4">
                    <a class="navbar-brand d-flex align-items-center gap-2" href="index.jsp">
                        <div class="brand-icon">
                            <i class="bi bi-soundwave"></i>
                        </div>
                        <span class="fw-bold"
                            style="background: linear-gradient(45deg, #fff, #aaa); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">MusicPlatform</span>
                    </a>

                    <div class="d-flex align-items-center gap-3">
                        <a href="artistDashboard.jsp" class="btn btn-outline-light btn-sm">Back to Dashboard</a>
                    </div>
                </div>
            </nav>

            <div class="container" style="margin-top: 100px; max-width: 800px;">
                <div class="row">
                    <div class="col-12 text-center mb-5">
                        <h1 class="display-6 fw-bold text-white">Upload New Track</h1>
                        <p class="text-secondary">Share your latest creation with the world.</p>
                    </div>
                </div>

                <div class="glass-card p-4 p-md-5">
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger mb-4">${error}</div>
                    </c:if>

                    <form action="uploadTrack" method="post" enctype="multipart/form-data" id="uploadForm">

                        <!-- Drag & Drop Zone -->
                        <div class="upload-zone mb-4" id="dropZone">
                            <i class="bi bi-cloud-arrow-up upload-icon"></i>
                            <h5 class="text-white mb-2">Drag and drop your audio file here</h5>
                            <p class="text-secondary small mb-3">or click to browse files</p>
                            <input type="file" name="file" id="fileInput" accept="audio/*" class="d-none" required>
                            <button type="button" class="btn btn-outline-primary rounded-pill px-4"
                                onclick="document.getElementById('fileInput').click()">Browse Files</button>
                            <div id="fileName" class="mt-3 text-success fw-bold"></div>
                        </div>

                        <!-- Metadata -->
                        <div class="row g-4">
                            <div class="col-md-12">
                                <label for="title" class="form-label">Track Title</label>
                                <input type="text" class="form-control" id="title" name="title"
                                    placeholder="e.g. Midnight City" required>
                            </div>

                            <div class="col-md-6">
                                <label for="genre" class="form-label">Genre</label>
                                <select class="form-select" id="genre" name="genre" required>
                                    <option value="" selected disabled>Select Genre</option>
                                    <option value="Pop">Pop</option>
                                    <option value="Rock">Rock</option>
                                    <option value="Hip Hop">Hip Hop</option>
                                    <option value="Electronic">Electronic</option>
                                    <option value="Jazz">Jazz</option>
                                    <option value="Classical">Classical</option>
                                </select>
                            </div>

                            <div class="col-md-6">
                                <label for="album" class="form-label">Album (Optional)</label>
                                <input type="text" class="form-control" id="album" name="album"
                                    placeholder="e.g. Summer Vibes">
                            </div>

                            <div class="col-12">
                                <label for="description" class="form-label">Description</label>
                                <textarea class="form-control" id="description" name="description" rows="3"
                                    placeholder="Tell us about this track..."></textarea>
                            </div>
                        </div>

                        <div class="mt-5 text-end">
                            <button type="submit" class="btn btn-primary btn-lg rounded-pill px-5">
                                <i class="bi bi-upload me-2"></i> Upload Track
                            </button>
                        </div>
                    </form>
                </div>
            </div>

            <script>
                // Simple Drag & Drop Logic
                const dropZone = document.getElementById('dropZone');
                const fileInput = document.getElementById('fileInput');
                const fileName = document.getElementById('fileName');

                ['dragenter', 'dragover', 'dragleave', 'drop'].forEach(eventName => {
                    dropZone.addEventListener(eventName, preventDefaults, false);
                });

                function preventDefaults(e) {
                    e.preventDefault();
                    e.stopPropagation();
                }

                ['dragenter', 'dragover'].forEach(eventName => {
                    dropZone.addEventListener(eventName, highlight, false);
                });

                ['dragleave', 'drop'].forEach(eventName => {
                    dropZone.addEventListener(eventName, unhighlight, false);
                });

                function highlight(e) {
                    dropZone.classList.add('dragover');
                }

                function unhighlight(e) {
                    dropZone.classList.remove('dragover');
                }

                dropZone.addEventListener('drop', handleDrop, false);

                function handleDrop(e) {
                    const dt = e.dataTransfer;
                    const files = dt.files;
                    fileInput.files = files;
                    updateFileName();
                }

                fileInput.addEventListener('change', updateFileName);

                function updateFileName() {
                    if (fileInput.files.length > 0) {
                        fileName.innerText = fileInput.files[0].name;
                        // Add simple validation or waveform preview init here
                    }
                }
            </script>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>