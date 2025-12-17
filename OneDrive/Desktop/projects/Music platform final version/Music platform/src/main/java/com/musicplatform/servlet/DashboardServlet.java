package com.musicplatform.servlet;

import com.musicplatform.dao.*;
import com.musicplatform.model.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

    private MusicDAO musicDAO;
    private PlaylistDAO playlistDAO;
    private ListeningHistoryDAO listeningHistoryDAO;
    private FollowDAO followDAO;
    private UserDAO userDAO;
    private NotificationDAO notificationDAO;

    @Override
    public void init() {
        musicDAO = new MusicDAO();
        playlistDAO = new PlaylistDAO();
        listeningHistoryDAO = new ListeningHistoryDAO();
        followDAO = new FollowDAO();
        userDAO = new UserDAO();
        notificationDAO = new NotificationDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        String role = user.getRole();

        try {
            // Common data for all roles
            List<Notification> notifications = notificationDAO.getUnreadNotifications(user.getId());
            request.setAttribute("notifications", notifications);

            switch (role) {
                case "admin":
                    loadAdminDashboardData(request);
                    request.getRequestDispatcher("adminDashboard.jsp").forward(request, response);
                    break;
                case "artist":
                    loadArtistDashboardData(request, user);
                    request.getRequestDispatcher("artistDashboard.jsp").forward(request, response);
                    break;
                case "listener":
                    loadListenerDashboardData(request, user);
                    request.getRequestDispatcher("listenerDashboard.jsp").forward(request, response);
                    break;
                default:
                    response.sendRedirect("login.jsp");
                    break;
            }
        } catch (SQLException e) {
            throw new ServletException("Database error while loading dashboard data", e);
        }
    }

    private void loadAdminDashboardData(HttpServletRequest request) throws SQLException {
        List<User> allUsers = userDAO.getAllUsers();
        request.setAttribute("allUsers", allUsers);

        List<Music> allMusic = musicDAO.getAllMusic();
        List<Music> pendingMusic = allMusic.stream().filter(m -> "PENDING".equals(m.getStatus()))
                .collect(Collectors.toList());
        request.setAttribute("pendingMusic", pendingMusic);
    }

    private void loadArtistDashboardData(HttpServletRequest request, User user) throws SQLException {
        List<Music> myMusic = musicDAO.getMusicByArtist(user.getId());
        request.setAttribute("myMusic", myMusic);

        int followerCount = followDAO.getFollowerCount(user.getId());
        request.setAttribute("followerCount", followerCount);
    }

    private void loadListenerDashboardData(HttpServletRequest request, User user) throws SQLException {
        List<Music> allMusic = musicDAO.getAllMusic();
        request.setAttribute("allMusic", allMusic);

        List<Music> listeningHistory = listeningHistoryDAO.getListeningHistory(user.getId());
        request.setAttribute("listeningHistory", listeningHistory);

        List<Playlist> userPlaylists = playlistDAO.getPlaylistsByUser(user.getId());
        request.setAttribute("userPlaylists", userPlaylists);
    }
}
