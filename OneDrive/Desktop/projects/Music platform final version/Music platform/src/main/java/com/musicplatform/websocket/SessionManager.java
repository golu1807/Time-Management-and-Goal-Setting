package com.musicplatform.websocket;

import jakarta.websocket.Session;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.io.IOException;
import java.util.Collections;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.CopyOnWriteArraySet;

public class SessionManager {
    private static final Map<Integer, Set<Session>> projectSessions = new ConcurrentHashMap<>();
    private static final ObjectMapper mapper = new ObjectMapper();

    public static void addSession(Integer projectId, Session session) {
        projectSessions.computeIfAbsent(projectId, k -> new CopyOnWriteArraySet<>()).add(session);
    }

    public static void removeSession(Integer projectId, Session session) {
        if (projectSessions.containsKey(projectId)) {
            projectSessions.get(projectId).remove(session);
            if (projectSessions.get(projectId).isEmpty()) {
                projectSessions.remove(projectId);
            }
        }
    }

    public static void broadcast(Integer projectId, Message message) {
        Set<Session> sessions = projectSessions.getOrDefault(projectId, Collections.emptySet());
        try {
            String jsonMessage = mapper.writeValueAsString(message);
            for (Session session : sessions) {
                if (session.isOpen()) {
                    session.getAsyncRemote().sendText(jsonMessage);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    // Send to everyone EXCEPT the sender (e.g., for cursor movements)
    public static void broadcastExcept(Integer projectId, Message message, Session senderSession) {
        Set<Session> sessions = projectSessions.getOrDefault(projectId, Collections.emptySet());
        try {
            String jsonMessage = mapper.writeValueAsString(message);
            for (Session session : sessions) {
                if (session.isOpen() && !session.equals(senderSession)) {
                    session.getAsyncRemote().sendText(jsonMessage);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
