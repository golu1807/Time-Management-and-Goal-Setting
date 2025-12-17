<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>

        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Projects - CollabBeats</title>
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

                .project-card {
                    transition: transform 0.2s;
                    border: none;
                    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
                }

                .project-card:hover {
                    transform: translateY(-5px);
                    box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
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
                        <h2 class="fw-bold text-dark">Projects</h2>
                        <p class="text-muted">Manage your music collaborations</p>
                    </div>
                    <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#createProjectModal">
                        <i class="bi bi-plus-lg"></i> New Project
                    </button>
                </div>

                <div class="row g-4">
                    <c:forEach var="project" items="${projects}">
                        <div class="col-md-6 col-lg-4">
                            <div class="card project-card h-100">
                                <div class="card-body d-flex flex-column">
                                    <div class="d-flex justify-content-between align-items-start mb-3">
                                        <h5 class="card-title fw-bold mb-0">${project.title}</h5>
                                        <span
                                            class="badge bg-primary bg-opacity-10 text-primary">${project.status}</span>
                                    </div>
                                    <p class="card-text text-muted flex-grow-1">${project.description}</p>

                                    <div class="mt-3 pt-3 border-top d-flex justify-content-between align-items-center">
                                        <div class="d-flex align-items-center text-muted small">
                                            <i class="bi bi-calendar me-1"></i> Due: ${project.deadline}
                                        </div>
                                        <a href="${pageContext.request.contextPath}/project/details?id=${project.id}"
                                            class="btn btn-sm btn-outline-primary">View Details</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>

                    <c:if test="${empty projects}">
                        <div class="col-12 text-center py-5">
                            <div class="mb-3">
                                <i class="bi bi-folder-plus display-1 text-muted opacity-25"></i>
                            </div>
                            <h4 class="text-muted">No projects yet</h4>
                            <p class="text-muted mb-4">Start collaborating by creating your first project.</p>
                            <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#createProjectModal">
                                Create Project
                            </button>
                        </div>
                    </c:if>
                </div>
            </div>

            <!-- Create Project Modal -->
            <div class="modal fade" id="createProjectModal" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Create New Project</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <form action="${pageContext.request.contextPath}/project/action" method="post">
                            <div class="modal-body">
                                <input type="hidden" name="action" value="create">
                                <div class="mb-3">
                                    <label class="form-label">Project Title</label>
                                    <input type="text" class="form-control" name="title" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Description</label>
                                    <textarea class="form-control" name="description" rows="3"></textarea>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Deadline</label>
                                    <input type="date" class="form-control" name="deadline">
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                <button type="submit" class="btn btn-primary">Create Project</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>