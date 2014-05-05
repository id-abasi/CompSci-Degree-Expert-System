/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
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

    public Record(int studentId) {
        this.studentId = studentId;
        studentCourses = new ArrayList<Course>();
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

    }

}
