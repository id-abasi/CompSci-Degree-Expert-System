package com.joshktan.advisor.req;

/**
 *
 * @author Josh Tan
 */
public class RelatedRequirement extends Requirement {

    @Override
    public String getName() {
        return "Related Courses Requirement";
    }

    @Override
    public String getDescription() {
        return "Required MATH/STATS courses and one year lab science sequence requirements.";
    }

}
