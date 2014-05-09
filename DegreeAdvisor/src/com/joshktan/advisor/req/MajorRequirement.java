package com.joshktan.advisor.req;

/**
 *
 * @author Josh Tan
 */
public class MajorRequirement extends Requirement {

    @Override
    public String getName() {
        return "B.S. Computer Science Requirements";
    }

    @Override
    public String getDescription() {
        return "Requirements needed to receive a B.S. Computer Science degree.";
    }

}
