/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.joshktan.advisor.jess;

import com.joshktan.advisor.data.UniversityDatabase;
import jess.Context;
import jess.Funcall;
import jess.JessException;
import jess.Userfunction;
import jess.Value;
import jess.ValueVector;

/**
 *
 * @author jdot
 */
public class IsElectiveCourseFunction implements Userfunction {

    @Override
    public String getName() {
        return "is-elective";
    }

    @Override
    public Value call(ValueVector vv, Context context) throws JessException {
        String courseId = vv.get(1).stringValue(context);
        boolean result = UniversityDatabase.getDatabase().isElectiveCourse(courseId);
        if (result) {
            return Funcall.TRUE;
        } else {
            return Funcall.FALSE;
        }
    }

}
