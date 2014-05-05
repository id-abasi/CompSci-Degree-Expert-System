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
public class CourseGrade {
    
    private String courseID;
    
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
