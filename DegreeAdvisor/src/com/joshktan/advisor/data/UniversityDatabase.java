package com.joshktan.advisor.data;

import com.joshktan.advisor.model.Course;
import com.joshktan.advisor.model.Course.Grade;
import com.joshktan.advisor.model.Record;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Josh Tan
 */
public class UniversityDatabase implements IUniversityDatabase {

    private static final String DRIVER_CLASS = "org.sqlite.JDBC";
    private static final String DB_FILE = "jdbc:sqlite:data//university.db3";

    private static UniversityDatabase db; // singleton

    private Connection dbConnection;
    private Map<String, Collection<Course>> genEdCourseMap;

    private UniversityDatabase() {

        try {
            Class.forName(DRIVER_CLASS);
            dbConnection = DriverManager.getConnection(DB_FILE);

            initializeGenEdCourseMap();

        } catch (ClassNotFoundException ex) {
            Logger.getLogger(UniversityDatabase.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(UniversityDatabase.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public static UniversityDatabase getDatabase() {
        if (db == null) {
            return new UniversityDatabase();
        } else {
            return db;
        }
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

                Course retrievedCourse = new Course(courseId, title, credits, "NA");
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

                retrievedCourse = new Course(courseId, title, credits, "NA");

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
                retrievedCourse.setGrade(Grade.valueOf(grade));

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

    private void initializeGenEdCourseMap() {

        Map<String, Collection<Course>> genEdMap = new HashMap<String, Collection<Course>>();

        Collection<Course> firstYearExp = new ArrayList<Course>();
        genEdMap.put("F", firstYearExp);
        Collection<Course> comm = new ArrayList<Course>();
        genEdMap.put("C", comm);
        Collection<Course> quant = new ArrayList<Course>();
        genEdMap.put("R", quant);
        Collection<Course> science = new ArrayList<Course>();
        genEdMap.put("S", science);
        Collection<Course> human = new ArrayList<Course>();
        genEdMap.put("A", human);
        Collection<Course> social = new ArrayList<Course>();
        genEdMap.put("B", social);
        Collection<Course> wellness = new ArrayList<Course>();
        genEdMap.put("W", wellness);
        Collection<Course> diversity = new ArrayList<Course>();
        genEdMap.put("D", diversity);
        Collection<Course> global = new ArrayList<Course>();
        genEdMap.put("G", global);

        Statement retrieveGenEdStmt;
        String query = "SELECT * FROM GenEdCourses";

        try {

            retrieveGenEdStmt = dbConnection.createStatement();
            ResultSet rset = retrieveGenEdStmt.executeQuery(query);

            while (rset.next()) {

                String courseId = rset.getString("Id");
                String area = rset.getString("Area");
                Course retrievedCourse = getCourse(courseId);

                genEdMap.get(area).add(retrievedCourse);
            }

            retrieveGenEdStmt.close();
            rset.close();

        } catch (SQLException e) {
            System.err.println(e);
        }

        genEdCourseMap = genEdMap;
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

    public Map<String, Collection<Course>> getGenEdCourseMap() {
        return genEdCourseMap;
    }
    
    public boolean isGenEd(String courseId, String genEdArea) {
        
        PreparedStatement retrieveRecordStmt;
        String query = "SELECT * FROM GenEdCourses WHERE Id = ? AND Area = ?";

        boolean found = false;

        try {

            retrieveRecordStmt = dbConnection.prepareStatement(query);
            retrieveRecordStmt.setString(1, courseId);
            retrieveRecordStmt.setString(2, genEdArea);

            ResultSet rset = retrieveRecordStmt.executeQuery();

            if (rset.next()) {
                found = true;
            }

            retrieveRecordStmt.close();
            rset.close();

        } catch (SQLException e) {
            System.err.println(e);
        }

        return found;
    }

}
