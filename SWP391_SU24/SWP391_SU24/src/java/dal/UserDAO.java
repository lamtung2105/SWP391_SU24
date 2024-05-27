/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import model.User;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author LAPTOP
 */
public class UserDAO extends MyDAO {

    public List<User> checkUser(String email, String passWord) {
        List<User> t = new ArrayList<>();
        xSql = "select * from Users where Email = ? and [Password] = ?";
        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, email);
            ps.setString(2, passWord);
            rs = ps.executeQuery();
            while (rs.next()) {
                t.add(fromResultSet(rs));
            }
            ps.execute();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return t;
    }

    public User getUser(String email, String pass) throws SQLException {
        xSql = "select * from Users where Email = ? and [Password] = ?";
        ps = con.prepareStatement(xSql);
        ps.setString(1, email);
        ps.setString(2, pass);
        rs = ps.executeQuery();
        if (rs.next()) {
            return fromResultSet(rs);
        }
        return null;
    }

    public boolean checkAdmin(String email, String passWord) {
        List<User> t = new ArrayList<>();
        xSql = "select * from Users where Email = ? and [Password] = ?";
        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, email);
            ps.setString(2, passWord);
            rs = ps.executeQuery();
            while (rs.next()) {
                t.add(fromResultSet(rs));
            }
            if (!t.isEmpty()) {
                for (int i = 0; i < t.size(); i++) {
                    if (t.get(i).getRole() == 4) {
                        return true;
                    }
                }
            }
            ps.execute();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean checkManager(String email, String passWord) {
        List<User> t = new ArrayList<>();
        xSql = "select * from Users where Email = ? and [Password] = ?";
        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, email);
            ps.setString(2, passWord);
            rs = ps.executeQuery();
            while (rs.next()) {
                t.add(fromResultSet(rs));
            }
            if (!t.isEmpty()) {
                for (int i = 0; i < t.size(); i++) {
                    if (t.get(i).getRole() == 3) {
                        return true;
                    }
                }
            }
            ps.execute();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean checkTeacher(String email, String passWord) {
        List<User> t = new ArrayList<>();
        xSql = "select * from Users where Email = ? and [Password] = ?";
        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, email);
            ps.setString(2, passWord);
            rs = ps.executeQuery();
            while (rs.next()) {
                t.add(fromResultSet(rs));
            }
            if (!t.isEmpty()) {
                for (int i = 0; i < t.size(); i++) {
                    if (t.get(i).getRole() == 2) {
                        return true;
                    }
                }
            }
            ps.execute();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public User fromResultSet(ResultSet rs) throws SQLException {
        return new User(
                rs.getInt(1),
                rs.getString(2),
                rs.getString(3),
                rs.getString(4),
                rs.getInt(5),
                rs.getDate(6),
                rs.getBoolean(7),
                rs.getString(8),
                rs.getDate(9),
                rs.getString(10)
        );
    }
}
