package com.joshktan.advisor;

import com.joshktan.advisor.data.UniversityDatabase;
import com.joshktan.advisor.jess.AdditionalHumanSocSciFunction;
import com.joshktan.advisor.jess.CoreCoursesSatsifiedFunction;
import com.joshktan.advisor.jess.ElectiveCategoryReqFunction;
import com.joshktan.advisor.jess.IsElectiveCourseFunction;
import com.joshktan.advisor.jess.IsGenEdCourseFunction;
import com.joshktan.advisor.model.Advice;
import com.joshktan.advisor.model.Congrats;
import com.joshktan.advisor.model.Record;
import java.util.HashMap;
import java.util.Iterator;
import jess.Filter;
import jess.JessException;
import jess.Rete;
import jess.WorkingMemoryMarker;

/**
 *
 * @author Josh Tan
 */
public class DegreeAdvisor {

    private Rete brain;
    private WorkingMemoryMarker marker;
    private final UniversityDatabase database;

    public DegreeAdvisor() throws JessException {

        // Create a Jess rule engine
        brain = new Rete();
        brain.reset();

        // Load the pricing rules
        brain.batch("advisor.clp");
        loadUserFunctions(brain);

        // Load the catalog data into working memory
        this.database = UniversityDatabase.getDatabase();

        // Mark end of catalog data for later
        marker = brain.mark();

    }

    public void recreate() throws JessException {
        brain = new Rete();
        brain.clear();
        brain.reset();

        // Load the pricing rules and functions
        brain.batch("advisor.clp");
        loadUserFunctions(brain);

        // Mark end of catalog data for later
        marker = brain.mark();
    }

    private void loadUserFunctions(Rete brain) {
        brain.addUserfunction(new IsGenEdCourseFunction());
        brain.addUserfunction(new CoreCoursesSatsifiedFunction());
        brain.addUserfunction(new ElectiveCategoryReqFunction());
        brain.addUserfunction(new IsElectiveCourseFunction());
        brain.addUserfunction(new AdditionalHumanSocSciFunction());
    }

    private void loadStudentData(int studentId) throws JessException {

        // Retreive record from database
        Record record = database.getStudentRecord(studentId);

        if (record != null) {
            // Add the order and its contents to working memory
            brain.add(record);
            brain.add(record.getStudentId());
            brain.addAll(record.getStudentCoursesIter());
        }
    }

    private void loadStudentData(Record studentRecord) throws JessException {

        if (studentRecord != null) {
            // Add the order and its contents to working memory
            brain.add(studentRecord);
            brain.addAll(studentRecord.getStudentCoursesIter());
        }
    }

    public HashMap<String, Iterator> run(int studentId) throws JessException {
        // Remove any previous order data, leaving only catalog data
        // recreate, since reset() does not delete definstances
        // (see: http://osdir.com/ml/java-jess/2010-06/msg00012.html)

        recreate();

        // Load data for this order
        loadStudentData(studentId);

        // Fire the rules that apply to this order
        brain.run();

        // Return the list of offers created by the rules
        HashMap<String, Iterator> feedback = new HashMap<String, Iterator>();
        feedback.put("Advice", brain.getObjects(new Filter.ByClass(Advice.class)));
        feedback.put("Congrats", brain.getObjects(new Filter.ByClass(Congrats.class)));

        return feedback;
    }

    public HashMap<String, Iterator> run(Record studentRecord) throws JessException {
        // Remove any previous order data, leaving only catalog data
        // recreate, since reset() does not delete definstances
        // (see: http://osdir.com/ml/java-jess/2010-06/msg00012.html)

        recreate();

        // Load data for this order
        loadStudentData(studentRecord);

        // Fire the rules that apply to this order
        brain.run();

        // Return the list of offers created by the rules
        HashMap<String, Iterator> feedback = new HashMap<String, Iterator>();
        feedback.put("Advice", brain.getObjects(new Filter.ByClass(Advice.class)));
        feedback.put("Congrats", brain.getObjects(new Filter.ByClass(Congrats.class)));
        return feedback;
    }

}
