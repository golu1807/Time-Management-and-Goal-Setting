<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>

        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>My Portfolio - CollabBeats</title>
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

                .album-card {
                    transition: transform 0.2s;
                    border: none;
                    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
                }

                .album-card:hover {
                    transform: translateY(-5px);
                    box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
                }

                .album-cover {
                    height: 200px;
                    background-color: #eee;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    color: #aaa;
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
                        <h2 class="fw-bold text-dark">My Portfolio</h2>
                        <p class="text-muted">Manage your albums and songs</p>
                    </div>
                    <div>
                        <button class="btn btn-outline-primary me-2" data-bs-toggle="modal"
                            data-bs-target="#createAlbumModal">
                            <i class="bi bi-disc"></i> Add Album
                        </button>
                        <button class="btn btn-primary">
                            <i class="bi bi-music-note"></i> Add Song
                        </button>
                    </div>
                </div>

                <div class="row g-4">
                    <c:forEach var="album" items="${albums}">
                        <div class="col-md-6 col-lg-4 col-xl-3">
                            <div class="card album-card h-100">
                                <div class="album-cover card-img-top">
                                    <i class="bi bi-disc display-1"></i>
                                </div>
                                <div class="card-body">
                                    <h5 class="card-title fw-bold mb-1">${album.title}</h5>
                                    <p class="text-muted small mb-2">${album.releaseDate}</p>
                                    <div class="d-flex justify-content-between align-items-center mt-3">
                                        <form action="${pageContext.request.contextPath}/albums" method="post">
                                            <input type="hidden" name="action" value="togglePublic">
                                            <input type="hidden" name="id" value="${album.id}">
                                            <button type="submit"
                                                class="btn btn-sm ${album.public ? 'btn-success' : 'btn-secondary'} rounded-pill px-3">
                                                ${album.public ? 'Public' : 'Private'}
                                            </button>
                                        </form>
                                        <button class="btn btn-sm btn-light text-primary"><i class="bi bi-pencil"></i>
                                            Edit</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>

                    <c:if test="${empty albums}">
                        <div class="col-12 text-center py-5">
                            <div class="mb-3">
                                <i class="bi bi-music-note-list display-1 text-muted opacity-25"></i>
                            </div>
                            <h4 class="text-muted">No albums yet</h4>
                            <p class="text-muted mb-4">Create your first album to showcase your work.</p>
                            <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#createAlbumModal">
                                Create Album
                            </button>
                        </div>
                    </c:if>
                </div>
            </div>

            <!-- Create Album Modal -->
            <div class="modal fade" id="createAlbumModal" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Create New Album</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <form action="${pageContext.request.contextPath}/albums" method="post">
                            <div class="modal-body">
                                <input type="hidden" name="action" value="create">
                                <div class="mb-3">
                                    <label class="form-label">Album Title</label>
                                    <input type="text" class="form-control" name="title" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Description</label>
                                    <textarea class="form-control" name="description" rows="3"></textarea>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Release Date</label>
                                    <input type="date" class="form-control" name="releaseDate">
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                <button type="submit" class="btn btn-primary">Create Album</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>