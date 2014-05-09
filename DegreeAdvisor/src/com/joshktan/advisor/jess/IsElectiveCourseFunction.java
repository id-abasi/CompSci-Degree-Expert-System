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
