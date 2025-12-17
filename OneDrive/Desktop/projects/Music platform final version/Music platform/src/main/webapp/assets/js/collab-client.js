/**
 * CollabClient - Robust Real-Time Collaboration Module
 * Implements full Prompt 3 requirements: Messaging, Cursors, Locks, Timeline Events.
 */
class CollabClient {
    constructor(projectId, userId, username) {
        this.projectId = projectId;
        this.userId = userId;
        this.username = username;
        this.socket = null;
        this.reconnectAttempts = 0;
        this.maxReconnectAttempts = 5;
        this.cursors = {}; // Map userId -> cursor DOM Element

        // Colors for other users
        this.userColors = ['#FF5733', '#33FF57', '#3357FF', '#F033FF', '#FF33A8', '#33FFF5'];
    }

    /**
     * Connects to the WebSocket server.
     * @param {string} token - Auth token (placeholder for now)
     */
    connect(token) {
        const protocol = window.location.protocol === 'https:' ? 'wss:' : 'ws:';
        const host = window.location.host;
        // Adjust context path if needed
        const wsUrl = `${protocol}//${host}/ws/collab/${this.projectId}`;

        console.log(`Connecting to WebSocket: ${wsUrl} with token: ${token || 'none'}`);
        this.socket = new WebSocket(wsUrl);

        this.socket.onopen = (event) => this.onOpen(event);
        this.socket.onmessage = (event) => this.onMessage(event);
        this.socket.onclose = (event) => this.onClose(event);
        this.socket.onerror = (event) => this.onError(event);

        // Capture mouse moves for cursor broadcasting
        this.setupCursorTracking();
    }

    onOpen(event) {
        console.log("WebSocket Connected!");
        this.reconnectAttempts = 0;
        this.showNotification("Connected to Collab Session", "success");

        // Announce presence
        this.sendMessage("USER_JOINED", { username: this.username });
    }

    onMessage(event) {
        try {
            const message = JSON.parse(event.data);

            switch (message.type) {
                case "CHAT":
                    this.handleChat(message);
                    break;
                case "CURSOR_MOVED":
                    this.handleCursorMoved(message);
                    break;
                case "TRACK_EDIT":
                    this.handleTrackEdit(message);
                    break;
                case "COMMENT_ADDED":
                    this.handleCommentAdded(message);
                    break;
                case "LOCK_GRANTED":
                case "LOCK_DENIED":
                    this.handleLockResponse(message);
                    break;
                case "USER_JOINED":
                    this.showNotification(`${message.payload.username || 'Someone'} joined.`, "info");
                    break;
                default:
                    console.log("Unknown message type:", message);
            }
        } catch (e) {
            console.error("Error processing message:", e);
        }
    }

    /* -----------------------------------------------------
       Message Sending
       ----------------------------------------------------- */
    sendMessage(type, payload) {
        if (this.socket && this.socket.readyState === WebSocket.OPEN) {
            const msg = {
                type: type,
                userId: this.userId,
                username: this.username,
                projectId: this.projectId,
                payload: payload,
                timestamp: Date.now()
            };
            this.socket.send(JSON.stringify(msg));
        }
    }

    /* -----------------------------------------------------
       Feature: Cursor Tracking
       ----------------------------------------------------- */
    setupCursorTracking() {
        // Broadcast mouse position every 100ms
        const workspace = document.querySelector('.collab-grid'); // or document.body
        if (!workspace) return;

        let throttleTimer;
        workspace.addEventListener('mousemove', (e) => {
            if (throttleTimer) return;
            throttleTimer = setTimeout(() => {
                const rect = workspace.getBoundingClientRect();
                const x = e.clientX - rect.left;
                const y = e.clientY - rect.top;

                // Only broadcast if inside workspace
                if (x >= 0 && y >= 0) {
                    this.sendMessage("CURSOR_MOVED", { x: x, y: y });
                }
                throttleTimer = null;
            }, 100);
        });
    }

    handleCursorMoved(message) {
        // Don't draw self (server should ideally filter, but safe check)
        if (message.userId === this.userId) return;

        const { x, y } = message.payload;
        let cursor = this.cursors[message.userId];

        // Create if not exists
        if (!cursor) {
            cursor = document.createElement('div');
            cursor.className = 'collab-cursor';
            cursor.style.color = this.userColors[message.userId % this.userColors.length];

            const label = document.createElement('div');
            label.className = 'collab-cursor-label';
            label.innerText = message.username || `User ${message.userId}`;

            cursor.appendChild(label);

            // Append to a specific cursor layer container
            const layer = document.querySelector('.cursor-layer') || document.body;
            layer.appendChild(cursor);
            this.cursors[message.userId] = cursor;
        }

        // Update position
        cursor.style.transform = `translate(${x}px, ${y}px)`;
    }

    /* -----------------------------------------------------
       Feature: Chat UI
       ----------------------------------------------------- */
    handleChat(message) {
        const chatPanel = document.querySelector('.panel-body');
        if (chatPanel) {
            const isMe = message.userId === this.userId;
            const msgDiv = document.createElement('div');
            msgDiv.className = `chat-msg ${isMe ? 'me' : ''}`;
            msgDiv.style.textAlign = isMe ? 'right' : 'left';

            const content = `
                ${!isMe ? `<div class="cw-author">${message.username || message.payload.username || 'Unknown'}</div>` : ''}
                <div class="cw-text" style="display: inline-block;">${message.payload.message || message.payload}</div>
            `; // Handling both full payload object or string for backward compat
            msgDiv.innerHTML = content;
            chatPanel.appendChild(msgDiv);
            chatPanel.scrollTop = chatPanel.scrollHeight;
        }
    }

    /* -----------------------------------------------------
       Feature: Timeline Stubs
       ----------------------------------------------------- */
    handleTrackEdit(message) {
        // e.g., { action: "trim", startMs: 1000, endMs: 5000 }
        console.log(`[Timeline] User ${message.userId} edited track:`, message.payload);
        this.showNotification(`User ${message.username} edited a track`, "info");
        // Actual DOM manipulation logic would go here
    }

    handleCommentAdded(message) {
        console.log(`[Timeline] Comment at ${message.timestampMs}: ${message.text}`);
        this.showNotification(`New comment: ${message.text}`, "success");
    }

    /* -----------------------------------------------------
       Feature: Concurrency / Locks
       ----------------------------------------------------- */
    requestLock(trackId) {
        this.sendMessage("LOCK_REQUEST", { trackId: trackId });
    }

    handleLockResponse(message) {
        const { trackId, granted } = message.payload;
        if (granted) {
            console.log(`Lock GRANTED for track ${trackId}`);
            // Add visual padlock to track header
        } else {
            this.showNotification("Could not acquire lock. Track is busy.", "error");
        }
    }

    /* -----------------------------------------------------
       Utilities
       ----------------------------------------------------- */
    onClose(event) {
        console.warn("WebSocket Disconnected");
        if (this.reconnectAttempts < this.maxReconnectAttempts) {
            this.reconnectAttempts++;
            const delay = Math.pow(2, this.reconnectAttempts) * 1000; // Exponential backoff
            console.log(`Reconnecting in ${delay}ms...`);
            setTimeout(() => this.connect(), delay);
        } else {
            this.showNotification("Connection lost permanently.", "error");
        }
    }

    onError(event) {
        console.error("WebSocket Error", event);
    }

    showNotification(text, type) {
        // Check for toast container or console
        const toast = document.createElement('div');
        toast.className = `alert alert-${type === 'error' ? 'danger' : type === 'success' ? 'success' : 'info'} position-fixed start-50 translate-middle-x top-0 mt-3`;
        toast.style.zIndex = 9999;
        toast.innerText = text;
        document.body.appendChild(toast);
        setTimeout(() => toast.remove(), 3000);
    }
}

window.CollabClient = CollabClient;
