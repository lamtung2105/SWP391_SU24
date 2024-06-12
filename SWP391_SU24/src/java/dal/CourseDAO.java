/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Course;
import model.Semester;

/**
 *
 * @author Acer
 */
public class CourseDAO extends MyDAO {

    public Course getCourseById(int id) throws SQLException {
        xSql = "Select * from Courses c "
                + "inner join Semesters s on c.SemesterID = s.SemesterID "
                + " where CourseID = ?";
        ps = con.prepareStatement(xSql);
        ps.setInt(1, id);
        rs = ps.executeQuery();
        if (!rs.next()) {
            return null;
        }
        return fromResultSet(rs);
    }

    public List<Course> getCoursesBySemester(int userID, int semesterId) {
        ArrayList<Course> list = new ArrayList<>();
        xSql = "SELECT c.*, s.SemesterDescription\n"
                + "FROM Courses c\n"
                + "INNER JOIN (\n"
                + "    SELECT DISTINCT c1.CourseID, s1.SemesterDescription\n"
                + "    FROM Courses c1\n"
                + "    INNER JOIN CourseAssignment ca ON c1.CourseID = ca.CourseID\n"
                + "    INNER JOIN Classes cl ON ca.ClassID = cl.ClassID\n"
                + "    INNER JOIN ClassAssignments cla ON cl.ClassID = cla.ClassID\n"
                + "    INNER JOIN Users u ON cla.UserID = u.UserID\n"
                + "    INNER JOIN Semesters s1 ON c1.SemesterID = s1.SemesterID\n"
                + "    WHERE u.UserID = ? \n"
                + "    AND c1.SemesterID = ? \n"
                + ") AS subquery ON c.CourseID = subquery.CourseID\n"
                + "INNER JOIN Semesters s ON c.SemesterID = s.SemesterID;";
        try {
            ps = con.prepareStatement(xSql);
            ps.setInt(1, userID);
            ps.setInt(2, semesterId);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(fromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Course> getAllCoursesBySemester(int semesterId) {
        ArrayList<Course> list = new ArrayList<>();
        xSql = "SELECT *\n"
                + "FROM Courses c\n"
                + "JOIN Semesters s ON s.SemesterID = c.SemesterID \n"
                + "WHERE c.SemesterID = ?";
        try {
            ps = con.prepareStatement(xSql);
            ps.setInt(1, semesterId);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(fromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Course> getAssignedCoursesById(int userID) {
        ArrayList<Course> list = new ArrayList<>();
        xSql = "SELECT c.*, s.SemesterDescription\n"
                + "FROM Courses c\n"
                + "INNER JOIN (\n"
                + "    SELECT DISTINCT c1.CourseID, s1.SemesterDescription\n"
                + "    FROM Courses c1\n"
                + "    INNER JOIN CourseAssignment ca ON c1.CourseID = ca.CourseID\n"
                + "    INNER JOIN Classes cl ON ca.ClassID = cl.ClassID\n"
                + "    INNER JOIN ClassAssignments cla ON cl.ClassID = cla.ClassID\n"
                + "    INNER JOIN Users u ON cla.UserID = u.UserID\n"
                + "    INNER JOIN Semesters s1 ON c1.SemesterID = s1.SemesterID\n"
                + "    WHERE u.UserID = ?\n"
                + ") AS subquery ON c.CourseID = subquery.CourseID\n"
                + "INNER JOIN Semesters s ON c.SemesterID = s.SemesterID;";
        try {
            ps = con.prepareStatement(xSql);
            ps.setInt(1, userID);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(fromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public ArrayList<Course> getCourse() {
        ArrayList<Course> list = new ArrayList<>();
        xSql = "SELECT * \n"
                + "FROM dbo.Courses c\n"
                + "JOIN dbo.Semesters s ON s.SemesterID = c.SemesterID";
        try {
            ps = con.prepareStatement(xSql);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(fromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public Course fromResultSet(ResultSet rs) throws SQLException {
        // Must join with category and semester
        Semester semester = new Semester(rs.getInt("SemesterID"), rs.getString("SemesterDescription"));
        Course c = new Course(rs.getInt("CourseID"), rs.getString("Title"), rs.getString("CourseDescription"), rs.getString("CourseBannerImage"), rs.getDate("PublishDate"), rs.getString("Lecturer"), semester);
        return c;
    }

    public Course insert(Course model) {
        try {
            xSql = "insert into Courses(CourseBannerImage, Title, CourseDescription, "
                    + "PublishDate, Lecturer, "
                    + "SemesterID)"
                    + " values(?,?,?,?,?,?)";
            ps = con.prepareStatement(xSql);
            int indexParam = 1;
            ps.setString(indexParam++, model.getImgUrl());
            ps.setString(indexParam++, model.getTitle());
            ps.setString(indexParam++, model.getDescription());
            ps.setDate(indexParam++, model.getPublishDate());
            ps.setString(indexParam++, model.getLecturer());
            ps.setInt(indexParam++, model.getSemester().getId());
            ps.executeUpdate();
            return model;
        } catch (SQLException ex) {
            Logger.getLogger(CourseDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
}
