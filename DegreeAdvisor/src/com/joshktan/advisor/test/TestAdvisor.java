package com.joshktan.advisor.test;

import com.joshktan.advisor.DegreeAdvisor;
import com.joshktan.advisor.data.UniversityDatabase;
import com.joshktan.advisor.model.Advice;
import com.joshktan.advisor.model.Congrats;
import com.joshktan.advisor.model.Course;
import com.joshktan.advisor.model.Record;
import com.joshktan.advisor.req.BachelorScienceRequirement;
import com.joshktan.advisor.req.CollegeRequirement;
import com.joshktan.advisor.req.GenEdRequirement;
import com.joshktan.advisor.req.MajorRequirement;
import com.joshktan.advisor.req.RelatedRequirement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import jess.JessException;

/**
 * Load test records from database and elicit advisor feedback.
 *
 * @author Josh Tan
 */
public class TestAdvisor {

    private static UniversityDatabase db;

    public static void main(String[] args) {
        try {

            DegreeAdvisor advisor = new DegreeAdvisor();
            db = UniversityDatabase.getDatabase();

            for (Record record : db.getStudentRecords()) {
                processStudentCourses(db, advisor, record.getStudentId());
                System.out.println("\n");
            }

        } catch (JessException ex) {
            Logger.getLogger(TestAdvisor.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    private static void processStudentCourses(UniversityDatabase db, DegreeAdvisor advisor, int studentId) throws JessException {
        Iterator<Course> courseIter;
        Iterator<Congrats> congrats;

        List<Advice> genEdAdvice = new ArrayList<Advice>();
        List<Advice> bachelorScienceAdvice = new ArrayList<Advice>();
        List<Advice> collegeAdvice = new ArrayList<Advice>();
        List<Advice> majorAdvice = new ArrayList<Advice>();
        List<Advice> relatedAdvice = new ArrayList<Advice>();

        System.out.println("-- Student ID " + studentId + " --\n");
        System.out.println("Courses:");
        courseIter = db.getStudentRecord(studentId).getStudentCoursesIter();
        while (courseIter.hasNext()) {
            System.out.println(courseIter.next());
        }

        Record studentRecord = db.getStudentRecord(studentId);
        System.out.println("\nGPA: " + studentRecord.getGpa() + "\n");

        HashMap<String, Iterator> feedback = null;
        feedback = advisor.run(studentRecord);

        if (feedback != null) {
            System.out.println("======== BAD NEWS ========\n");
            Iterator<Advice> advice = feedback.get("Advice");
            if (!advice.hasNext()) {
                System.out.println("No bad news! =D");
            }

            while (advice.hasNext()) {
                Advice reqAdvice = advice.next();
                if (reqAdvice.getRequirement() instanceof BachelorScienceRequirement) {
                    bachelorScienceAdvice.add(reqAdvice);
                } else if (reqAdvice.getRequirement() instanceof CollegeRequirement) {
                    collegeAdvice.add(reqAdvice);
                } else if (reqAdvice.getRequirement() instanceof GenEdRequirement) {
                    genEdAdvice.add(reqAdvice);
                } else if (reqAdvice.getRequirement() instanceof MajorRequirement) {
                    majorAdvice.add(reqAdvice);
                } else if (reqAdvice.getRequirement() instanceof RelatedRequirement) {
                    relatedAdvice.add(reqAdvice);
                }

            }

            // print bad news
            if (!genEdAdvice.isEmpty()) {
                System.out.println("GENERAL EDUCATION REQUIREMENTS:\n");
                for (Advice advisorAdvice : genEdAdvice) {
                    System.out.println(advisorAdvice.toString() + "\n");
                }
                System.out.println("");
            }

            if (!majorAdvice.isEmpty()) {
                System.out.println("B.S. COMPUTER SCIENCE REQUIREMENTS:\n");
                for (Advice advisorAdvice : majorAdvice) {
                    System.out.println(advisorAdvice.toString() + "\n");
                }
                System.out.println();
            }

            if (!relatedAdvice.isEmpty()) {
                System.out.println("RELATED COURSES REQUIREMENTS:\n");
                for (Advice advisorAdvice : relatedAdvice) {
                    System.out.println(advisorAdvice.toString() + "\n");
                }
                System.out.println();
            }

            if (!bachelorScienceAdvice.isEmpty()) {
                System.out.println("B.S. DEGREE REQUIREMENTS:\n");
                for (Advice advisorAdvice : bachelorScienceAdvice) {
                    System.out.println(advisorAdvice.toString() + "\n");
                }
                System.out.println();
            }

            if (!collegeAdvice.isEmpty()) {
                System.out.println("COLLEGE OF SCIENCE & MATHEMATICS REQUIREMENTS:\n");
                for (Advice advisorAdvice : collegeAdvice) {
                    System.out.println(advisorAdvice.toString() + "\n");
                }
            }

            System.out.println("");

            congrats = feedback.get("Congrats");
            System.out.println("======== GOOD NEWS ========\n");
            if (!congrats.hasNext()) {
                System.out.println("No good news. =(");
            } else {

                while (congrats.hasNext()) {
                    System.out.println(congrats.next().toString() + "\n");
                }
            }
        }

    }

}
