package com.musicplatform.servlet;

import com.musicplatform.dao.MusicDAO;
import com.musicplatform.model.Music;
import com.musicplatform.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/upload")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
                 maxFileSize = 1024 * 1024 * 10,      // 10MB
                 maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class UploadServlet extends HttpServlet {

    private static final String UPLOAD_DIR = "C:/music_uploads";
    private MusicDAO musicDAO;

    @Override
    public void init() {
        musicDAO = new MusicDAO();
        File uploadDir = new File(UPLOAD_DIR);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null || !"artist".equals(user.getRole())) {
            response.sendRedirect("login.jsp");
            return;
        }

        String title = request.getParameter("title");
        String album = request.getParameter("album");
        String genre = request.getParameter("genre");

        Part filePart = request.getPart("audioFile");
        String fileName = getFileName(filePart);
        String filePath = UPLOAD_DIR + File.separator + fileName;

        try {
            filePart.write(filePath);

            Music music = new Music();
            music.setTitle(title);
            music.setArtist(user.getName());
            music.setAlbum(album);
            music.setGenre(genre);
            music.setFilePath(filePath);
            music.setArtistId(user.getId());
            music.setStatus("PENDING");

            musicDAO.createMusic(music);

            response.sendRedirect("dashboard");
        } catch (SQLException e) {
            throw new ServletException("Database error during music upload", e);
        }
    }

    private String getFileName(Part part) {
        for (String content : part.getHeader("content-disposition").split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(content.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }
}
