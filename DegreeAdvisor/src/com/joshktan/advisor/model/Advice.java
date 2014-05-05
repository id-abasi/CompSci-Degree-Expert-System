/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.joshktan.advisor.model;

import com.joshktan.advisor.req.Requirement;
import com.joshktan.advisor.req.TotalCreditsRequirement;

/**
 *
 * @author Josh Tan
 */
public class Advice {

    private Requirement requirement;
    private String summary;
    private String details;
    private AdviceType type;

    public Advice(String requirementClassName, String summary, String details, String typeStr) throws ClassNotFoundException, InstantiationException, IllegalAccessException {
        Requirement requirement = (Requirement) Class.forName(requirementClassName + ".class").newInstance();

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

        NONISSUE,
        WARNING,
        ISSUE
    }
}
