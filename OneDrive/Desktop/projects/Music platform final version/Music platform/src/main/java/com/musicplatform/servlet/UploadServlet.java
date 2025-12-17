package com.musicplatform.servlet;

import com.musicplatform.dao.AlbumDAO;
import com.musicplatform.dao.ProjectDAO;
import com.musicplatform.model.Album;
import com.musicplatform.model.User;
import com.musicplatform.util.DBUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/upload")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 50, // 50MB
        maxRequestSize = 1024 * 1024 * 100 // 100MB
)
public class UploadServlet extends HttpServlet {

    private static final String UPLOAD_DIR = "uploads";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String title = request.getParameter("title");
        String genre = request.getParameter("genre");
        String bpm = request.getParameter("bpm");
        String tags = request.getParameter("tags");
        String description = request.getParameter("description");
        String visibility = request.getParameter("visibility");
        String projectIdStr = request.getParameter("projectId");
        int projectId = (projectIdStr != null && !projectIdStr.isEmpty()) ? Integer.parseInt(projectIdStr) : 0;

        Part filePart = request.getPart("file");
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

        // Save file to server
        String applicationPath = request.getServletContext().getRealPath("");
        String uploadFilePath = applicationPath + File.separator + UPLOAD_DIR;

        File uploadDir = new File(uploadFilePath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        String filePath = uploadFilePath + File.separator + fileName;
        filePart.write(filePath);

        // Save metadata to database
        // Note: We are reusing the 'music' table for now, or we could create a new
        // 'tracks' table.
        // Given the schema, 'music' table seems appropriate but might need updates for
        // BPM/Tags if not present.
        // For this phase, we'll insert into 'music' and assume we might need to alter
        // it or use a description field for extras.

        try (Connection conn = DBUtil.getConnection()) {
            String sql = "INSERT INTO music (title, artist, album, genre, file_path, uploaded_by) VALUES (?, ?, ?, ?, ?, ?)";
            // We are mapping 'description' to 'album' temporarily or we should update
            // schema.
            // Let's stick to the existing schema columns for now and maybe add BPM/Tags
            // later or store in description.

            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, title);
                stmt.setString(2, user.getName()); // Artist Name
                stmt.setString(3, description); // Using Album col for description for now
                stmt.setString(4, genre);
                stmt.setString(5, UPLOAD_DIR + "/" + fileName);
                stmt.setInt(6, user.getId());

                stmt.executeUpdate();
            }

            // If linked to a project, we should also add it to file_versions or a new
            // project_tracks table
            if (projectId > 0) {
                // Logic to link to project (e.g., insert into file_versions)
                // For now, we'll just redirect to the project page
                response.sendRedirect("project/details?id=" + projectId);
            } else {
                response.sendRedirect("artistDashboard.jsp");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("upload.jsp?error=database");
        }
    }
}
