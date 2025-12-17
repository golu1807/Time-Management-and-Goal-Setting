<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <title>Community Feed | Music Platform</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
            <link rel="stylesheet" href="assets/css/modern.css">
            <style>
                .feed-card {
                    background: rgba(255, 255, 255, 0.05);
                    border: 1px solid rgba(255, 255, 255, 0.1);
                    border-radius: 12px;
                    overflow: hidden;
                    transition: transform 0.2s;
                }

                .feed-card:hover {
                    transform: translateY(-5px);
                    background: rgba(255, 255, 255, 0.08);
                }

                .card-img-top {
                    height: 200px;
                    object-fit: cover;
                    background: #2a2a2a;
                }

                .play-overlay {
                    position: absolute;
                    top: 200px;
                    right: 20px;
                    transform: translateY(-50%);
                    width: 50px;
                    height: 50px;
                    background: var(--primary-color);
                    border-radius: 50%;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.3);
                    cursor: pointer;
                    transition: all 0.2s;
                }

                .play-overlay:hover {
                    transform: translateY(-50%) scale(1.1);
                }
            </style>
        </head>

        <body class="dark-mode">
            <nav class="navbar navbar-expand-lg fixed-top"
                style="background: rgba(18, 18, 18, 0.95); backdrop-filter: blur(10px);">
                <div class="container-fluid px-4">
                    <a class="navbar-brand text-white fw-bold" href="index.jsp"><i
                            class="bi bi-soundwave text-primary"></i> MusicPlatform</a>
                    <div class="d-flex text-white gap-3">
                        <a href="listenerDashboard.jsp" class="btn btn-outline-light btn-sm">Dashboard</a>
                    </div>
                </div>
            </nav>

            <div class="container" style="margin-top: 100px;">
                <h2 class="text-white mb-4">Community Feed</h2>

                <div class="row g-4">
                    <c:forEach items="${feedMusic}" var="music">
                        <div class="col-md-4 col-lg-3">
                            <div class="feed-card position-relative">
                                <!-- Placeholder Image - would require album art in DB -->
                                <div
                                    class="card-img-top d-flex align-items-center justify-content-center text-white-50">
                                    <i class="bi bi-music-note-beamed" style="font-size: 3rem;"></i>
                                </div>

                                <div class="play-overlay"
                                    onclick="playMusic('${music.filePath}', '${music.title}', '${music.artist}')">
                                    <i class="bi bi-play-fill text-dark fs-4"></i>
                                </div>

                                <div class="p-3">
                                    <h5 class="text-white text-truncate mb-1">${music.title}</h5>
                                    <p class="text-white-50 small mb-2">${music.artist}</p>
                                    <span class="badge bg-secondary bg-opacity-25 text-light">${music.genre}</span>
                                </div>
                            </div>
                        </div>
                    </c:forEach>

                    <c:if test="${empty feedMusic}">
                        <div class="col-12 text-center py-5">
                            <p class="text-muted">No shared music found yet. Be the first to upload!</p>
                            <a href="upload.jsp" class="btn btn-primary rounded-pill mt-3">Upload Now</a>
                        </div>
                    </c:if>
                </div>
            </div>

            <script>
                // Simple mock player integration
                function playMusic(path, title, artist) {
                    console.log("Playing:", title, path);
                    // Ideally dispatch event to a global player or open player modal
                    alert("Now Playing: " + title + " by " + artist + "\n(Path: " + path + ")");
                }
            </script>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>