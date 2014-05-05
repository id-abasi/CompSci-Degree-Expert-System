package com.joshktan.advisor.model;

/**
 *
 * @author Josh Tan
 */
public class LabScienceSequence extends Course {

    public LabScienceSequence(String labCourseId, String labTitle, int labCredits, String courseId, String title, int credits) {
        super(courseId, title, credits);
        this.labCourseId = labCourseId;
        this.labTitle = labTitle;
        this.labCredits = labCredits;
    }

    private String labCourseId;

    private String labTitle;

    private int labCredits;

}
