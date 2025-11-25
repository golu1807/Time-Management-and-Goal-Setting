// src/DBConnection.java
import java.sql.*;
public class DBConnection {
    private static final String URL = "jdbc:mysql://localhost:3306/musicdb";
    private static final String USER = "root";
    private static final String PASS = "ayush";
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASS);
    }
}
