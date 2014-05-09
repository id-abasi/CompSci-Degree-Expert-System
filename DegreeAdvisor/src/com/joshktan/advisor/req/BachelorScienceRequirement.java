package com.joshktan.advisor.req;

/**
 *
 * @author Josh Tan
 */
public class BachelorScienceRequirement extends Requirement {

    public static final int TOTAL_CREDITS_REQUIRED = 122;

    @Override
    public String getName() {
        return "B.S. Degree Requirements";
    }

    @Override
    public String getDescription() {
        return "A B.S. degree requires a total of " + TOTAL_CREDITS_REQUIRED + " credits.";

    }
}
