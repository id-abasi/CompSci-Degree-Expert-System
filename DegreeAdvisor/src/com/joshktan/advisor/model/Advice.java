package com.joshktan.advisor.model;

import com.joshktan.advisor.req.Requirement;
import com.joshktan.advisor.req.BachelorScienceRequirement;
import com.joshktan.advisor.req.CollegeRequirement;
import com.joshktan.advisor.req.GenEdRequirement;
import com.joshktan.advisor.req.MajorRequirement;
import com.joshktan.advisor.req.RelatedRequirement;

/**
 *
 * @author Josh Tan
 */
public class Advice {
    
    private static final String REQ_PACKAGE_STRING = "com.joshktan.advisor.req.";

    private Requirement requirement;
    private final String summary;
    private final String details;
    private final AdviceType type;

    public Advice(String requirementClassName, String summary, String details, String typeStr) throws ClassNotFoundException, InstantiationException, IllegalAccessException {
        requirement = (Requirement) Class.forName(REQ_PACKAGE_STRING + requirementClassName).newInstance();

        if (requirement instanceof BachelorScienceRequirement) {
            requirement = (BachelorScienceRequirement) requirement;
        } else if (requirement instanceof CollegeRequirement) {
            requirement = (CollegeRequirement) requirement;
        } else if (requirement instanceof GenEdRequirement) {
            requirement = (GenEdRequirement) requirement;
        } else if (requirement instanceof MajorRequirement) {
            requirement = (MajorRequirement) requirement;
        } else if (requirement instanceof RelatedRequirement) {
            requirement = (RelatedRequirement) requirement;
        }

        type = AdviceType.valueOf(typeStr);

        this.summary = summary;
        this.details = details;

    }

    public enum AdviceType {

        WARNING,
        ISSUE
    }
    
    public Requirement getRequirement() {
        return requirement;
    }

    @Override
    public String toString() {
        StringBuilder builder = new StringBuilder();
        
        builder.append("Requirement: ").append(requirement.getName()).append("\n");
        builder.append("Summary:\n\t").append(summary).append("\n");
        builder.append("Details:\n\t").append(details);
        
        return builder.toString();
        
    }
    
    
}
