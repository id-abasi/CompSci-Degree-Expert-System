package com.joshktan.advisor.req;

/**
 *
 * @author Josh Tan
 */
public class TotalCreditsRequirement extends UniversityRequirement {
    
    public static final int TOTAL_CREDITS_REQUIRED = 10; // TODO: revert to 122
    
    private static final String NAME = "Total Credits Requirement";
    private static final String DESCRIPTION = "You must complete a total of " + TOTAL_CREDITS_REQUIRED;

    @Override
    public String getName() {
        return NAME;
    }
    
    @Override
    public String getDescription() {
        return DESCRIPTION;
        
    }        
}
