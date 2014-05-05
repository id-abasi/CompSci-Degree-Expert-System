/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.joshktan.advisor.model;

/**
 *
 * @author jdot
 */
public class GradedCourse extends Course {

    private Grade grade;

    public GradedCourse(String grade, String courseId, String title, int credits) {
        super(courseId, title, credits);
        this.grade = Grade.valueOf(grade);
    }

    public GradedCourse(String grade, Course course) {
        this(grade, course.getCourseId(), course.getTitle(), course.getCredits());
    }

    public enum Grade {

        A,
        B,
        C,
        D,
        F,
        I,
        AU,
        WAU,
        P,
        S,
        U,
        NC,
        NR,
        WF,
        WP,
        W,
        NONE
    }

    @Override
    public String toString() {
        return super.getCourseId() + " (" + super.getTitle() + ", " + super.getCredits() + " credits, " + grade + ")";
    }
}
