package com.joshktan.advisor.data;

import com.joshktan.advisor.model.Course;
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
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
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
    private Map<String, Collection<Course>> genEdAreaToCoursesMap;
    private Map<String, String> genEdCourseIdToAreaMap;
    private Collection<String> coreCoursesIds;
    private Map<String, String> electiveCourseIdToCategoryMap;

    private UniversityDatabase() {

        try {
            Class.forName(DRIVER_CLASS);
            dbConnection = DriverManager.getConnection(DB_FILE);

            // initialize courses data (to avoid excessive querying to database)
            genEdAreaToCoursesMap = new HashMap<String, Collection<Course>>();
            genEdCourseIdToAreaMap = new HashMap<String, String>();
            initializeGenEdCourses();

            coreCoursesIds = new ArrayList<String>();
            initializeCoreCourses();

            electiveCourseIdToCategoryMap = new HashMap<String, String>();
            initializeElectiveCourses();

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

    public boolean electiveCategoryReqSatsified(int studentId) {

        Set<String> categoriesSatisfied = new HashSet<String>();
        List<Course> studentCourses = getStudentRecord(studentId).getStudentCourses();
        for (Course course : studentCourses) {
            categoriesSatisfied.add(electiveCourseIdToCategoryMap.get(course.getCourseId()));
        }

        return categoriesSatisfied.size() >= 2;
    }

    public boolean additionalHumanSocialSciSatisfied(int studentId) {

        PreparedStatement retrieveCreditsStmt;
        String query = "SELECT Credits from COURSES C WHERE C.Id IN "
                + "(SELECT CourseId FROM Records WHERE StudentId == ?) "
                + "AND ( "
                + "(C.Id LIKE 'ADHM%' OR "
                + "C.Id LIKE 'ANTH%' OR "
                + "C.Id LIKE 'ARCH%' OR "
                + "C.Id LIKE 'ART%' OR "
                + "C.Id LIKE 'CJ%' OR "
                + "C.Id LIKE 'CLAS%' OR "
                + "C.Id LIKE 'COMM%' OR "
                + "C.Id LIKE 'ECON%' OR "
                + "C.Id LIKE 'ENGL%' OR "
                + "C.Id LIKE 'FREN%' OR "
                + "C.Id LIKE 'GEOG%' OR "
                + "C.Id LIKE 'GERM%' OR "
                + "C.Id LIKE 'HDFS%' OR "
                + "C.Id LIKE 'HIST%' OR "
                + "C.Id LIKE 'LA%' OR "
                + "C.Id LIKE 'LANG%' OR "
                + "C.Id LIKE 'MUSC%' OR "
                + "C.Id LIKE 'PHIL%' OR "
                + "C.Id LIKE 'POLS%' OR "
                + "C.Id LIKE 'PSYC%' OR "
                + "C.Id LIKE 'RELS%' OR "
                + "C.Id LIKE 'SOC%' OR "
                + "C.Id LIKE 'SPAN%' OR "
                + "C.Id LIKE 'THEA%' OR "
                + "C.Id LIKE 'WGS%') "
                + "OR (C.Id IN "
                + "(SELECT Id FROM GenEdCourses WHERE Area == 'A' OR Area == 'B')))";

        int totalCredits = 0;

        try {

            retrieveCreditsStmt = dbConnection.prepareStatement(query);
            retrieveCreditsStmt.setInt(1, studentId);

            ResultSet rset = retrieveCreditsStmt.executeQuery();

            while (rset.next()) {

                int credits = rset.getInt("Credits");
                
                totalCredits += credits;
            }

            retrieveCreditsStmt.close();
            rset.close();

        } catch (SQLException e) {
            System.err.println(e);
        }

        return totalCredits >= 21;
    }

    public boolean coreCoursesSatsified(int studentId) {

        List<String> coursesTaken = getStudentCourseIds(studentId);
        for (String id : coreCoursesIds) {
            if (!coursesTaken.contains(id)) {
                return false;
            }
        }
        return true;
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
                retrievedCourse.setGrade(grade);

                record.addCourse(retrievedCourse);
            }

            retrieveRecordStmt.close();
            rset.close();

        } catch (SQLException e) {
            System.err.println(e);
        }

        return record;
    }

    public List<String> getStudentCourseIds(int studentId) {

        PreparedStatement retrieveRecordStmt;
        String query = "SELECT CourseId FROM Records WHERE StudentId = ?";

        ArrayList<String> courseIds = new ArrayList<String>();

        try {

            retrieveRecordStmt = dbConnection.prepareStatement(query);
            retrieveRecordStmt.setInt(1, studentId);

            ResultSet rset = retrieveRecordStmt.executeQuery();

            while (rset.next()) {

                String courseId = rset.getString("CourseId");
                courseIds.add(courseId);
            }

            retrieveRecordStmt.close();
            rset.close();

        } catch (SQLException e) {
            System.err.println(e);
        }

        return courseIds;
    }

    @Override
    public Collection<Course> getCourses(String dept) {

        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.

    }

    private void initializeCoreCourses() {
        coreCoursesIds.add("CSCI 160");
        coreCoursesIds.add("CSCI 161");
        coreCoursesIds.add("CSCI 213");
        coreCoursesIds.add("CSCI 222");
        coreCoursesIds.add("CSCI 313");
        coreCoursesIds.add("CSCI 336");
        coreCoursesIds.add("CSCI 366");
        coreCoursesIds.add("CSCI 372");
        coreCoursesIds.add("CSCI 374");
        coreCoursesIds.add("CSCI 415");
        coreCoursesIds.add("CSCI 445");
        coreCoursesIds.add("CSCI 467");
        coreCoursesIds.add("CSCI 474");
        coreCoursesIds.add("CSCI 489");
    }

    private void initializeElectiveCourses() {

        Statement retrieveElectivesStmt;
        String query = "SELECT * FROM ElectiveCourses";

        try {

            retrieveElectivesStmt = dbConnection.createStatement();
            ResultSet rset = retrieveElectivesStmt.executeQuery(query);

            while (rset.next()) {

                String courseId = rset.getString("Id");
                String category = rset.getString("Category");

                electiveCourseIdToCategoryMap.put(courseId, category);
            }

            retrieveElectivesStmt.close();
            rset.close();

        } catch (SQLException e) {
            System.err.println(e);
        }
    }

    private void initializeGenEdCourses() {

        Collection<Course> firstYearExp = new ArrayList<Course>();
        genEdAreaToCoursesMap.put("F", firstYearExp);
        Collection<Course> comm = new ArrayList<Course>();
        genEdAreaToCoursesMap.put("C", comm);
        Collection<Course> quant = new ArrayList<Course>();
        genEdAreaToCoursesMap.put("R", quant);
        Collection<Course> science = new ArrayList<Course>();
        genEdAreaToCoursesMap.put("S", science);
        Collection<Course> human = new ArrayList<Course>();
        genEdAreaToCoursesMap.put("A", human);
        Collection<Course> social = new ArrayList<Course>();
        genEdAreaToCoursesMap.put("B", social);
        Collection<Course> wellness = new ArrayList<Course>();
        genEdAreaToCoursesMap.put("W", wellness);
        Collection<Course> diversity = new ArrayList<Course>();
        genEdAreaToCoursesMap.put("D", diversity);
        Collection<Course> global = new ArrayList<Course>();
        genEdAreaToCoursesMap.put("G", global);

        Statement retrieveGenEdStmt;
        String query = "SELECT * FROM GenEdCourses";

        try {

            retrieveGenEdStmt = dbConnection.createStatement();
            ResultSet rset = retrieveGenEdStmt.executeQuery(query);

            while (rset.next()) {

                String courseId = rset.getString("Id");
                String area = rset.getString("Area");
                Course retrievedCourse = getCourse(courseId);

                genEdAreaToCoursesMap.get(area).add(retrievedCourse);
                genEdCourseIdToAreaMap.put(courseId, area);

            }

            retrieveGenEdStmt.close();
            rset.close();

        } catch (SQLException e) {
            System.err.println(e);
        }

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
        return genEdAreaToCoursesMap;
    }

    public boolean isCoreCourse(String courseId) {

        return coreCoursesIds.contains(courseId);
    }

    public boolean isElectiveCourse(String courseId) {

        return electiveCourseIdToCategoryMap.keySet().contains(courseId);
    }

    public boolean isGenEd(String courseId, String genEdArea) {

        return genEdCourseIdToAreaMap.containsKey(courseId)
                && genEdCourseIdToAreaMap.get(courseId).equals(genEdArea);

//        PreparedStatement retrieveCreditsStmt;
//        String query = "SELECT * FROM GenEdCourses WHERE Id = ? AND Area = ?";
//
//        boolean found = false;
//
//        try {
//
//            retrieveCreditsStmt = dbConnection.prepareStatement(query);
//            retrieveCreditsStmt.setString(1, courseId);
//            retrieveCreditsStmt.setString(2, genEdArea);
//
//            ResultSet rset = retrieveCreditsStmt.executeQuery();
//
//            if (rset.next()) {
//                found = true;
//            }
//
//            retrieveCreditsStmt.close();
//            rset.close();
//
//        } catch (SQLException e) {
//            System.err.println(e);
//        }
//
//        return found;
    }

    public boolean isLabScienceSequence(String courseOneId, String courseOneLabId,
            String courseTwoId, String courseTwoLabId) {

        PreparedStatement retrieveRecordStmt;
        String query = "SELECT * FROM LabScienceSequence WHERE CourseOneId = ?"
                + " AND CourseOneLabId = ? AND CourseTwoId = ? AND CourseTwoLabId = ?";

        boolean found = false;

        try {

            retrieveRecordStmt = dbConnection.prepareStatement(query);
            retrieveRecordStmt.setString(1, courseOneId);
            retrieveRecordStmt.setString(2, courseOneLabId);
            retrieveRecordStmt.setString(3, courseTwoId);
            retrieveRecordStmt.setString(4, courseTwoLabId);

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
