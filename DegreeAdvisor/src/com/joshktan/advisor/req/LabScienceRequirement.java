package com.joshktan.advisor.req;

/**
 *
 * @author Josh Tan
 */
public class LabScienceRequirement extends Requirement {

    @Override
    public String getName() {
        return "One Year Lab Science Sequence Requirement";
    }

    @Override
    public String getDescription() {
        return "A one year sequence of lab science courses (with corresponding labs) is required.";
    }

    
}
