package com.joshktan.advisor.model;

import com.joshktan.advisor.data.UniversityDatabase;

/**
 *
 * @author Josh Tan
 */
public class Course {

    private String courseId;

    private String title;
    private int credits;

    private Grade grade;

    public Course(String courseId, String title, int credits, String grade) {
        this.courseId = courseId;
        this.title = title;
        this.credits = credits;
        this.grade = Grade.valueOf(grade);
    }

    public String getCourseId() {
        return courseId;
    }

    public String getTitle() {
        return title;
    }

    public int getCredits() {
        return credits;
    }

    @Override
    public String toString() {
        return courseId + " (" + title + ", " + credits + " credits)";
    }

    public boolean isGenEd(String area) {
        return UniversityDatabase.getDatabase().getGenEdCourseMap().get(area).contains(this);
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
        NA
    }

    public Grade getGrade() {
        return grade;
    }

    public void setGrade(Grade grade) {
        this.grade = grade;
    }
    
    
}
