<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>

        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Audio Player - CollabBeats</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
            <style>
                body {
                    background: linear-gradient(135deg, #1a1a2e 0%, #16213e 100%);
                    color: #fff;
                    min-height: 100vh;
                    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                }

                .player-container {
                    max-width: 1200px;
                    margin: 2rem auto;
                    padding: 2rem;
                }

                .player-card {
                    background: rgba(26, 26, 46, 0.8);
                    backdrop-filter: blur(20px);
                    border-radius: 30px;
                    padding: 2rem;
                    box-shadow: 0 0 60px rgba(233, 69, 96, 0.3);
                    border: 1px solid rgba(233, 69, 96, 0.2);
                }

                .album-thumb {
                    width: 200px;
                    height: 200px;
                    border-radius: 20px;
                    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    font-size: 4rem;
                    color: white;
                    box-shadow: 0 10px 40px rgba(102, 126, 234, 0.4);
                }

                .track-info h3 {
                    font-weight: 700;
                    margin-bottom: 0.5rem;
                    color: #fff;
                }

                .track-info .artist {
                    color: #e94560;
                    font-size: 1.1rem;
                }

                #waveform {
                    margin: 2rem 0;
                    border-radius: 10px;
                    overflow: hidden;
                }

                .controls {
                    display: flex;
                    justify-content: center;
                    align-items: center;
                    gap: 1.5rem;
                    margin: 2rem 0;
                }

                .btn-control {
                    background: transparent;
                    border: 2px solid #e94560;
                    color: #e94560;
                    width: 50px;
                    height: 50px;
                    border-radius: 50%;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    transition: all 0.3s;
                    cursor: pointer;
                }

                .btn-control:hover {
                    background: #e94560;
                    color: white;
                    box-shadow: 0 0 20px rgba(233, 69, 96, 0.6);
                    transform: scale(1.1);
                }

                .btn-play {
                    width: 80px;
                    height: 80px;
                    background: linear-gradient(135deg, #e94560 0%, #ff6b9d 100%);
                    border: none;
                    color: white;
                    box-shadow: 0 0 30px rgba(233, 69, 96, 0.8);
                    animation: pulse 2s infinite;
                }

                @keyframes pulse {

                    0%,
                    100% {
                        box-shadow: 0 0 30px rgba(233, 69, 96, 0.8);
                    }

                    50% {
                        box-shadow: 0 0 50px rgba(233, 69, 96, 1);
                    }
                }

                .btn-play:hover {
                    transform: scale(1.1);
                    background: linear-gradient(135deg, #ff6b9d 0%, #e94560 100%);
                }

                .volume-control {
                    display: flex;
                    align-items: center;
                    gap: 1rem;
                }

                .slider {
                    width: 150px;
                    height: 6px;
                    border-radius: 3px;
                    background: rgba(255, 255, 255, 0.1);
                    outline: none;
                    -webkit-appearance: none;
                }

                .slider::-webkit-slider-thumb {
                    -webkit-appearance: none;
                    width: 16px;
                    height: 16px;
                    border-radius: 50%;
                    background: #e94560;
                    cursor: pointer;
                    box-shadow: 0 0 10px rgba(233, 69, 96, 0.8);
                }

                .speed-selector {
                    background: rgba(233, 69, 96, 0.1);
                    border: 2px solid #e94560;
                    color: #e94560;
                    padding: 0.5rem 1rem;
                    border-radius: 20px;
                    font-weight: 600;
                    transition: all 0.3s;
                }

                .speed-selector:hover,
                .speed-selector:focus {
                    background: #e94560;
                    color: white;
                    box-shadow: 0 0 15px rgba(233, 69, 96, 0.6);
                }

                .comment-section {
                    background: rgba(22, 33, 62, 0.6);
                    border-radius: 20px;
                    padding: 1.5rem;
                    margin-top: 2rem;
                    border: 1px solid rgba(233, 69, 96, 0.1);
                }

                .comment-input {
                    background: rgba(255, 255, 255, 0.05);
                    border: 2px solid rgba(233, 69, 96, 0.3);
                    color: white;
                    border-radius: 15px;
                    padding: 0.75rem;
                    width: 100%;
                    transition: all 0.3s;
                }

                .comment-input:focus {
                    background: rgba(255, 255, 255, 0.1);
                    border-color: #e94560;
                    box-shadow: 0 0 15px rgba(233, 69, 96, 0.3);
                    outline: none;
                }

                .comment-item {
                    background: rgba(255, 255, 255, 0.03);
                    border-left: 3px solid #e94560;
                    padding: 1rem;
                    border-radius: 10px;
                    margin-bottom: 0.75rem;
                }

                .timestamp-badge {
                    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                    color: white;
                    padding: 0.25rem 0.75rem;
                    border-radius: 15px;
                    font-size: 0.75rem;
                    font-weight: 600;
                    cursor: pointer;
                    transition: all 0.3s;
                }

                .timestamp-badge:hover {
                    transform: scale(1.05);
                    box-shadow: 0 0 10px rgba(102, 126, 234, 0.6);
                }

                .playlist-item {
                    background: rgba(255, 255, 255, 0.03);
                    border-radius: 10px;
                    padding: 0.75rem;
                    margin-bottom: 0.5rem;
                    cursor: pointer;
                    transition: all 0.3s;
                    border-left: 3px solid transparent;
                }

                .playlist-item:hover,
                .playlist-item.active {
                    background: rgba(233, 69, 96, 0.1);
                    border-left-color: #e94560;
                }

                .neon-text {
                    color: #e94560;
                    text-shadow: 0 0 10px rgba(233, 69, 96, 0.8);
                }
            </style>
        </head>

        <body>

            <div class="player-container">
                <!-- Header -->
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2 class="fw-bold neon-text">Now Playing</h2>
                    <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-outline-light">
                        <i class="bi bi-arrow-left me-2"></i> Back to Dashboard
                    </a>
                </div>

                <div class="row g-4">
                    <!-- Main Player -->
                    <div class="col-lg-8">
                        <div class="player-card">
                            <!-- Track Header -->
                            <div class="d-flex align-items-start gap-3 mb-4">
                                <div class="album-thumb">
                                    <i class="bi bi-music-note-beamed"></i>
                                </div>
                                <div class="track-info flex-grow-1">
                                    <h3>Summer Vibes Demo</h3>
                                    <p class="artist mb-2">Uploaded by John Doe</p>
                                    <div class="d-flex gap-2">
                                        <span class="badge bg-primary">Pop</span>
                                        <span class="badge bg-success">120 BPM</span>
                                        <span class="badge bg-warning text-dark">v3</span>
                                    </div>
                                </div>
                            </div>

                            <!-- Waveform -->
                            <div id="waveform"></div>

                            <!-- Timeline -->
                            <div class="d-flex justify-content-between text-white-50 small mb-3">
                                <span id="current-time">0:00</span>
                                <span id="total-duration">0:00</span>
                            </div>

                            <!-- Controls -->
                            <div class="controls">
                                <button class="btn-control" id="btn-previous">
                                    <i class="bi bi-skip-backward-fill"></i>
                                </button>
                                <button class="btn-control btn-play" id="btn-play">
                                    <i class="bi bi-play-fill fs-3"></i>
                                </button>
                                <button class="btn-control" id="btn-next">
                                    <i class="bi bi-skip-forward-fill"></i>
                                </button>
                            </div>

                            <!-- Additional Controls -->
                            <div class="row mt-4 align-items-center">
                                <div class="col-md-4">
                                    <div class="volume-control">
                                        <i class="bi bi-volume-up text-white-50"></i>
                                        <input type="range" class="slider" id="volume-slider" min="0" max="100"
                                            value="80">
                                    </div>
                                </div>
                                <div class="col-md-4 text-center">
                                    <select class="speed-selector" id="speed-select">
                                        <option value="0.5">0.5x</option>
                                        <option value="0.75">0.75x</option>
                                        <option value="1" selected>1x</option>
                                        <option value="1.25">1.25x</option>
                                        <option value="1.5">1.5x</option>
                                        <option value="2">2x</option>
                                    </select>
                                </div>
                                <div class="col-md-4 text-end">
                                    <button class="btn btn-outline-light btn-sm" data-bs-toggle="modal"
                                        data-bs-target="#shareModal">
                                        <i class="bi bi-share me-2"></i> Share
                                    </button>
                                </div>
                            </div>

                            <!-- Comment at Timestamp -->
                            <div class="comment-section">
                                <h6 class="fw-bold mb-3">
                                    <i class="bi bi-chat-left-text me-2 neon-text"></i> Add Comment at Timestamp
                                </h6>
                                <div class="input-group">
                                    <input type="text" class="comment-input" id="comment-input"
                                        placeholder="Type your comment...">
                                    <button class="btn btn-outline-light ms-2" onclick="addComment()">
                                        <i class="bi bi-send"></i>
                                    </button>
                                </div>
                                <small class="text-white-50 d-block mt-2">
                                    <i class="bi bi-info-circle me-1"></i> Comments will be timestamped at current
                                    playback position
                                </small>

                                <div class="mt-4">
                                    <h6 class="fw-bold mb-3">Comments</h6>
                                    <div class="comment-item">
                                        <div class="d-flex justify-content-between align-items-start mb-2">
                                            <strong>Alice Cooper</strong>
                                            <span class="timestamp-badge" onclick="seekTo(45)">0:45</span>
                                        </div>
                                        <p class="mb-0 text-white-50 small">Love the bass drop here! 🔥</p>
                                    </div>
                                    <div class="comment-item">
                                        <div class="d-flex justify-content-between align-items-start mb-2">
                                            <strong>Mike Ross</strong>
                                            <span class="timestamp-badge" onclick="seekTo(120)">2:00</span>
                                        </div>
                                        <p class="mb-0 text-white-50 small">The transition could be smoother.</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Playlist Sidebar -->
                    <div class="col-lg-4">
                        <div class="player-card">
                            <h5 class="fw-bold mb-3">
                                <i class="bi bi-music-note-list me-2 neon-text"></i> Playlist
                            </h5>
                            <div class="playlist-item active">
                                <div class="d-flex align-items-center">
                                    <div class="me-3 text-white-50">
                                        <i class="bi bi-play-fill fs-5"></i>
                                    </div>
                                    <div class="flex-grow-1">
                                        <div class="fw-bold small">Summer Vibes Demo</div>
                                        <small class="text-white-50">John Doe • 3:24</small>
                                    </div>
                                </div>
                            </div>
                            <div class="playlist-item">
                                <div class="d-flex align-items-center">
                                    <div class="me-3 text-white-50">
                                        <i class="bi bi-music-note fs-5"></i>
                                    </div>
                                    <div class="flex-grow-1">
                                        <div class="fw-bold small">Midnight City</div>
                                        <small class="text-white-50">DJ Snake • 4:12</small>
                                    </div>
                                </div>
                            </div>
                            <div class="playlist-item">
                                <div class="d-flex align-items-center">
                                    <div class="me-3 text-white-50">
                                        <i class="bi bi-music-note fs-5"></i>
                                    </div>
                                    <div class="flex-grow-1">
                                        <div class="fw-bold small">Acoustic Dreams</div>
                                        <small class="text-white-50">Sarah Piano • 5:03</small>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Version History -->
                        <div class="player-card mt-3">
                            <h6 class="fw-bold mb-3">
                                <i class="bi bi-clock-history me-2 neon-text"></i> Version History
                            </h6>
                            <div class="playlist-item">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <div class="fw-bold small">v3 (Current)</div>
                                        <small class="text-white-50">Final mix with mastering</small>
                                    </div>
                                    <small class="text-white-50">2h ago</small>
                                </div>
                            </div>
                            <div class="playlist-item">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <div class="fw-bold small">v2</div>
                                        <small class="text-white-50">Added vocals</small>
                                    </div>
                                    <small class="text-white-50">1d ago</small>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
            <script src="https://unpkg.com/wavesurfer.js@7"></script>
            <script>
                const wavesurfer = WaveSurfer.create({
                    container: '#waveform',
                    waveColor: 'rgba(102, 126, 234, 0.5)',
                    progressColor: '#e94560',
                    cursorColor: '#e94560',
                    barWidth: 3,
                    barRadius: 3,
                    responsive: true,
                    height: 120,
                    barGap: 2
                });

                // Load demo audio (you can replace with actual file)
                wavesurfer.load('https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3');

                const playBtn = document.getElementById('btn-play');
                const volumeSlider = document.getElementById('volume-slider');
                const speedSelect = document.getElementById('speed-select');
                const currentTimeDisplay = document.getElementById('current-time');
                const totalDurationDisplay = document.getElementById('total-duration');

                wavesurfer.on('ready', () => {
                    formatTime(totalDurationDisplay, wavesurfer.getDuration());
                    wavesurfer.setVolume(volumeSlider.value / 100);
                });

                wavesurfer.on('audioprocess', () => {
                    formatTime(currentTimeDisplay, wavesurfer.getCurrentTime());
                });

                playBtn.addEventListener('click', () => {
                    wavesurfer.playPause();
                    if (wavesurfer.isPlaying()) {
                        playBtn.innerHTML = '<i class="bi bi-pause-fill fs-3"></i>';
                    } else {
                        playBtn.innerHTML = '<i class="bi bi-play-fill fs-3"></i>';
                    }
                });

                volumeSlider.addEventListener('input', (e) => {
                    wavesurfer.setVolume(e.target.value / 100);
                });

                speedSelect.addEventListener('change', (e) => {
                    wavesurfer.setPlaybackRate(parseFloat(e.target.value));
                });

                function formatTime(element, time) {
                    const minutes = Math.floor(time / 60);
                    const seconds = Math.floor(time % 60);
                    element.innerText = minutes + ":" + (seconds < 10 ? "0" + seconds : seconds);
                }

                function addComment() {
                    const commentInput = document.getElementById('comment-input');
                    const currentTime = wavesurfer.getCurrentTime();
                    if (commentInput.value.trim()) {
                        alert(`Comment added at ${formatTimeString(currentTime)}: ${commentInput.value}`);
                        commentInput.value = '';
                    }
                }

                function formatTimeString(time) {
                    const minutes = Math.floor(time / 60);
                    const seconds = Math.floor(time % 60);
                    return minutes + ":" + (seconds < 10 ? "0" + seconds : seconds);
                }

                function seekTo(seconds) {
                    wavesurfer.setTime(seconds);
                }
            </script>
        </body>

        </html>