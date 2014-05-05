package com.joshktan.com.advisor.test;

import com.joshktan.advisor.DegreeAdvisor;
import com.joshktan.advisor.data.UniversityDatabase;
import com.joshktan.advisor.model.Advice;
import com.joshktan.advisor.model.Course;
import com.joshktan.advisor.model.Record;
import java.sql.SQLException;
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

    public static void main(String[] args) throws JessException { // BAD, catch this
        try {

            // create record (TODO)
            
            UniversityDatabase db = new UniversityDatabase();
//            Record testRecord1 = db.getStudentRecord(1);
            DegreeAdvisor advisor = new DegreeAdvisor(db); // TODO
            
            // <test>
            for (Course course : db.getCourses()) {
                System.out.println(course);
            }
            System.out.println("");
            for (Record record : db.getStudentRecords()) {
                System.out.println("Student ID: " + record.getStudentId());
                System.out.println("Total Credits: " + record.getTotalCredits());
                Iterator<Course> courseIter = record.getStudentCoursesIter();
                while (courseIter.hasNext()) {
                    System.out.println(courseIter.next());
                }
                
            }
            // </test>            

//            processOrder(database, engine, 123);
//            processOrder(database, engine, 567);
//            processOrder(database, engine, 666);
            
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(TestAdvisor.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(TestAdvisor.class.getName()).log(Level.SEVERE, null, ex);
        } 
//        catch (JessException ex) {
//            Logger.getLogger(TestAdvisor.class.getName()).log(Level.SEVERE, null, ex);
//        }

    }
    
    private static void processStudentCourses(UniversityDatabase db, DegreeAdvisor advisor, int studentId) throws JessException{
                Iterator<Course> courseIter;
		Iterator<Advice> advice;
		System.out.println("Courses for student ID " + studentId + ":");
		courseIter = db.getStudentRecord(studentId).getStudentCoursesIter();
		while (courseIter.hasNext()) {
			System.out.println("   " + courseIter.next());
		}			
		
		advice = advisor.run(studentId);
		System.out.println("Advice for requirement " + "blah" + ":");
		while (advice.hasNext()) {
			System.out.println("   " + advice.next());
		}
		System.out.println();
    }

}
