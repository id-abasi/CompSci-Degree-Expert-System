DROP TABLE IF EXISTS Courses;
DROP TABLE IF EXISTS GenEdCourses;
DROP TABLE IF EXISTS ElectiveCourses;
DROP TABLE IF EXISTS HumanitiesSocialSciences;
DROP TABLE IF EXISTS Students;
DROP TABLE IF EXISTS Records;

-- General Education Courses
CREATE TABLE Courses(Id TEXT, Title TEXT, Credits int);

INSERT INTO Courses VALUES('UNIV 189', 'Skills for Academic Success', 1);
INSERT INTO Courses VALUES('ENGL 110', 'College Composition I', 3);
INSERT INTO Courses VALUES('ENGL 120', 'College Composition II', 3);
INSERT INTO Courses VALUES('COMM 110', 'Fundamentals of Public Speaking', 3);
INSERT INTO Courses VALUES('ENGL 321', '?', 3);
INSERT INTO Courses VALUES('ENGL 324', '?', 3);
INSERT INTO Courses VALUES('MATH 165', 'Calculus I', 4);
INSERT INTO Courses VALUES('CHEM 209', '?', 3);
INSERT INTO Courses VALUES('CHEM 209L', '?', 1);
INSERT INTO Courses VALUES('PHYS 112', '?', 3);
INSERT INTO Courses VALUES('PHYS 112L', '?', 1);
INSERT INTO Courses VALUES('BIOL 150', '?', 3);
INSERT INTO Courses VALUES('BIOL 150L', '?', 1);
INSERT INTO Courses VALUES('PHIL 101', '?', 3);
INSERT INTO Courses VALUES('PHIL 215', '?', 3);
INSERT INTO Courses VALUES('PSYC 111', '?', 3);
INSERT INTO Courses VALUES('ECON 201', '?', 3);
INSERT INTO Courses VALUES('HNES 100', '?', 2);
-- add HIST stuff
-- add rest

CREATE TABLE GenEdCourses(Id TEXT, Area TEXT);

-- First Year Experience (F)
INSERT INTO GenEdCourses VALUES('UNIV 189', 'F');

-- Communication (C)
INSERT INTO GenEdCourses VALUES('ENGL 110', 'C');
INSERT INTO GenEdCourses VALUES('ENGL 120', 'C');
INSERT INTO GenEdCourses VALUES('COMM 110', 'C');
INSERT INTO GenEdCourses VALUES('ENGL 321', 'C');
INSERT INTO GenEdCourses VALUES('ENGL 324', 'C');

-- Quantitative Reasoning (R)
INSERT INTO GenEdCourses VALUES('MATH 165', 'R');

-- Science & Technology (S)
INSERT INTO GenEdCourses VALUES('BIOL 150', 'S');
INSERT INTO GenEdCourses VALUES('BIOL 150L', 'S');
INSERT INTO GenEdCourses VALUES('BIOL 126', 'S');
INSERT INTO GenEdCourses VALUES('BIOL 126L', 'S');
INSERT INTO GenEdCourses VALUES('CHEM 121', 'S');
INSERT INTO GenEdCourses VALUES('CHEM 121L', 'S');
INSERT INTO GenEdCourses VALUES('CHEM 150', 'S');
INSERT INTO GenEdCourses VALUES('CHEM 151', 'S');
INSERT INTO GenEdCourses VALUES('CHEM 160', 'S');
INSERT INTO GenEdCourses VALUES('CHEM 161', 'S');
INSERT INTO GenEdCourses VALUES('GEOL 105', 'S');
INSERT INTO GenEdCourses VALUES('GEOL 105L', 'S');
INSERT INTO GenEdCourses VALUES('GEOL 106', 'S');
INSERT INTO GenEdCourses VALUES('GEOL 106L', 'S');
INSERT INTO GenEdCourses VALUES('PHYS 211', 'S');
INSERT INTO GenEdCourses VALUES('PHYS 211L', 'S');
INSERT INTO GenEdCourses VALUES('PHYS 212', 'S');
INSERT INTO GenEdCourses VALUES('PHYS 212L', 'S');
INSERT INTO GenEdCourses VALUES('PHYS 251', 'S');
INSERT INTO GenEdCourses VALUES('PHYS 251L', 'S');
INSERT INTO GenEdCourses VALUES('PHYS 252', 'S');
INSERT INTO GenEdCourses VALUES('PHYS 252L', 'S');

-- Humanities & Fine Arts (A)
INSERT INTO GenEdCourses VALUES('PHIL 101', 'A');
INSERT INTO GenEdCourses VALUES('PHIL 215', 'A');

-- Social & Behavorial Sciences (B)
INSERT INTO GenEdCourses VALUES('PSYC 111', 'B');
INSERT INTO GenEdCourses VALUES('ECON 201', 'B');

-- Wellness (W)
INSERT INTO GenEdCourses VALUES('HNES 100', 'W');

-- Cultural Diversity (D)
INSERT INTO GenEdCourses VALUES('PHIL 215', 'D');

-- Global Perspectives (G)
INSERT INTO GenEdCourses VALUES('HIST 112', 'G'); -- fix course ID

-- Major Requirements
INSERT INTO Courses VALUES('CSCI 160', 'Computer Science I', 4);
INSERT INTO Courses VALUES('CSCI 161', 'Computer Science II', 4);
INSERT INTO Courses VALUES('CSCI 213', 'Modern Software Development', 3);
INSERT INTO Courses VALUES('CSCI 222', 'Discrete Mathematics', 3);
INSERT INTO Courses VALUES('CSCI 313', 'Software Development for Games', 3);
INSERT INTO Courses VALUES('CSCI 336', 'Theoretical Computer Science II', 3);
INSERT INTO Courses VALUES('CSCI 366', 'Files for Database Systems', 3);
INSERT INTO Courses VALUES('CSCI 372', 'Comparative Programming Languages', 3);
INSERT INTO Courses VALUES('CSCI 374', 'Computer Organization & Architecture', 3);
INSERT INTO Courses VALUES('CSCI 415', 'Networking and Parallel Computation', 3);
INSERT INTO Courses VALUES('CSCI 445', 'Software Projects: Capstone', 3);
INSERT INTO Courses VALUES('CSCI 467', 'Algorithm Analysis', 3);
INSERT INTO Courses VALUES('CSCI 489', 'Social Implications of Computers', 3);

-- Computer Science Electives
INSERT INTO Courses VALUES('CSCI 413', 'Principles of Software Engineering', 3);
INSERT INTO Courses VALUES('CSCI 477', 'Object-Oriented Systems', 3);
INSERT INTO Courses VALUES('CSCI 488', 'Human-Computer Interaction', 3);
INSERT INTO Courses VALUES('CSCI 426', 'Introduction to Artificial Intelligence', 3);
INSERT INTO Courses VALUES('CSCI 458', 'Microcomputer Graphics', 3);
INSERT INTO Courses VALUES('CSCI 459', 'Foundations of Computer Networks', 3);
INSERT INTO Courses VALUES('CSCI 418', 'Simulation Models', 3);
INSERT INTO Courses VALUES('CSCI 453', 'Linear Programming and Network Flows', 3);
INSERT INTO Courses VALUES('CSCI 454', 'Operations Research', 3);
INSERT INTO Courses VALUES('CSCI 345', 'Topics in Personal Computers', 3);
INSERT INTO Courses VALUES('CSCI 469', 'Network Security', 3);
INSERT INTO Courses VALUES('CSCI 473', 'Foundations of the Digital Enterprise', 3);
INSERT INTO Courses VALUES('CSCI 476', 'Computer Forensics', 3);
INSERT INTO Courses VALUES('CSCI 479', 'Introduction to Data Mining', 3);

CREATE TABLE ElectiveCourses(Id TEXT, Category TEXT);

-- Software Engineering (SE)
INSERT INTO ElectiveCourses VALUES('CSCI 413', 'SE');
INSERT INTO ElectiveCourses VALUES('CSCI 477', 'SE');
INSERT INTO ElectiveCourses VALUES('CSCI 488', 'SE');

-- Large Systems (LS)
INSERT INTO ElectiveCourses VALUES('CSCI 426', 'LS');
INSERT INTO ElectiveCourses VALUES('CSCI 458', 'LS');
INSERT INTO ElectiveCourses VALUES('CSCI 459', 'LS');

-- Systems Modeling (SM)
INSERT INTO ElectiveCourses VALUES('CSCI 418', 'SM');
INSERT INTO ElectiveCourses VALUES('CSCI 453', 'SM');
INSERT INTO ElectiveCourses VALUES('CSCI 454', 'SM');

-- Emerging Areas (EA)
INSERT INTO ElectiveCourses VALUES('CSCI 345', 'EA');
INSERT INTO ElectiveCourses VALUES('CSCI 469', 'EA');
INSERT INTO ElectiveCourses VALUES('CSCI 473', 'EA');
INSERT INTO ElectiveCourses VALUES('CSCI 476', 'EA');
INSERT INTO ElectiveCourses VALUES('CSCI 479', 'EA');

-- Humanities & Social Sciences
INSERT INTO Courses VALUES('PHIL 112', '?', 3); -- only insert non-gen ed ones (since gen ed already inserted)
-- insert rest

CREATE TABLE HumanitiesSocialSciences(Id TEXT);
INSERT INTO HumanitiesSocialSciences VALUES('PHIL 112');
-- insert rest

-- Related Required Courses
INSERT INTO Courses VALUES('MATH 166', 'Calculus II', 4);
INSERT INTO Courses VALUES('STAT 367', 'Probability', 3);
INSERT INTO Courses VALUES('STAT 368', 'Statistics', 3);



-- TEST DATA
CREATE TABLE Students(StudentId int);
INSERT INTO Students VALUES(1);
INSERT INTO Students VALUES(2);

CREATE TABLE Records(StudentId int, CourseId TEXT, Grade TEXT);

-- Record for Student ID 1
INSERT INTO Records VALUES(1, 'CSCI 160', 'B');
INSERT INTO Records VALUES(1, 'CSCI 161', 'A');
INSERT INTO Records VALUES(1, 'CSCI 473', 'NA');

-- Record for Student ID 2
INSERT INTO Records VALUES(2, 'CSCI 366', 'F');
INSERT INTO Records VALUES(2, 'CSCI 467', 'F');
INSERT INTO Records VALUES(2, 'CSCI 459', 'NA');
