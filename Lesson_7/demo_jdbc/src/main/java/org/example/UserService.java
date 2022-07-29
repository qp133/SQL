package org.example;

import org.mindrot.jbcrypt.BCrypt;

import java.sql.*;
import java.util.ArrayList;
import java.util.Scanner;

public class UserService {
    ConnectDatabase connectDatabase;
    Scanner sc = new Scanner(System.in);
    ArrayList<User> list = new ArrayList<>();

    public UserService() {
        connectDatabase = new ConnectDatabase();
    }

    public ArrayList<User> getAllUser() {
        Connection conn = connectDatabase.connect();
        String query = "SELECT * FROM users";

        // Tạo câu lệnh (statement)
        try {
            Statement stm = conn.createStatement();

            //Thực thi câu lệnh và trả về kết quả
            ResultSet rs = stm.executeQuery(query);

            //Duyệt kết quả
            while (rs.next()) {
                int id = rs.getInt("id");
                String userName = rs.getString("user_name");
                String email = rs.getString("email");
                String password = rs.getString("password");

                list.add(new User(id, userName, email, password));
            }
            conn.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return list;
    }

    public void insert() {
        Connection conn = connectDatabase.connect();

        String query = "INSERT INTO users(id, user_name, email, password)\n" +
                "VALUES (null, ?, ?, ?)";

        String encodePassword = BCrypt.hashpw("123456", BCrypt.gensalt(12));
        try {
            PreparedStatement pstm = conn.prepareStatement(query);
            pstm.setString(1, "quang");
            pstm.setString(2, "quang@gmail.com");
            pstm.setString(3, encodePassword);

            int row = pstm.executeUpdate();
            if (row != 0) {
                System.out.println("Thêm thành công");
            }

            conn.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    //Tìm user theo id
    public User getUserById(int fId) {
        User u = null;
        Connection conn = connectDatabase.connect();
        String query = "SELECT * FROM users WHERE id = ?";

        try {
            PreparedStatement pstm = conn.prepareStatement(query);
            pstm.setInt(1, fId);

            ResultSet rs = pstm.executeQuery();

            while (rs.next()) {
                int id = rs.getInt("id");
                String userName = rs.getString("user_name");
                String email = rs.getString("email");
                String password = rs.getString("password");

                u = new User(id, userName, email, password);
            }
            conn.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return u;
    }

    //Cập nhật password của user vừa tìm được
    public void updatePassword(User u, String newPassword) {
        Connection conn = connectDatabase.connect();

        String query = "UPDATE users SET password = ? WHERE id = ?";
        String encodePassword = BCrypt.hashpw(newPassword, BCrypt.gensalt(12));

        try {
            PreparedStatement pstm = conn.prepareStatement(query);

            pstm.setString(1, encodePassword);
            pstm.setInt(2, u.getId());

            int row = pstm.executeUpdate();

            if (row != 0) {
                System.out.println("Cập nhật thành công");
            }

            conn.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    //Xóa user
    public void deleteUser(User u) {
        Connection conn = connectDatabase.connect();
        String query = "DELETE FROM users WHERE id = ?";

        try {
            PreparedStatement pstm = conn.prepareStatement(query);

            pstm.setInt(1,u.getId());

            int row = pstm.executeUpdate();
            if (row != 0) {
                System.out.println("Xóa thành công");
            }
            conn.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
