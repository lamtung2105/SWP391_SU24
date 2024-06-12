/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Class;
/**
 *
 * @author Acer
 */
public class ClassDAO extends MyDAO {

    public List<Class> getAllClasses() throws SQLException {
        List<Class> classes = new ArrayList<>();

        xSql = "select ClassID,ClassName\n"
                + "from Classes";

        ps = con.prepareStatement(xSql);
        rs = ps.executeQuery();
        while (rs.next()) {
            int id = rs.getInt("ClassID");
            String name = rs.getString("ClassName");
            Class c = new Class(id, name);
            classes.add(c);
        }

        return classes;
    }
}
