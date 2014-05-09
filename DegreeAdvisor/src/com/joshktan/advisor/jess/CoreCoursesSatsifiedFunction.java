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
 * @author Josh Tan
 */
public class CoreCoursesSatsifiedFunction implements Userfunction {

    @Override
    public String getName() {
        return "core-courses-satisfied";
    }

    @Override
    public Value call(ValueVector vv, Context context) throws JessException {
        int studentId = vv.get(1).intValue(context);

        boolean result = UniversityDatabase.getDatabase().coreCoursesSatsified(studentId);
        if (result) {
            return Funcall.TRUE;
        } else {
            return Funcall.FALSE;
        }
    }

}
