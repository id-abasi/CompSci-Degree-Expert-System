package com.joshktan.advisor.req;

/**
 *
 * @author Josh Tan
 */
public class CollegeRequirement extends Requirement {

    @Override
    public String getName() {
        return "College of Science & Mathematics Requirements";
    }

    @Override
    public String getDescription() {
        return "The College of Science & Mathematics requires an additional 9 credits in Humanities or Social Sciences.";
    }

}
