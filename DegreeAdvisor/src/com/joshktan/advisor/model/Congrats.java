package com.joshktan.advisor.model;

/**
 *
 * @author Josh Tan
 */
public class Congrats {
    
    private final String message;

    public Congrats(String message) {
        this.message = message;
    }

    @Override
    public String toString() {
        return "Congratulations!\n\t" + message;
    }
    
}
