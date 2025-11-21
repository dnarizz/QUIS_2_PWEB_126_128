package com.library.dao;

import com.library.config.DBConnection;
import java.sql.*;

public class UserDAO {
    public boolean validate(String email, String password) {
        boolean status = false;
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement("select * from users where email = ? and password = ?")) {
            ps.setString(1, email);
            ps.setString(2, password); // Di real world, gunakan hash compare
            ResultSet rs = ps.executeQuery();
            status = rs.next();
        } catch (Exception e) { e.printStackTrace(); }
        return status;
    }
    
    public int getUserId(String email) {
        int id = 0;
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement("select id from users where email = ?")) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if(rs.next()) id = rs.getInt("id");
        } catch (Exception e) { e.printStackTrace(); }
        return id;
    }

    public void register(String name, String email, String password) {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement("INSERT INTO users (name, email, password, created_at) VALUES (?, ?, ?, NOW())")) {
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, password);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

}
