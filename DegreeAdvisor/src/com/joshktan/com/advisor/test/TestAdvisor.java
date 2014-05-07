package com.joshktan.com.advisor.test;

import com.joshktan.advisor.DegreeAdvisor;
import com.joshktan.advisor.data.UniversityDatabase;
import com.joshktan.advisor.model.Advice;
import com.joshktan.advisor.model.Congrats;
import com.joshktan.advisor.model.Course;
import com.joshktan.advisor.model.Record;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Iterator;
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

            // <test>
//            System.out.println("-- All courses --\n");
//            for (Course course : db.getCourses()) {
//                System.out.println(course);
//            }
//            System.out.println("");
//            for (Record record : db.getStudentRecords()) {
//                System.out.println("Student ID: " + record.getStudentId());
//                System.out.println("Total Credits: " + record.getTotalCredits());
//                Iterator<Course> courseIter = record.getStudentCoursesIter();
//                while (courseIter.hasNext()) {
//                    System.out.println(courseIter.next());
//                }
//            }
            // </test>            

            
            for (Record record : db.getStudentRecords()) {
                processStudentCourses(db, advisor, record.getStudentId());
            }

        } catch (JessException ex) {
            Logger.getLogger(TestAdvisor.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    private static void processStudentCourses(UniversityDatabase db, DegreeAdvisor advisor, int studentId) throws JessException {
        Iterator<Course> courseIter;
        Iterator<Advice> advice;
        Iterator<Congrats> congrats;
        System.out.println("-- Student ID "+ studentId + " --\n");
        System.out.println("Courses:");
        courseIter = db.getStudentRecord(studentId).getStudentCoursesIter();
        while (courseIter.hasNext()) {
            System.out.println(courseIter.next());
        }
        
        System.out.println("\nGPA: " + db.getStudentRecord(studentId).getGpa());

        HashMap<String, Iterator> feedback = advisor.run(studentId);
        advice = feedback.get("Advice");
        if (advice.hasNext()) {
            System.out.println("\nAdvice:");
        }
        
        while (advice.hasNext()) {
            System.out.println(advice.next());
        }
        
        congrats = feedback.get("Congrats");
        if (congrats.hasNext()) {
            System.out.println("");
        }
        
        while (congrats.hasNext()) {
            System.out.println(congrats.next());
        }
        System.out.println();
    }

}
