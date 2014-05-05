package com.joshktan.advisor;

/**
 *
 * @author Josh Tan
 */
public class Course {
    
    private String courseId;
    
    private String title;
    private int credits;
    private Grade grade;
    
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
}