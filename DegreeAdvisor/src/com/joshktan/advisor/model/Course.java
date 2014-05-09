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
        StringBuilder courseStringBuilder = new StringBuilder();
        courseStringBuilder.append(courseId).append(" (").append(title).append(", ").append(credits).append(" credits");
        if (!grade.equals("NA")) {
            courseStringBuilder.append(", ").append(grade).append(")");
        } else {
            courseStringBuilder.append(")");
        }

        return courseStringBuilder.toString();
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
