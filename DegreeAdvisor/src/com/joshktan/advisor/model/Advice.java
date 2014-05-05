package com.joshktan.advisor.model;

import com.joshktan.advisor.req.Requirement;
import com.joshktan.advisor.req.TotalCreditsRequirement;

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

        if (requirement instanceof TotalCreditsRequirement) {
            requirement = (TotalCreditsRequirement) requirement;
        }

        type = AdviceType.valueOf(typeStr);
        if (type == AdviceType.ISSUE) {
            requirement.setSatisfied(false);
        } else {
            requirement.setSatisfied(true);
        }

        this.summary = summary;
        this.details = details;

    }

    public enum AdviceType {

        WARNING,
        ISSUE
    }

    @Override
    public String toString() {
        StringBuilder builder = new StringBuilder();
        
        builder.append("Requirement: " + requirement.getName() + "(" + type + ")\n");
        builder.append("Summary:\n\t" + summary + "\n");
        builder.append("Details:\n\t" + details + "\n\n");
        
        return builder.toString();
        
    }
    
    
}
