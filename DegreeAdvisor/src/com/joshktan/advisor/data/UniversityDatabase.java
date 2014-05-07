package com.joshktan.advisor.data;

import com.joshktan.advisor.model.Course;
import com.joshktan.advisor.model.GradedCourse;
import com.joshktan.advisor.model.Record;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collection;

/**
 *
 * @author Josh Tan
 */
public class UniversityDatabase implements IUniversityDatabase {

    private static final String DRIVER_CLASS = "org.sqlite.JDBC";
    private static final String DB_FILE = "jdbc:sqlite:data//university.db3";

    private Connection dbConnection;

    public UniversityDatabase() throws ClassNotFoundException, SQLException {
        Class.forName(DRIVER_CLASS);
        dbConnection = DriverManager.getConnection(DB_FILE);
    }

    @Override
    public Collection<Course> getCourses() {

        Statement retrieveCoursesStmt;
        String query = "SELECT * FROM Courses";

        Collection<Course> courses = new ArrayList<Course>();

        try {

            retrieveCoursesStmt = dbConnection.createStatement();
            ResultSet rset = retrieveCoursesStmt.executeQuery(query);

            while (rset.next()) {

                String courseId = rset.getString("Id");
                String title = rset.getString("Title");
                int credits = rset.getInt("Credits");

                Course retrievedCourse = new Course(courseId, title, credits);                
                courses.add(retrievedCourse);

            }

            retrieveCoursesStmt.close();
            rset.close();

        } catch (SQLException e) {
            System.err.println(e);
        }

        return courses;
    }

    @Override
    public Course getCourse(String courseId) {

        PreparedStatement retrieveCourseStmt;
        String query = "SELECT * FROM Courses where Id = ?";

        Course retrievedCourse = null;

        try {

            retrieveCourseStmt = dbConnection.prepareStatement(query);
            retrieveCourseStmt.setString(1, courseId);

            ResultSet rset = retrieveCourseStmt.executeQuery();

            while (rset.next()) {

                String title = rset.getString("Title");
                int credits = rset.getInt("Credits");

                retrievedCourse = new Course(courseId, title, credits);

            }

            retrieveCourseStmt.close();
            rset.close();

        } catch (SQLException e) {
            System.err.println(e);
        }

        return retrievedCourse;

    }

    @Override
    public Collection<Record> getStudentRecords() {

        Statement retrieveStudentsStmt;
        String query = "SELECT * FROM Students";

        Collection<Record> records = new ArrayList<Record>();

        try {

            retrieveStudentsStmt = dbConnection.createStatement();
            ResultSet rset = retrieveStudentsStmt.executeQuery(query);

            while (rset.next()) {

                int studentId = rset.getInt("StudentId");
                Record retrievedRecord = getStudentRecord(studentId);

                records.add(retrievedRecord);

            }

            retrieveStudentsStmt.close();
            rset.close();

        } catch (SQLException e) {
            System.err.println(e);
        }

        return records;
    }

    @Override
    public Record getStudentRecord(int studentId) {

        PreparedStatement retrieveRecordStmt;
        String query = "SELECT * FROM Records WHERE StudentId = ?";

        Record record = new Record(studentId);

        try {

            retrieveRecordStmt = dbConnection.prepareStatement(query);
            retrieveRecordStmt.setInt(1, studentId);

            ResultSet rset = retrieveRecordStmt.executeQuery();

            while (rset.next()) {

                String courseId = rset.getString("CourseId");
                String grade = rset.getString("Grade");

                Course retrievedCourse = getCourse(courseId);

                if (!grade.equals("NA")) { // if this course has been graded
                    retrievedCourse = new GradedCourse(grade, retrievedCourse);
                }

                record.addCourse(retrievedCourse);
            }

            retrieveRecordStmt.close();
            rset.close();

        } catch (SQLException e) {
            System.err.println(e);
        }

        return record;
    }

    @Override
    public Collection<Course> getCourses(String dept) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public Course getGenEdCourses(String area) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public Collection<Course> getElectives(String area) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public Collection<Course> getRelatedRequiredCourses() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public Collection<Course> getValidAdditionalHumanitiesSocialSciences(Record studentRecord) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public Collection<Course> getValidAdditionlGenEdScienceCourses(Record studentRecord) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

}
