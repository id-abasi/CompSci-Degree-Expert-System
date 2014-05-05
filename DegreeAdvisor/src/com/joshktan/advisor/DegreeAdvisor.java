package com.joshktan.advisor;

import com.joshktan.advisor.data.CourseDatabase;
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
    private CourseDatabase database;

    public DegreeAdvisor(CourseDatabase database) throws JessException {

        // Create a Jess rule engine
        brain = new Rete();
        brain.reset();

        // Load the pricing rules
        brain.batch("advisor.clp");

        // Load the catalog data into working memory
        brain.addAll(database.getCourses());

        // Mark end of catalog data for later
        marker = brain.mark();

    }

}
