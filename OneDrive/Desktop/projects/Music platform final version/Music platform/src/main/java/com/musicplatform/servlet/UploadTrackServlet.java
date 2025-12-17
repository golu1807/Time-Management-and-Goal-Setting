package com.musicplatform.servlet;

import com.musicplatform.dao.MusicDAO;
import com.musicplatform.model.Music;
import com.musicplatform.model.User;
import com.musicplatform.util.AWSStorageUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.IOException;
import java.io.InputStream;
import java.util.UUID;

@WebServlet("/uploadTrack")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 50, // 50MB
        maxRequestSize = 1024 * 1024 * 60 // 60MB
)
public class UploadTrackServlet extends HttpServlet {

    private MusicDAO musicDAO;

    @Override
    public void init() {
        musicDAO = new MusicDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            String title = request.getParameter("title");
            String genre = request.getParameter("genre");
            String description = request.getParameter("description"); // Not in model yet, ignoring or need to add
            String album = request.getParameter("album");
            if (album == null || album.isEmpty())
                album = "Single";

            Part filePart = request.getPart("file");
            if (filePart == null || filePart.getSize() == 0) {
                request.setAttribute("error", "Please select a file.");
                request.getRequestDispatcher("upload.jsp").forward(request, response);
                return;
            }

            // Upload to S3
            String fileName = UUID.randomUUID().toString() + "_" + getSubmittedFileName(filePart);
            String bucketKey = "tracks/" + user.getId() + "/" + fileName;

            // Check if AWS is configured, else fallback (mock or local?)
            // For now, assuming AWS or failing gracefully
            String s3Key = null;
            if (AWSStorageUtil.isConfigured()) {
                try (InputStream inputStream = filePart.getInputStream()) {
                    s3Key = AWSStorageUtil.uploadFile(bucketKey, inputStream, filePart.getSize(),
                            filePart.getContentType());
                }
            } else {
                // Fallback: Store locally (optional) or just use a mock path
                System.out.println("AWS Not Configured. Mocking upload.");
                s3Key = "mock_uploads/" + fileName;
            }

            if (s3Key == null) {
                throw new IOException("Failed to upload file to storage.");
            }

            // Save to DB
            Music music = new Music();
            music.setTitle(title);
            music.setArtist(user.getName()); // Assuming User has name
            music.setArtistId(user.getId());
            music.setGenre(genre);
            music.setAlbum(album);
            music.setFilePath(s3Key);
            music.setStatus("PENDING");

            musicDAO.createMusic(music);

            response.sendRedirect("artistDashboard.jsp?message=Track uploaded successfully!");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Upload failed: " + e.getMessage());
            request.getRequestDispatcher("upload.jsp").forward(request, response);
        }
    }

    private String getSubmittedFileName(Part part) {
        for (String cd : part.getHeader("content-disposition").split(";")) {
            if (cd.trim().startsWith("filename")) {
                return cd.substring(cd.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }
}
