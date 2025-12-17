<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>

        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Messages - CollabBeats</title>
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

                .chat-list {
                    height: calc(100vh - 200px);
                    overflow-y: auto;
                    border-right: 1px solid #dee2e6;
                }

                .chat-window {
                    height: calc(100vh - 200px);
                    display: flex;
                    flex-direction: column;
                }

                .message-content {
                    overflow-y: auto;
                    flex-grow: 1;
                    padding: 1rem;
                }

                .chat-item {
                    cursor: pointer;
                    transition: background 0.2s;
                }

                .chat-item:hover,
                .chat-item.active {
                    background-color: #f8f9fa;
                }

                .message-bubble {
                    max-width: 70%;
                    padding: 0.75rem 1rem;
                    border-radius: 1rem;
                    margin-bottom: 0.5rem;
                }

                .message-sent {
                    background-color: #e94560;
                    color: white;
                    align-self: flex-end;
                    border-bottom-right-radius: 0.25rem;
                }

                .message-received {
                    background-color: #e9ecef;
                    color: #212529;
                    align-self: flex-start;
                    border-bottom-left-radius: 0.25rem;
                }
            </style>
        </head>

        <body>

            <!-- Sidebar -->
            <jsp:include page="includes/musician_sidebar.jsp" />

            <!-- Main Content -->
            <div class="main-content">
                <h2 class="fw-bold text-dark mb-4">Messages</h2>

                <div class="card border-0 shadow-sm" style="height: calc(100vh - 150px);">
                    <div class="row g-0 h-100">
                        <!-- Chat List -->
                        <div class="col-md-4 col-lg-3 chat-list">
                            <div class="p-3 border-bottom">
                                <input type="text" class="form-control" placeholder="Search messages...">
                            </div>
                            <div class="list-group list-group-flush">
                                <!-- Mock Chat Items -->
                                <a href="#"
                                    class="list-group-item list-group-item-action chat-item active border-0 p-3">
                                    <div class="d-flex align-items-center">
                                        <div class="avatar-sm bg-primary text-white rounded-circle d-flex align-items-center justify-content-center me-3"
                                            style="width:40px; height:40px;">JD</div>
                                        <div class="flex-grow-1 overflow-hidden">
                                            <div class="d-flex justify-content-between align-items-center">
                                                <h6 class="mb-0 fw-bold text-truncate">John Doe</h6>
                                                <small class="text-muted">12:30 PM</small>
                                            </div>
                                            <p class="mb-0 text-muted small text-truncate">Hey, did you check the new
                                                mix?</p>
                                        </div>
                                    </div>
                                </a>
                                <a href="#" class="list-group-item list-group-item-action chat-item border-0 p-3">
                                    <div class="d-flex align-items-center">
                                        <div class="avatar-sm bg-success text-white rounded-circle d-flex align-items-center justify-content-center me-3"
                                            style="width:40px; height:40px;">AS</div>
                                        <div class="flex-grow-1 overflow-hidden">
                                            <div class="d-flex justify-content-between align-items-center">
                                                <h6 class="mb-0 fw-bold text-truncate">Alice Smith</h6>
                                                <small class="text-muted">Yesterday</small>
                                            </div>
                                            <p class="mb-0 text-muted small text-truncate">Let's schedule a recording
                                                session.</p>
                                        </div>
                                    </div>
                                </a>
                            </div>
                        </div>

                        <!-- Chat Window -->
                        <div class="col-md-8 col-lg-9 chat-window">
                            <!-- Chat Header -->
                            <div class="p-3 border-bottom d-flex justify-content-between align-items-center bg-white">
                                <div class="d-flex align-items-center">
                                    <div class="avatar-sm bg-primary text-white rounded-circle d-flex align-items-center justify-content-center me-3"
                                        style="width:40px; height:40px;">JD</div>
                                    <div>
                                        <h6 class="mb-0 fw-bold">John Doe</h6>
                                        <small class="text-success"><i class="bi bi-circle-fill"
                                                style="font-size: 8px;"></i> Online</small>
                                    </div>
                                </div>
                                <button class="btn btn-light btn-sm"><i class="bi bi-three-dots-vertical"></i></button>
                            </div>

                            <!-- Messages -->
                            <div class="message-content d-flex flex-column bg-light">
                                <div class="message-bubble message-received">
                                    Hi! I just uploaded the v2 for the guitar track.
                                </div>
                                <div class="message-bubble message-received">
                                    Let me know what you think about the reverb.
                                </div>
                                <div class="message-bubble message-sent">
                                    Awesome! I'll check it out right now.
                                </div>
                                <div class="message-bubble message-sent">
                                    Just listened to it. The reverb is perfect!
                                </div>
                                <div class="message-bubble message-received">
                                    Great! Should we move to mixing?
                                </div>
                            </div>

                            <!-- Input Area -->
                            <div class="p-3 bg-white border-top">
                                <form class="d-flex gap-2">
                                    <button type="button" class="btn btn-light text-muted"><i
                                            class="bi bi-paperclip"></i></button>
                                    <input type="text" class="form-control" placeholder="Type a message...">
                                    <button type="submit" class="btn btn-primary"><i class="bi bi-send"></i></button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>