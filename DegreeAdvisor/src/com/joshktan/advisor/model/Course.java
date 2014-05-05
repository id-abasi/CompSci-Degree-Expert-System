package com.joshktan.advisor.model;

/**
 *
 * @author Josh Tan
 */
public class Course {

    private String courseId;

    private String title;
    private int credits;

    public Course(String courseId, String title, int credits) {
        this.courseId = courseId;
        this.title = title;
        this.credits = credits;
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

}
