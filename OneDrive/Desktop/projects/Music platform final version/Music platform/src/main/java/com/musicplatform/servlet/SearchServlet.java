package com.musicplatform.servlet;

import com.musicplatform.dao.MusicDAO;
import com.musicplatform.dao.UserDAO;
import com.musicplatform.model.Music;
import com.musicplatform.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/search")
public class SearchServlet extends HttpServlet {
    private MusicDAO musicDAO;
    private UserDAO userDAO;

    @Override
    public void init() {
        musicDAO = new MusicDAO();
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String query = request.getParameter("query");
        if (query == null || query.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/dashboard");
            return;
        }

        try {
            List<Music> allMusic = musicDAO.getAllMusic();
            List<Music> filteredMusic = allMusic.stream()
                .filter(m -> m.getTitle().toLowerCase().contains(query.toLowerCase()) ||
                               m.getArtist().toLowerCase().contains(query.toLowerCase()) ||
                               m.getAlbum().toLowerCase().contains(query.toLowerCase()))
                .collect(Collectors.toList());

            List<User> allUsers = userDAO.getAllUsers();
            List<User> filteredArtists = allUsers.stream()
                .filter(u -> "artist".equals(u.getRole()) && u.getName().toLowerCase().contains(query.toLowerCase()))
                .collect(Collectors.toList());

            request.setAttribute("musicResults", filteredMusic);
            request.setAttribute("artistResults", filteredArtists);
            request.setAttribute("searchQuery", query);
            request.getRequestDispatcher("searchResults.jsp").forward(request, response);

        } catch (SQLException e) {
            throw new ServletException("Database error during search", e);
        }
    }
}
