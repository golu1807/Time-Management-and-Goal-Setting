// src/UserDAO.java
import java.sql.*;
public class UserDAO {
    public static User validate(String email, String password) {
        try (Connection con = DBConnection.getConnection()) {
            PreparedStatement ps = con.prepareStatement("SELECT * FROM users WHERE email=? AND password=?");
            ps.setString(1, email); ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if(rs.next()) {
                return new User(rs.getInt("id"), rs.getString("name"), rs.getString("email"), rs.getString("role"));
            }
        } catch(Exception e) { e.printStackTrace(); }
        return null;
    }
}
