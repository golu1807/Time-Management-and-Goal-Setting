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

    @Override
    public void init() {
        musicDAO = new MusicDAO();
        playlistDAO = new PlaylistDAO();
        listeningHistoryDAO = new ListeningHistoryDAO();
        followDAO = new FollowDAO();
        userDAO = new UserDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        String role = user.getRole();

        try {
            switch (role) {
                case "admin":
                    loadAdminDashboardData(request);
                    request.getRequestDispatcher("adminDashboard.jsp").forward(request, response);
                    break;
                case "artist":
                    // Artist-specific data loading can go here
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
        List<Music> pendingMusic = allMusic.stream().filter(m -> "PENDING".equals(m.getStatus())).collect(Collectors.toList());
        request.setAttribute("pendingMusic", pendingMusic);
    }

    private void loadListenerDashboardData(HttpServletRequest request, User user) throws SQLException {
        // ... (rest of the method is unchanged)
    }
}
