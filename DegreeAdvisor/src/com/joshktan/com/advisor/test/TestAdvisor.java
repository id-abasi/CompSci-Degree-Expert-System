package com.joshktan.com.advisor.test;

import com.joshktan.advisor.DegreeAdvisor;
import com.joshktan.advisor.data.CourseDatabase;
import com.joshktan.advisor.model.Record;
import jess.JessException;

/**
 * Load test records from database and elicit advisor feedback.
 *
 * @author Josh Tan
 */
public class TestAdvisor {

    public static void main(String[] args) {
        try {

            // create record (TODO)
            Record testRecord1 = new Record();
            CourseDatabase db = new CourseDatabase();
            DegreeAdvisor advisor = new DegreeAdvisor(db); // TODO

//            processOrder(database, engine, 123);
//            processOrder(database, engine, 567);
//            processOrder(database, engine, 666);
        } catch (JessException e) {
            e.printStackTrace();
        }

    }

}
