package com.musicplatform.websocket;

import jakarta.websocket.*;
import jakarta.websocket.server.PathParam;
import jakarta.websocket.server.ServerEndpoint;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.io.IOException;

@ServerEndpoint("/ws/collab/{projectId}")
public class CollabWebSocket {

    private static final ObjectMapper mapper = new ObjectMapper();

    @OnOpen
    public void onOpen(Session session, @PathParam("projectId") Integer projectId) {
        System.out.println("WebSocket opened: " + session.getId() + " for project " + projectId);
        SessionManager.addSession(projectId, session);

        // Notify others (Mock user for now, in real app retrieve from Session or Token)
        Message joinMsg = new Message("USER_JOINED", 0, "New User");
        joinMsg.setProjectId(projectId);
        SessionManager.broadcast(projectId, joinMsg);
    }

    @OnMessage
    public void onMessage(String messageJson, Session session, @PathParam("projectId") Integer projectId) {
        try {
            Message msg = mapper.readValue(messageJson, Message.class);
            msg.setProjectId(projectId); // Ensure project ID is consistent

            // Logic to handle specific message types
            switch (msg.getType()) {
                case "CURSOR_MOVED":
                    // Don't echo cursor moves to self
                    SessionManager.broadcastExcept(projectId, msg, session);
                    break;
                case "CHAT":
                case "TRACK_EDIT":
                case "COMMENT_ADDED":
                default:
                    // Broadcast to all
                    SessionManager.broadcast(projectId, msg);
                    break;
            }
        } catch (IOException e) {
            System.err.println("Error parsing message: " + e.getMessage());
        }
    }

    @OnClose
    public void onClose(Session session, @PathParam("projectId") Integer projectId) {
        System.out.println("WebSocket closed: " + session.getId());
        SessionManager.removeSession(projectId, session);
    }

    @OnError
    public void onError(Session session, Throwable throwable) {
        System.err.println("WebSocket error: " + throwable.getMessage());
    }
}
