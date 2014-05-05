package com.joshktan.advisor.req;

/**
 *
 * @author Josh Tan
 */
public abstract class Requirement {
    
    protected boolean satisfied;
    
    public boolean isSatisfied() {
        return satisfied;
    }
    
    public void setSatisfied(boolean satisfied) {
        this.satisfied = satisfied;
    }
    
    public abstract String getName();
    
    public abstract String getDescription();
    
    
}
