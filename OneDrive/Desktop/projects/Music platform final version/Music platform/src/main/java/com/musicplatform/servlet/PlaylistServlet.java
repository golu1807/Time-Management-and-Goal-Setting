package com.musicplatform.servlet;

import com.musicplatform.dao.PlaylistDAO;
import com.musicplatform.model.Playlist;
import com.musicplatform.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/playlist")
public class PlaylistServlet extends HttpServlet {
    private PlaylistDAO playlistDAO;

    @Override
    public void init() {
        playlistDAO = new PlaylistDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String playlistIdStr = request.getParameter("id");
        if (playlistIdStr != null) {
            try {
                int playlistId = Integer.parseInt(playlistIdStr);
                Playlist playlist = playlistDAO.getPlaylistById(playlistId);
                request.setAttribute("playlist", playlist);
                request.getRequestDispatcher("playlist.jsp").forward(request, response);
            } catch (NumberFormatException | SQLException e) {
                throw new ServletException("Error retrieving playlist", e);
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        String action = request.getParameter("action");

        try {
            if ("create".equals(action)) {
                String title = request.getParameter("title");
                Playlist playlist = new Playlist();
                playlist.setTitle(title);
                playlist.setUserId(user.getId());
                playlistDAO.createPlaylist(playlist);
                response.sendRedirect("dashboard");
            } else if ("addSong".equals(action)) {
                int playlistId = Integer.parseInt(request.getParameter("playlistId"));
                int musicId = Integer.parseInt(request.getParameter("musicId"));
                playlistDAO.addSongToPlaylist(playlistId, musicId);
                response.sendRedirect("dashboard");
            } else if ("removeSong".equals(action)) {
                int playlistId = Integer.parseInt(request.getParameter("playlistId"));
                int musicId = Integer.parseInt(request.getParameter("musicId"));
                playlistDAO.removeSongFromPlaylist(playlistId, musicId);
                response.sendRedirect("playlist?id=" + playlistId);
            } else if ("delete".equals(action)) {
                int playlistId = Integer.parseInt(request.getParameter("playlistId"));
                playlistDAO.deletePlaylist(playlistId);
                response.sendRedirect("dashboard");
            }
        } catch (SQLException | NumberFormatException e) {
            throw new ServletException("Error processing playlist action", e);
        }
    }
}
