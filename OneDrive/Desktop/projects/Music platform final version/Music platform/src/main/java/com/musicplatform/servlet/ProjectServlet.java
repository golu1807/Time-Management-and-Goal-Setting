package com.musicplatform.servlet;

import com.musicplatform.dao.ProjectDAO;
import com.musicplatform.model.Project;
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

@WebServlet({ "/projects", "/project/details", "/project/action" })
@jakarta.servlet.annotation.MultipartConfig
public class ProjectServlet extends HttpServlet {
    private ProjectDAO projectDAO;
    private com.musicplatform.dao.TaskDAO taskDAO;
    private com.musicplatform.dao.ProjectCommentDAO commentDAO;
    private com.musicplatform.dao.FileVersionDAO fileDAO;

    @Override
    public void init() throws ServletException {
        projectDAO = new ProjectDAO();
        taskDAO = new com.musicplatform.dao.TaskDAO();
        commentDAO = new com.musicplatform.dao.ProjectCommentDAO();
        fileDAO = new com.musicplatform.dao.FileVersionDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String path = request.getServletPath();

        try {
            if ("/project/details".equals(path)) {
                int projectId = Integer.parseInt(request.getParameter("id"));
                Project project = projectDAO.getProjectById(projectId);

                // Security check: Ensure user is creator or collaborator (simplified to
                // creator/admin for now)
                if (project != null && (project.getCreatedBy() == user.getId() || "admin".equals(user.getRole()))) {
                    request.setAttribute("project", project);
                    request.setAttribute("tasks", taskDAO.getTasksByProjectId(projectId));
                    request.setAttribute("comments", commentDAO.getCommentsByProjectId(projectId));
                    request.setAttribute("files", fileDAO.getFilesByProjectId(projectId));
                    request.getRequestDispatcher("/project_details.jsp").forward(request, response);
                } else {
                    response.sendRedirect(request.getContextPath() + "/projects");
                }
            } else {
                // Default: List projects
                List<Project> projects;
                if ("admin".equals(user.getRole())) {
                    projects = projectDAO.getAllProjects();
                } else {
                    projects = projectDAO.getProjectsByCreator(user.getId());
                }
                request.setAttribute("projects", projects);
                request.getRequestDispatcher("/projects.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            throw new ServletException("Database error", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String action = request.getParameter("action");

        try {
            if ("create".equals(action)) {
                String title = request.getParameter("title");
                String description = request.getParameter("description");
                Date deadline = Date.valueOf(request.getParameter("deadline"));

                Project project = new Project();
                project.setTitle(title);
                project.setDescription(description);
                project.setDeadline(deadline);
                project.setStatus("PLANNING");
                project.setCreatedBy(user.getId());

                projectDAO.createProject(project);
                response.sendRedirect(request.getContextPath() + "/projects?success=created");
            } else if ("addTask".equals(action)) {
                int projectId = Integer.parseInt(request.getParameter("projectId"));
                String title = request.getParameter("title");
                String description = request.getParameter("description");
                String dueDateStr = request.getParameter("dueDate");

                com.musicplatform.model.Task task = new com.musicplatform.model.Task();
                task.setProjectId(projectId);
                task.setTitle(title);
                task.setDescription(description);
                task.setStatus("TODO");
                if (dueDateStr != null && !dueDateStr.isEmpty()) {
                    task.setDueDate(Date.valueOf(dueDateStr));
                }

                taskDAO.createTask(task);
                response.sendRedirect(request.getContextPath() + "/project/details?id=" + projectId);
            } else if ("addComment".equals(action)) {
                int projectId = Integer.parseInt(request.getParameter("projectId"));
                String content = request.getParameter("content");

                com.musicplatform.model.ProjectComment comment = new com.musicplatform.model.ProjectComment();
                comment.setProjectId(projectId);
                comment.setUserId(user.getId());
                comment.setContent(content);

                commentDAO.addComment(comment);
                response.sendRedirect(request.getContextPath() + "/project/details?id=" + projectId);
            } else if ("uploadFile".equals(action)) {
                int projectId = Integer.parseInt(request.getParameter("projectId"));
                String fileName = request.getParameter("fileName");
                String description = request.getParameter("description");
                jakarta.servlet.http.Part filePart = request.getPart("file");

                // File upload logic (Simplified: saving to a local folder or just DB metadata)
                // For this demo, we'll just simulate the path and save metadata
                String originalFileName = filePart.getSubmittedFileName();
                String filePath = "/uploads/" + projectId + "/" + originalFileName; // Mock path

                int version = fileDAO.getNextVersionNumber(projectId, fileName);

                com.musicplatform.model.FileVersion file = new com.musicplatform.model.FileVersion();
                file.setProjectId(projectId);
                file.setFileName(fileName);
                file.setVersionNumber(version);
                file.setUploadedBy(user.getId());
                file.setFilePath(filePath);
                file.setDescription(description);

                fileDAO.addFileVersion(file);
                response.sendRedirect(request.getContextPath() + "/project/details?id=" + projectId);
            }
        } catch (SQLException e) {
            throw new ServletException("Error processing project action", e);
        }
    }
}
