package com.joshktan.advisor.req;

/**
 *
 * @author Josh Tan
 */
public abstract class UniversityRequirement extends Requirement {

    private static final String DESCRIPTION = "Stuff to fulfill University graduation requirements";
    
    public String getDescription() {
        return DESCRIPTION;
    }

}
