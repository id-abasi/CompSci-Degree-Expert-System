package com.joshktan.advisor.model;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

/**
 *
 * @author jdot
 */
public class Record {

    private List<Course> studentCourses;
    private int studentId;
    private int totalCredits;
    private float gpa;

    public Record(int studentId) {
        this.studentId = studentId;
        studentCourses = new ArrayList<Course>();
    }

    public float getGpa() {
        float totalGradePoints = 0;
        for (Course course : studentCourses) {
            if (course.getGrade() != "NA") {
                
                float courseCredits = course.getCredits();
                if (course.getGrade().equals("A")){ 
                    totalGradePoints += 4 * courseCredits;
                } else if (course.getGrade().equals("B")) {
                    totalGradePoints += 3 * courseCredits;
                } else if (course.getGrade().equals("C")) {
                    totalGradePoints += 2 * courseCredits;
                } else if (course.getGrade().equals("D")) {
                    totalGradePoints += 1 * courseCredits;
                }
            }
        }
        return totalGradePoints / totalCredits;
    }

    public int getTotalCredits() {
        return totalCredits;
    }

    public Iterator<Course> getStudentCoursesIter() {
        return studentCourses.iterator();
    }

    public int getStudentId() {
        return studentId;
    }

    public void addCourse(Course course) {
        studentCourses.add(course);
        totalCredits += course.getCredits();
        gpa = getGpa();

    }

    public List<Course> getStudentCourses() {
        return studentCourses;
    }
    
    

}
