package com.joshktan.advisor.req;

/**
 *
 * @author Josh Tan
 */
public class GenEdRequirement extends Requirement {

    @Override
    public String getName() {
        return "General Education Requirement";
    }

    @Override
    public String getDescription() {
        return "General education requirements that apply to all students in pursuit of a baccalaureate degree.";
    }

}
