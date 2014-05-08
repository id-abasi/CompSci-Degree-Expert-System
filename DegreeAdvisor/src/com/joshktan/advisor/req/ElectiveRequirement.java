package com.joshktan.advisor.req;

/**
 *
 * @author Josh Tan
 */
public class ElectiveRequirement extends Requirement {

    @Override
    public String getName() {
        return "Computer Science Elective Requirement.";
    }

    @Override
    public String getDescription() {
        return "At least 3 courses CS elective courses are required. No more than 2 courses may come from ny single category.";
    }
    
}
