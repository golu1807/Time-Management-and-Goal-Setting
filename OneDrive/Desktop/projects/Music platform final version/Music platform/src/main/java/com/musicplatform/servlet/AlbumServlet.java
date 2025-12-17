package com.musicplatform.servlet;

import com.musicplatform.dao.AlbumDAO;
import com.musicplatform.model.Album;
import com.musicplatform.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/albums")
public class AlbumServlet extends HttpServlet {
    private AlbumDAO albumDAO;

    @Override
    public void init() throws ServletException {
        albumDAO = new AlbumDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            List<Album> albums;
            if ("admin".equals(user.getRole())) {
                albums = albumDAO.getAllAlbums();
            } else {
                // For musicians/artists, show their albums
                // For listeners, maybe show all? For now, let's show all for listeners too or
                // just their own if they could have one?
                // Requirement says "Manage Music Portfolio" for Musician.
                if ("artist".equals(user.getRole())) {
                    albums = albumDAO.getAlbumsByArtist(user.getId());
                } else {
                    albums = albumDAO.getAllAlbums(); // Listeners see all
                }
            }
            request.setAttribute("albums", albums);
            request.getRequestDispatcher("albums.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Error retrieving albums", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || !"artist".equals(user.getRole())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Only artists can create albums");
            return;
        }

        String action = request.getParameter("action");

        if ("create".equals(action)) {
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            String releaseDateStr = request.getParameter("releaseDate");
            Date releaseDate = Date.valueOf(releaseDateStr);

            Album album = new Album();
            album.setTitle(title);
            album.setDescription(description);
            album.setReleaseDate(releaseDate);
            album.setArtistId(user.getId());
            album.setPublic(false); // Default to private

            try {
                albumDAO.createAlbum(album);
                response.sendRedirect("albums?success=created");
            } catch (SQLException e) {
                throw new ServletException("Error creating album", e);
            }
        } else if ("togglePublic".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            try {
                Album album = albumDAO.getAlbumById(id);
                if (album != null && album.getArtistId() == user.getId()) {
                    album.setPublic(!album.isPublic());
                    albumDAO.updateAlbum(album);
                }
                response.sendRedirect("albums");
            } catch (SQLException e) {
                throw new ServletException("Error updating album status", e);
            }
        }
    }
}
