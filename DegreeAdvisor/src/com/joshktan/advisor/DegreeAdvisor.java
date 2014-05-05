package com.joshktan.advisor;

import com.joshktan.advisor.data.UniversityDatabase;
import com.joshktan.advisor.model.Advice;
import com.joshktan.advisor.model.Record;
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
    private UniversityDatabase database;

    public DegreeAdvisor(UniversityDatabase database) throws JessException {

        // Create a Jess rule engine
        brain = new Rete();
        brain.reset();

        // Load the pricing rules
        brain.batch("advisor.clp");

        // Load the catalog data into working memory
        this.database = database;
        brain.addAll(database.getCourses());

        // Mark end of catalog data for later
        marker = brain.mark();

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
    
    public Iterator run(int studentId) throws JessException {
        // Remove any previous order data, leaving only catalog data
    	brain.resetToMark(marker);
    	
    	// Load data for this order
        loadStudentData(studentId);
        
        // Fire the rules that apply to this order
        brain.run();
        
        // Return the list of offers created by the rules
        return brain.getObjects(new Filter.ByClass(Advice.class));
    }

}
