/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.joshktan.advisor.model;

import com.joshktan.advisor.model.Course.Grade;
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
            if (course.getGrade() != Grade.NA) {
                
                float courseCredits = course.getCredits();
                switch (course.getGrade()) {
                    case A:
                        totalGradePoints += 4 * courseCredits;
                        break;
                    case B:
                        totalGradePoints += 3 * courseCredits;
                        break;
                    case C:
                        totalGradePoints += 2 * courseCredits;
                        break;
                    case D:
                        totalGradePoints += 1 * courseCredits;
                        break;
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

}
