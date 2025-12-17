package com.musicplatform;

import com.musicplatform.dao.*;
import com.musicplatform.model.*;
import com.musicplatform.util.DBUtil;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Date;
import java.util.List;

import static org.junit.Assert.*;

public class FeatureVerificationTest {

    private NotificationDAO notificationDAO;
    private TaskDAO taskDAO;
    private AlbumDAO albumDAO;
    private ProjectDAO projectDAO;
    private int testUserId = 9999;
    private int testProjectId = 9999;
    private int testAlbumId = 0;

    @Before
    public void setUp() throws SQLException {
        notificationDAO = new NotificationDAO();
        taskDAO = new TaskDAO();
        albumDAO = new AlbumDAO();
        projectDAO = new ProjectDAO();

        // Create a dummy user for testing if not exists (or just rely on FK constraints
        // failing if not)
        // For simplicity, we assume the DB is set up. We'll insert a test user directly
        // to be safe.
        try (Connection conn = DBUtil.getConnection()) {
            String sql = "INSERT IGNORE INTO users (id, name, email, password, role) VALUES (?, 'Test User', 'test@test.com', 'pass', 'artist')";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, testUserId);
                stmt.executeUpdate();
            }

            // Create a test project
            Project p = new Project();
            p.setTitle("Test Project");
            p.setDescription("Test Desc");
            p.setDeadline(Date.valueOf("2025-01-01"));
            p.setStatus("PLANNING");
            p.setCreatedBy(testUserId);
            projectDAO.createProject(p);

            // Get the project ID (since it's auto-increment, we need to fetch it or just
            // use the one we just made if we could force ID)
            // To make it easier, let's just fetch the latest project by this user
            List<Project> projects = projectDAO.getProjectsByCreator(testUserId);
            if (!projects.isEmpty()) {
                testProjectId = projects.get(0).getId();
            }
        }
    }

    @After
    public void tearDown() throws SQLException {
        // Clean up
        try (Connection conn = DBUtil.getConnection()) {
            conn.createStatement().execute("DELETE FROM notifications WHERE user_id = " + testUserId);
            conn.createStatement().execute("DELETE FROM tasks WHERE project_id = " + testProjectId);
            if (testAlbumId > 0) {
                conn.createStatement().execute("DELETE FROM albums WHERE id = " + testAlbumId);
            }
            conn.createStatement().execute("DELETE FROM projects WHERE id = " + testProjectId);
            conn.createStatement().execute("DELETE FROM users WHERE id = " + testUserId);
        }
    }

    @Test
    public void testNotificationWorkflow() throws SQLException {
        System.out.println("Testing Notification Workflow...");
        String msg = "Test Notification " + System.currentTimeMillis();
        notificationDAO.createNotification(testUserId, msg);

        List<Notification> notifs = notificationDAO.getUnreadNotifications(testUserId);
        assertFalse("Should have unread notifications", notifs.isEmpty());
        assertEquals("Message should match", msg, notifs.get(0).getMessage());

        notificationDAO.markAsRead(notifs.get(0).getId());
        notifs = notificationDAO.getUnreadNotifications(testUserId);
        assertTrue("Should have no unread notifications after marking read", notifs.isEmpty());
        System.out.println("Notification Workflow Passed!");
    }

    @Test
    public void testTaskWorkflow() throws SQLException {
        System.out.println("Testing Task Workflow...");
        Task task = new Task();
        task.setProjectId(testProjectId);
        task.setTitle("Test Task");
        task.setDescription("Test Desc");
        task.setStatus("TODO");
        task.setDueDate(Date.valueOf("2025-01-01"));

        taskDAO.createTask(task);

        List<Task> tasks = taskDAO.getTasksByProjectId(testProjectId);
        assertFalse("Should have tasks", tasks.isEmpty());
        assertEquals("Task title should match", "Test Task", tasks.get(0).getTitle());
        System.out.println("Task Workflow Passed!");
    }

    @Test
    public void testAlbumPublicToggle() throws SQLException {
        System.out.println("Testing Album Workflow...");
        Album album = new Album();
        album.setTitle("Test Album");
        album.setArtistId(testUserId);
        album.setReleaseDate(Date.valueOf("2025-01-01"));
        album.setDescription("Desc");
        album.setPublic(false);

        albumDAO.createAlbum(album);

        List<Album> albums = albumDAO.getAlbumsByArtist(testUserId);
        assertFalse("Should have albums", albums.isEmpty());
        Album createdAlbum = albums.get(0);
        testAlbumId = createdAlbum.getId();

        assertFalse("Album should be private initially", createdAlbum.isPublic());

        createdAlbum.setPublic(true);
        albumDAO.updateAlbum(createdAlbum);

        Album updatedAlbum = albumDAO.getAlbumById(testAlbumId);
        assertTrue("Album should be public after update", updatedAlbum.isPublic());
        System.out.println("Album Workflow Passed!");
    }
}
