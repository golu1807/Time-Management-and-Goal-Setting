<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>

        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>${project.title} - Project Details</title>
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

                .chat-box {
                    height: 400px;
                    overflow-y: auto;
                    background: #fff;
                    border: 1px solid #dee2e6;
                    border-radius: 8px;
                }

                .reaction-btn {
                    font-size: 1.2rem;
                    cursor: pointer;
                    opacity: 0.5;
                    transition: opacity 0.2s;
                }

                .reaction-btn:hover,
                .reaction-btn.active {
                    opacity: 1;
                }
            </style>
        </head>

        <body>

            <!-- Sidebar -->
            <jsp:include page="includes/musician_sidebar.jsp" />

            <!-- Main Content -->
            <div class="main-content">
                <!-- Header -->
                <div class="d-flex justify-content-between align-items-start mb-4">
                    <div>
                        <div class="d-flex align-items-center gap-2 mb-1">
                            <a href="${pageContext.request.contextPath}/projects" class="text-muted"><i
                                    class="bi bi-arrow-left"></i> Back</a>
                        </div>
                        <h2 class="fw-bold text-dark mb-0">${project.title}</h2>
                        <p class="text-muted mb-0">${project.description}</p>
                    </div>
                    <div class="text-end">
                        <button class="btn btn-outline-primary btn-sm mb-2" data-bs-toggle="modal"
                            data-bs-target="#requestFeedbackModal">
                            <i class="bi bi-megaphone"></i> Request Feedback
                        </button>
                        <div>
                            <span class="badge bg-primary mb-2">${project.status}</span>
                            <div class="text-muted small"><i class="bi bi-calendar"></i> Due: ${project.deadline}</div>
                        </div>
                    </div>
                </div>

                <div class="row g-4">
                    <!-- Left Column: Tasks & Files -->
                    <div class="col-lg-8">
                        <!-- Tabs -->
                        <ul class="nav nav-tabs mb-3" id="projectTabs" role="tablist">
                            <li class="nav-item" role="presentation">
                                <button class="nav-link active" id="tasks-tab" data-bs-toggle="tab"
                                    data-bs-target="#tasks" type="button" role="tab">Tasks</button>
                            </li>
                            <li class="nav-item" role="presentation">
                                <button class="nav-link" id="files-tab" data-bs-toggle="tab" data-bs-target="#files"
                                    type="button" role="tab">Files</button>
                            </li>
                        </ul>

                        <div class="tab-content" id="projectTabsContent">
                            <!-- Tasks Tab -->
                            <div class="tab-pane fade show active" id="tasks" role="tabpanel">
                                <div class="card border-0 shadow-sm">
                                    <div class="card-body">
                                        <div class="d-flex justify-content-between mb-3">
                                            <h5 class="fw-bold">Project Tasks</h5>
                                            <button class="btn btn-sm btn-outline-primary" data-bs-toggle="modal"
                                                data-bs-target="#addTaskModal">
                                                <i class="bi bi-plus"></i> Add Task
                                            </button>
                                        </div>
                                        <ul class="list-group list-group-flush">
                                            <c:forEach var="task" items="${tasks}">
                                                <li
                                                    class="list-group-item d-flex justify-content-between align-items-center px-0">
                                                    <div class="form-check">
                                                        <input class="form-check-input" type="checkbox"
                                                            ${task.status=='DONE' ? 'checked' : '' }>
                                                        <label
                                                            class="form-check-label ${task.status == 'DONE' ? 'text-decoration-line-through text-muted' : ''}">
                                                            ${task.title}
                                                        </label>
                                                    </div>
                                                    <span class="badge bg-light text-dark border">${task.status}</span>
                                                </li>
                                            </c:forEach>
                                            <c:if test="${empty tasks}">
                                                <li class="list-group-item text-center text-muted py-4">No tasks yet.
                                                </li>
                                            </c:if>
                                        </ul>
                                    </div>
                                </div>
                            </div>

                            <!-- Files Tab -->
                            <div class="tab-pane fade" id="files" role="tabpanel">
                                <div class="card border-0 shadow-sm">
                                    <div class="card-body">
                                        <div class="d-flex justify-content-between mb-3">
                                            <h5 class="fw-bold">Project Files</h5>
                                            <button class="btn btn-sm btn-outline-primary" data-bs-toggle="modal"
                                                data-bs-target="#uploadFileModal">
                                                <i class="bi bi-upload"></i> Upload File
                                            </button>
                                        </div>
                                        <div class="table-responsive">
                                            <table class="table align-middle">
                                                <thead>
                                                    <tr>
                                                        <th>Name</th>
                                                        <th>Uploaded By</th>
                                                        <th>Date</th>
                                                        <th>Actions</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="file" items="${files}">
                                                        <tr>
                                                            <td>
                                                                <div class="d-flex align-items-center">
                                                                    <button
                                                                        class="btn btn-sm btn-outline-primary me-2 play-btn"
                                                                        data-audio="${pageContext.request.contextPath}/${file.filePath}"
                                                                        data-name="${file.fileName}">
                                                                        <i class="bi bi-play-fill"></i>
                                                                    </button>
                                                                    <div>
                                                                        <div class="fw-bold">${file.fileName}</div>
                                                                        <small
                                                                            class="text-muted">v${file.versionNumber}</small>
                                                                    </div>
                                                                </div>
                                                            </td>
                                                            <td>User ${file.uploadedBy}</td>
                                                            <td>${file.uploadDate}</td>
                                                            <td>
                                                                <button class="btn btn-sm btn-light"
                                                                    data-bs-toggle="modal"
                                                                    data-bs-target="#shareModal"><i
                                                                        class="bi bi-share"></i></button>
                                                                <button class="btn btn-sm btn-light"><i
                                                                        class="bi bi-download"></i></button>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                    <c:if test="${empty files}">
                                                        <tr>
                                                            <td colspan="4" class="text-center text-muted py-4">No files
                                                                uploaded.</td>
                                                        </tr>
                                                    </c:if>
                                                </tbody>
                                            </table>
                                        </div>

                                        <!-- Waveform Player Container -->
                                        <div id="waveform-container" class="mt-4 p-4 bg-white rounded shadow-sm d-none">
                                            <div class="d-flex justify-content-between align-items-center mb-3">
                                                <h6 id="now-playing-title" class="fw-bold mb-0">Now Playing...</h6>
                                                <button class="btn btn-sm btn-light" id="btn-close-player"><i
                                                        class="bi bi-x-lg"></i></button>
                                            </div>
                                            <div id="waveform"></div>

                                            <!-- Controls -->
                                            <div class="row mt-3 align-items-center">
                                                <div class="col-md-6">
                                                    <div class="d-flex justify-content-center align-items-center gap-3">
                                                        <button class="btn btn-outline-secondary btn-sm"
                                                            id="btn-backward"><i
                                                                class="bi bi-skip-backward-fill"></i></button>
                                                        <button class="btn btn-primary rounded-circle"
                                                            id="btn-play-pause" style="width: 50px; height: 50px;"><i
                                                                class="bi bi-play-fill fs-4"></i></button>
                                                        <button class="btn btn-outline-secondary btn-sm"
                                                            id="btn-forward"><i
                                                                class="bi bi-skip-forward-fill"></i></button>
                                                    </div>
                                                    <div class="d-flex justify-content-between text-muted small mt-2">
                                                        <span id="current-time">0:00</span>
                                                        <span id="total-duration">0:00</span>
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="row g-2">
                                                        <div class="col-6">
                                                            <label class="form-label small mb-1"><i
                                                                    class="bi bi-volume-up"></i> Volume</label>
                                                            <input type="range" class="form-range" min="0" max="100"
                                                                value="80" id="volume-slider">
                                                        </div>
                                                        <div class="col-6">
                                                            <label class="form-label small mb-1"><i
                                                                    class="bi bi-speedometer"></i> Speed</label>
                                                            <select class="form-select form-select-sm"
                                                                id="speed-select">
                                                                <option value="0.5">0.5x</option>
                                                                <option value="0.75">0.75x</option>
                                                                <option value="1" selected>1x</option>
                                                                <option value="1.25">1.25x</option>
                                                                <option value="1.5">1.5x</option>
                                                                <option value="2">2x</option>
                                                            </select>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Right Column: Chat & Collaborators -->
                    <div class="col-lg-4">
                        <!-- Collaborators -->
                        <div class="card border-0 shadow-sm mb-4">
                            <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center">
                                <h6 class="mb-0 fw-bold">Collaborators</h6>
                                <span class="badge bg-success"><i class="bi bi-circle-fill" style="font-size: 8px;"></i>
                                    2 Online</span>
                            </div>
                            <div class="card-body">
                                <div class="d-flex align-items-center mb-3">
                                    <div class="avatar-sm bg-primary text-white rounded-circle d-flex align-items-center justify-content-center me-2"
                                        style="width:32px; height:32px;">O</div>
                                    <div class="flex-grow-1">
                                        <div class="fw-bold">Owner (You)</div>
                                        <small class="text-muted"><i class="bi bi-pencil text-warning"></i>
                                            Editing...</small>
                                    </div>
                                </div>
                                <button class="btn btn-sm btn-outline-secondary w-100"><i class="bi bi-person-plus"></i>
                                    Invite</button>
                            </div>
                        </div>

                        <!-- Chat -->
                        <div class="card border-0 shadow-sm h-100">
                            <div class="card-header bg-white py-3">
                                <h6 class="mb-0 fw-bold">Project Chat</h6>
                            </div>
                            <div class="card-body d-flex flex-column" style="height: 400px;">
                                <div class="flex-grow-1 overflow-auto mb-3 pe-2">
                                    <c:forEach var="comment" items="${comments}">
                                        <div class="mb-3">
                                            <div class="d-flex justify-content-between">
                                                <small class="fw-bold">User ${comment.userId}</small>
                                                <small class="text-muted"
                                                    style="font-size: 0.75rem;">${comment.createdAt}</small>
                                            </div>
                                            <div class="bg-light p-2 rounded mt-1">
                                                ${comment.content}
                                            </div>
                                            <div class="d-flex gap-2 mt-1">
                                                <span class="reaction-btn" title="Like">👍</span>
                                                <span class="reaction-btn" title="Love">❤️</span>
                                                <span class="reaction-btn" title="Fire">🔥</span>
                                                <span class="reaction-btn" title="Clap">👏</span>
                                            </div>
                                        </div>
                                    </c:forEach>
                                    <c:if test="${empty comments}">
                                        <div class="text-center text-muted mt-5">Start the conversation!</div>
                                    </c:if>
                                </div>
                                <form action="${pageContext.request.contextPath}/project/action" method="post"
                                    class="mt-auto">
                                    <input type="hidden" name="action" value="addComment">
                                    <input type="hidden" name="projectId" value="${project.id}">
                                    <div class="input-group">
                                        <input type="text" class="form-control" name="content"
                                            placeholder="Type a message..." required>
                                        <button class="btn btn-primary" type="submit"><i
                                                class="bi bi-send"></i></button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Request Feedback Modal -->
            <div class="modal fade" id="requestFeedbackModal" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Request Feedback</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body">
                            <p class="text-muted">Request feedback from your collaborators on this project.</p>
                            <div class="mb-3">
                                <label class="form-label">Message (Optional)</label>
                                <textarea class="form-control" rows="3"
                                    placeholder="Let them know what you need feedback on..."></textarea>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="notifyAll" checked>
                                <label class="form-check-label" for="notifyAll">
                                    Notify all collaborators
                                </label>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                            <button type="button" class="btn btn-primary" onclick="alert('Feedback request sent!')">Send
                                Request</button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Share Track Modal -->
            <div class="modal fade" id="shareModal" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Share Track</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body">
                            <div class="mb-3">
                                <label class="form-label">Search Users</label>
                                <input type="text" class="form-control" placeholder="Search by name or email...">
                            </div>
                            <div class="list-group mb-3">
                                <a href="#"
                                    class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                                    <div class="d-flex align-items-center">
                                        <div class="avatar-sm bg-success text-white rounded-circle me-2"
                                            style="width:32px; height:32px;">JD</div>
                                        <span>John Doe</span>
                                    </div>
                                    <button class="btn btn-sm btn-primary">Share</button>
                                </a>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Share Link</label>
                                <div class="input-group">
                                    <input type="text" class="form-control" value="https://collabbeats.com/track/12345"
                                        readonly>
                                    <button class="btn btn-outline-secondary" onclick="alert('Link copied!')"><i
                                            class="bi bi-clipboard"></i></button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Add Task Modal -->
            <div class="modal fade" id="addTaskModal" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Add New Task</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <form action="${pageContext.request.contextPath}/project/action" method="post">
                            <div class="modal-body">
                                <input type="hidden" name="action" value="addTask">
                                <input type="hidden" name="projectId" value="${project.id}">
                                <div class="mb-3">
                                    <label class="form-label">Task Title</label>
                                    <input type="text" class="form-control" name="title" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Description</label>
                                    <textarea class="form-control" name="description"></textarea>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Due Date</label>
                                    <input type="date" class="form-control" name="dueDate">
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                <button type="submit" class="btn btn-primary">Add Task</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <!-- Upload File Modal -->
            <div class="modal fade" id="uploadFileModal" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Upload File Version</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <form action="${pageContext.request.contextPath}/project/action" method="post"
                            enctype="multipart/form-data">
                            <div class="modal-body">
                                <input type="hidden" name="action" value="uploadFile">
                                <input type="hidden" name="projectId" value="${project.id}">
                                <div class="mb-3">
                                    <label class="form-label">Select File</label>
                                    <input type="file" class="form-control" name="file" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Version Description</label>
                                    <textarea class="form-control" name="description"
                                        placeholder="What changed in this version?"></textarea>
                                </div>
                                <div class="progress d-none" id="uploadProgress">
                                    <div class="progress-bar progress-bar-striped progress-bar-animated"
                                        role="progressbar" style="width: 0%"></div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                <button type="submit" class="btn btn-primary">Upload</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <script src="https://unpkg.com/wavesurfer.js@7"></script>
            <script>
                let wavesurfer;
                const container = document.getElementById('waveform-container');
                const playBtn = document.getElementById('btn-play-pause');
                const closeBtn = document.getElementById('btn-close-player');
                const titleDisplay = document.getElementById('now-playing-title');
                const currentTimeDisplay = document.getElementById('current-time');
                const totalDurationDisplay = document.getElementById('total-duration');
                const volumeSlider = document.getElementById('volume-slider');
                const speedSelect = document.getElementById('speed-select');

                document.querySelectorAll('.play-btn').forEach(btn => {
                    btn.addEventListener('click', () => {
                        const audioSrc = btn.getAttribute('data-audio');
                        const fileName = btn.getAttribute('data-name');

                        if (wavesurfer) {
                            wavesurfer.destroy();
                        }

                        container.classList.remove('d-none');
                        titleDisplay.innerText = "Now Playing: " + fileName;

                        wavesurfer = WaveSurfer.create({
                            container: '#waveform',
                            waveColor: '#adb5bd',
                            progressColor: '#e94560',
                            cursorColor: '#e94560',
                            barWidth: 2,
                            barRadius: 3,
                            responsive: true,
                            height: 60,
                        });

                        wavesurfer.load(audioSrc);

                        wavesurfer.on('ready', () => {
                            wavesurfer.play();
                            playBtn.innerHTML = '<i class="bi bi-pause-fill fs-4"></i>';
                            formatTime(totalDurationDisplay, wavesurfer.getDuration());
                            wavesurfer.setVolume(volumeSlider.value / 100);
                        });

                        wavesurfer.on('audioprocess', () => {
                            formatTime(currentTimeDisplay, wavesurfer.getCurrentTime());
                        });

                        wavesurfer.on('finish', () => {
                            playBtn.innerHTML = '<i class="bi bi-play-fill fs-4"></i>';
                        });
                    });
                });

                playBtn.addEventListener('click', () => {
                    if (wavesurfer) {
                        wavesurfer.playPause();
                        if (wavesurfer.isPlaying()) {
                            playBtn.innerHTML = '<i class="bi bi-pause-fill fs-4"></i>';
                        } else {
                            playBtn.innerHTML = '<i class="bi bi-play-fill fs-4"></i>';
                        }
                    }
                });

                closeBtn.addEventListener('click', () => {
                    if (wavesurfer) {
                        wavesurfer.pause();
                        container.classList.add('d-none');
                    }
                });

                volumeSlider.addEventListener('input', (e) => {
                    if (wavesurfer) {
                        wavesurfer.setVolume(e.target.value / 100);
                    }
                });

                speedSelect.addEventListener('change', (e) => {
                    if (wavesurfer) {
                        wavesurfer.setPlaybackRate(parseFloat(e.target.value));
                    }
                });

                function formatTime(element, time) {
                    const minutes = Math.floor(time / 60);
                    const seconds = Math.floor(time % 60);
                    element.innerText = minutes + ":" + (seconds < 10 ? "0" + seconds : seconds);
                }

                // Reaction emojis
                document.querySelectorAll('.reaction-btn').forEach(btn => {
                    btn.addEventListener('click', function () {
                        this.classList.toggle('active');
                    });
                });
            </script>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>