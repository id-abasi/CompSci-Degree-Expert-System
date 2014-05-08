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

    private String grade;

    public Course(String courseId, String title, int credits, String grade) {
        this.courseId = courseId;
        this.title = title;
        this.credits = credits;
        this.grade = grade;
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


    public String getGrade() {
        return grade;
    }

    public void setGrade(String grade) {
        this.grade = grade;
    }
    
    
}
