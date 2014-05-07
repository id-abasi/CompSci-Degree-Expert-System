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
public class GenEdFunction implements Userfunction {

    @Override
    public String getName() {
        return "is-gen-ed";
    }

    @Override
    public Value call(ValueVector vv, Context context) throws JessException {
        String courseId = vv.get(1).stringValue(context);
        String genEdArea = vv.get(2).stringValue(context);
        boolean result = UniversityDatabase.getDatabase().isGenEd(courseId, genEdArea);
        if (result) {
            return Funcall.TRUE;
        } else {
            return Funcall.FALSE;
        }
    }
    
}
