package com.musicplatform.servlet;

import com.musicplatform.dao.MusicDAO;
import com.musicplatform.model.Music;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.sql.SQLException;

@WebServlet("/stream")
public class StreamServlet extends HttpServlet {

    private MusicDAO musicDAO;

    @Override
    public void init() {
        musicDAO = new MusicDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String musicIdStr = request.getParameter("id");
        if (musicIdStr == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing music ID");
            return;
        }

        try {
            int musicId = Integer.parseInt(musicIdStr);
            Music music = musicDAO.getMusicById(musicId);

            if (music == null || music.getFilePath() == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Music not found");
                return;
            }

            File musicFile = new File(music.getFilePath());
            if (!musicFile.exists()) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Music file not found");
                return;
            }

            response.setContentType("audio/mpeg"); // Or determine dynamically
            response.setContentLength((int) musicFile.length());

            try (FileInputStream in = new FileInputStream(musicFile);
                 OutputStream out = response.getOutputStream()) {

                byte[] buffer = new byte[4096];
                int bytesRead;
                while ((bytesRead = in.read(buffer)) != -1) {
                    out.write(buffer, 0, bytesRead);
                }
            }

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid music ID");
        } catch (SQLException e) {
            throw new ServletException("Database error while streaming music", e);
        }
    }
}
