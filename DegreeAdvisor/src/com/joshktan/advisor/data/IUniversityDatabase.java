package com.joshktan.advisor.data;

import com.joshktan.advisor.model.Course;
import com.joshktan.advisor.model.Record;
import java.util.Collection;
import java.util.Map;

/**
 *
 * @author Josh Tan
 */
public interface IUniversityDatabase {
    
    Record getStudentRecord(int studentID);
    
    Collection<Record> getStudentRecords();
    
    Course getCourse(String courseID);
    
    Collection<Course> getCourses();
    
    Collection<Course> getCourses(String dept);
    
    Collection<Course> getValidAdditionalHumanitiesSocialSciences(Record studentRecord);
    
    Collection<Course> getElectives(String area);
    
    Collection<Course> getRelatedRequiredCourses();
    
    Collection<Course> getValidAdditionlGenEdScienceCourses(Record studentRecord);
    
}
