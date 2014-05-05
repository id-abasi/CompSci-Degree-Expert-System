package com.joshktan.advisor.data;

import com.joshktan.advisor.model.Course;
import com.joshktan.advisor.model.LabScienceSequence;
import com.joshktan.advisor.model.Record;
import java.util.Collection;

/**
 *
 * @author Josh Tan
 */
public interface ICourseDatabase {
    
    Course getCourse(String courseID);
    
    Collection<Course> getCourses(String dept);
    
    Course getGenEdCourses(String area);
    
    Collection<Course> getValidAdditionalHumanitiesSocialSciences(Record record);
    
    Collection<Course> getElectives(String area);
    
    Collection<Course> getRelatedRequiredCourses();
    
    Collection<LabScienceSequence> getLabScienceCourses();
    
    Collection<Course> getValidAdditionlGenEdScienceCourses(Record record);
    
}
