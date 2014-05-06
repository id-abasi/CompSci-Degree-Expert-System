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
INSERT INTO Courses VALUES('ENGL 321', 'Writing in the Technical Professions', 3);
INSERT INTO Courses VALUES('ENGL 324', 'Writing in the Sciences', 3);
INSERT INTO Courses VALUES('MATH 165', 'Calculus I', 4);
INSERT INTO Courses VALUES('ADHM 310', 'History of Fashion', 3);
INSERT INTO Courses VALUES('ADHM 315', 'History of Interiors I', 3);
INSERT INTO Courses VALUES('ADHM 316', 'History of Interiors II', 3);
INSERT INTO Courses VALUES('ADHM 410', 'Dress in World Cultures', 3);
INSERT INTO Courses VALUES('ADHM 411', 'Food and World Cultures', 3);
INSERT INTO Courses VALUES('ARCH 321', 'History of Architecture I', 3);
INSERT INTO Courses VALUES('ARCH 322', 'History of Architecture II', 3);
INSERT INTO Courses VALUES('ART 110', 'Introduction to the Visual Arts', 3);
INSERT INTO Courses VALUES('ART 111', 'Introduction to the Art History', 3);
INSERT INTO Courses VALUES('ART 210', 'Art History I', 3);
INSERT INTO Courses VALUES('ART 211', 'Art History II', 3);
INSERT INTO Courses VALUES('CLAS 101', 'First-Year Latin I', 4);
INSERT INTO Courses VALUES('CLAS 151', 'First-Year Greek I', 4);
INSERT INTO Courses VALUES('ENGL 220', 'Introduction to Literature', 3);
INSERT INTO Courses VALUES('ENGL 225', 'Introduction to Film', 3);
INSERT INTO Courses VALUES('ENGL 231', 'The Bible as Literature', 3);
INSERT INTO Courses VALUES('ENGL 315', 'British Literature I', 3);
INSERT INTO Courses VALUES('ENGL 316', 'British Literature II', 3);
INSERT INTO Courses VALUES('ENGL 317', 'American Literature I', 3);
INSERT INTO Courses VALUES('ENGL 318', 'American Literature II', 3);
INSERT INTO Courses VALUES('ENGL 330', 'British/American Women Writers', 3);
INSERT INTO Courses VALUES('ENGL 336', 'Literature and the Environment', 3);
INSERT INTO Courses VALUES('ENGL 340', '19th Century American Fiction', 3);
INSERT INTO Courses VALUES('ENGL 345', 'Themes in American Culture', 3);
INSERT INTO Courses VALUES('ENGR 311', 'History of Technology in America', 3);
INSERT INTO Courses VALUES('ENVD 101', 'Introduction to Environmental Design', 3);
INSERT INTO Courses VALUES('FREN 101', 'First-Year French I', 4);
INSERT INTO Courses VALUES('FREN 102', 'First-Year French II', 4);
INSERT INTO Courses VALUES('FREN 201', 'Second-Year French I', 3);
INSERT INTO Courses VALUES('FREN 345', 'Women in French Literature', 3);
INSERT INTO Courses VALUES('GERM 101', 'First-Year German I', 4);
INSERT INTO Courses VALUES('GERM 102', 'First-Year German II', 4);
INSERT INTO Courses VALUES('GERM 220', 'German Culture and Society', 3);
INSERT INTO Courses VALUES('HIST 101', 'Western Civilization I', 3);
INSERT INTO Courses VALUES('HIST 102', 'Western Civilization II', 3);
INSERT INTO Courses VALUES('HIST 103', 'U.S. to 1877', 3);
INSERT INTO Courses VALUES('HIST 104', 'U.S. since 1877', 3);
INSERT INTO Courses VALUES('HIST 381', 'Australia & New Zealand', 3);
INSERT INTO Courses VALUES('HIST 431', 'The North American Plains', 3);
INSERT INTO Courses VALUES('HON 340', 'Colloquium in the Humanities', 3);
INSERT INTO Courses VALUES('HON 386', 'World Literature: Imaginary Homelands', 3);
INSERT INTO Courses VALUES('LA 322', 'History of Landscape Architecture', 4);
INSERT INTO Courses VALUES('MUSC 100', 'Music Appreciation', 3);
INSERT INTO Courses VALUES('MUSC 103', 'Introduction to Music History', 3);
INSERT INTO Courses VALUES('PHIL 101', 'Introduction to Philosophy', 3);
INSERT INTO Courses VALUES('PHIL 111', 'Professional Responsibility & Ethics', 3);
INSERT INTO Courses VALUES('PHIL 215', 'Contemporary Moral Issues', 3);
INSERT INTO Courses VALUES('PHIL 216', 'Business Ethics', 3);
INSERT INTO Courses VALUES('RELS 100', 'Introduction to Religion', 3);
INSERT INTO Courses VALUES('SPAN 101', 'First-Year Spanish I', 4);
INSERT INTO Courses VALUES('SPAN 102', 'First-Year Spanish II', 4);
INSERT INTO Courses VALUES('SPAN 201', 'Second-Year Spanish I', 3);
INSERT INTO Courses VALUES('THEA 110', 'Introduction to Theatre Arts', 3);
INSERT INTO Courses VALUES('THEA 280', 'World Theatre', 3);
INSERT INTO Courses VALUES('WGS 112', 'Introduction to Masculinities', 3);
INSERT INTO Courses VALUES('ADHM 486', 'Dress & Human Behavior', 3);
INSERT INTO Courses VALUES('COMM 112', 'Understanding Media/Social Change', 3);
INSERT INTO Courses VALUES('COMM 114', 'Human Communication', 3);
INSERT INTO Courses VALUES('COMM 212', 'Interpersonal Communication', 3);
INSERT INTO Courses VALUES('ECON 105', 'Elements of Economics', 3);
INSERT INTO Courses VALUES('ECON 201', 'Principles of Microeconomics', 3);
INSERT INTO Courses VALUES('ECON 202', 'Principles of Macroeconomics', 3);
INSERT INTO Courses VALUES('EMGT 101', 'Emergencies, Disasters, and Catastrophes', 3);
INSERT INTO Courses VALUES('ENGR 312', 'Impact of Technology on Society', 3);
INSERT INTO Courses VALUES('GEOG 151', 'Human Geography', 3);
INSERT INTO Courses VALUES('GEOG 161', 'World Regional Geography', 3);
INSERT INTO Courses VALUES('H&CE 341', 'Leadership & Presentation Techniques', 3);
INSERT INTO Courses VALUES('HDFS 135', 'Family Science', 3);
INSERT INTO Courses VALUES('HDFS 186', 'Consumer & Society', 3);
INSERT INTO Courses VALUES('HDFS 230', 'Life Span Development', 3);
INSERT INTO Courses VALUES('HDFS 468', 'Families and Work', 3);
INSERT INTO Courses VALUES('HON 341', 'Colloquium in the Social Sciences', 3);
INSERT INTO Courses VALUES('INTL 110', 'Introduction to International Studies', 3);
INSERT INTO Courses VALUES('POLS 110', 'Introduction to Political Science', 3);
INSERT INTO Courses VALUES('POLS 115', 'American Government', 3);
INSERT INTO Courses VALUES('POLS 120', 'Terrorism', 3);
INSERT INTO Courses VALUES('POLS 220', 'International Politics', 3);
INSERT INTO Courses VALUES('PSYC 111', 'Introduction to Psychology', 3);
INSERT INTO Courses VALUES('PSYC 210', 'Human Sexuality', 3);
INSERT INTO Courses VALUES('PSYC 211', 'Introduction to Behavior Modification', 3);
INSERT INTO Courses VALUES('PSYC 212', 'Psychological Aspects of Drug Use and Abuse', 3);
INSERT INTO Courses VALUES('PSYC 214', 'Social Interaction', 3);
INSERT INTO Courses VALUES('SOC 214', 'Social Interaction', 3);
INSERT INTO Courses VALUES('PSYC 221', 'Psychology at Work', 3);
INSERT INTO Courses VALUES('PSYC 250', 'Developmental Psychology', 3);
INSERT INTO Courses VALUES('PSYC 270', 'Abnormal Psychology', 3);
INSERT INTO Courses VALUES('SOC 110', 'Introduction to Sociology', 3);
INSERT INTO Courses VALUES('SOC 235', 'Cultural Diversity', 3);
INSERT INTO Courses VALUES('SOC 413', 'Sociology of Gender', 3);
INSERT INTO Courses VALUES('HDFS 182', 'Wellness and Aging', 3);
INSERT INTO Courses VALUES('HDFS 242', 'Couples, Marriages, and Families', 3);
INSERT INTO Courses VALUES('HNES 100', 'Concepts of Fitness & Wellness', 2);
INSERT INTO Courses VALUES('HNES 111', 'Wellness', 3);
INSERT INTO Courses VALUES('HNES 200', 'Principles of Nutrition', 3);
INSERT INTO Courses VALUES('HNES 217', 'Personal & Community Health', 3);
INSERT INTO Courses VALUES('ANTH 111', 'Introduction to Anthropology', 3);
INSERT INTO Courses VALUES('COMM 216', 'Intercultural Communication', 3);
INSERT INTO Courses VALUES('ENGL 335', 'Multicultural Writers', 3);
INSERT INTO Courses VALUES('ENGL 341', '20th Century American Fiction', 3);
INSERT INTO Courses VALUES('GERM 201', 'Second-Year German I', 3);
INSERT INTO Courses VALUES('HDFS 475', 'Children & Families Across Cultures', 3);
INSERT INTO Courses VALUES('HIST 135', 'Race in U.S History', 3);
INSERT INTO Courses VALUES('HIST 261', 'American Indian History', 3);
INSERT INTO Courses VALUES('HIST 271', 'Introduction to Latin American History', 3);
INSERT INTO Courses VALUES('MUSC 108', 'Roots of American Popular Music', 3);
INSERT INTO Courses VALUES('SOC 412', 'Sociology of Gender', 3);
INSERT INTO Courses VALUES('THEA 115', 'World Film', 3);
INSERT INTO Courses VALUES('WGS 110', 'Introduction to Women''s Studies', 3);
INSERT INTO Courses VALUES('BIOL 111', 'Concepts of Biology', 3);
INSERT INTO Courses VALUES('BIOL 111L', 'Concepts of Biology Lab', 1);
INSERT INTO Courses VALUES('BIOL 124', 'Environmental Science', 3);
INSERT INTO Courses VALUES('BIOL 124L', 'Environmental Science Lab', 1);
INSERT INTO Courses VALUES('BIOL 126', 'Human Biology', 3);
INSERT INTO Courses VALUES('ZOO 126', 'Human Biology', 3);
INSERT INTO Courses VALUES('BIOL 126L', 'Human Biology Laboratory', 1);
INSERT INTO Courses VALUES('ZOO 126L', 'Human Biology Laboratory', 1);
INSERT INTO Courses VALUES('BIOL 220', 'Human Anatomy & Physiology I', 3);
INSERT INTO Courses VALUES('BIOL 220L', 'Human Anatomy & Physiology I Lab', 1);
INSERT INTO Courses VALUES('BIOL 315', 'Genetics', 3);
INSERT INTO Courses VALUES('BOT 315', 'Genetics', 3);
INSERT INTO Courses VALUES('PLSC 315', 'Genetics', 3);
INSERT INTO Courses VALUES('ZOO 315', 'Genetics', 3);
INSERT INTO Courses VALUES('BIOL 315L', 'Genetics Lab', 1);
INSERT INTO Courses VALUES('BOT 315L', 'Genetics Lab', 1);
INSERT INTO Courses VALUES('PLSC 315L', 'Genetics Lab', 1);
INSERT INTO Courses VALUES('ZOO 315L', 'Genetics Lab', 1);
INSERT INTO Courses VALUES('ENT 210', 'Insects, Humans, & the Environment', 3);
INSERT INTO Courses VALUES('HON 342', 'Colloquium in the Sciences', 3);
INSERT INTO Courses VALUES('MICR 202', 'Intro Microbiology', 2);
INSERT INTO Courses VALUES('MICR 202L', 'Intro Microbiology Lab', 1);
INSERT INTO Courses VALUES('PLSC 110', 'World Food Crops/Lab', 3);
INSERT INTO Courses VALUES('PLSC 111', 'Genetics and You', 3);
INSERT INTO Courses VALUES('PLSC 210', 'Horticulture Science', 3);
INSERT INTO Courses VALUES('PLSC 211', 'Horticulture Science Lab', 1);
INSERT INTO Courses VALUES('RNG 225', 'Natural Resources & Agro-ecosystems', 3);
INSERT INTO Courses VALUES('NRM 225', 'Natural Resources & Agro-ecosystems', 3);
INSERT INTO Courses VALUES('SOIL 217', 'Intro to Meteorology & Climatology', 3);
INSERT INTO Courses VALUES('CHEM 117', 'Chemical Concepts & Applications', 3);
INSERT INTO Courses VALUES('CHEM 117L', 'Chemical Concepts & Applications Lab', 1);
INSERT INTO Courses VALUES('CHEM 121', 'General Chemistry I', 3);
INSERT INTO Courses VALUES('CHEM 121L', 'General Chemistry I Lab', 1);
INSERT INTO Courses VALUES('CHEM 122', 'General Chemistry II', 3);
INSERT INTO Courses VALUES('CHEM 122L', 'General Chemistry II Lab', 1);
INSERT INTO Courses VALUES('GEOL 105', 'Physical Geology', 3);
INSERT INTO Courses VALUES('GEOL 105L', 'Physical Geology Lab', 1);
INSERT INTO Courses VALUES('GEOL 106', 'The Earth Through Time', 3);
INSERT INTO Courses VALUES('GEOL 106L', 'The Earth Through Time Lab', 1);
INSERT INTO Courses VALUES('GEOL 107L', 'Eastern North Dakota Field Course', 1);
INSERT INTO Courses VALUES('HNES 250', 'Nutrition Science', 3);
INSERT INTO Courses VALUES('PHYS 110', 'Introductory Astronomy', 3);
INSERT INTO Courses VALUES('PHYS 110L', 'Introductory Astronomy Lab', 1);
INSERT INTO Courses VALUES('PHYS 120', 'Fundamentals of Physics', 3);
INSERT INTO Courses VALUES('PHYS 120L', 'Fundamentals of Physics Lab', 1);
INSERT INTO Courses VALUES('PHYS 211', 'College Physics I', 3);
INSERT INTO Courses VALUES('PHYS 211L', 'College Physics I Lab', 1);
INSERT INTO Courses VALUES('PHYS 212', 'College Physics II', 3);
INSERT INTO Courses VALUES('PHYS 212L', 'College Physics II Lab', 1);
INSERT INTO Courses VALUES('PHYS 220', 'Physics for Designers', 3);
INSERT INTO Courses VALUES('UNIV 150', 'Foundations of Science', 3);
INSERT INTO Courses VALUES('UNIV 151', 'Science and Society', 3);
INSERT INTO Courses VALUES('CHEM 150', 'Principles of Chemistry I', 3);
INSERT INTO Courses VALUES('CHEM 151', 'Principles of Chemistry II', 3);
INSERT INTO Courses VALUES('CHEM 160', 'Principles of Chemistry I Lab', 1);
INSERT INTO Courses VALUES('CHEM 161', 'Principles of Chemistry II Lab', 1);
INSERT INTO Courses VALUES('PHYS 251', 'University Physics I', 4);
INSERT INTO Courses VALUES('PHYS 251L', 'University Physics I Lab', 1);
INSERT INTO Courses VALUES('PHYS 252', 'University Physics II', 4);
INSERT INTO Courses VALUES('PHYS 252L', 'University Physics II Lab', 1);
INSERT INTO Courses VALUES('CSCI 114', 'Microcomputer Packages', 3);
INSERT INTO Courses VALUES('CSCI 116', 'Business Use of Computers', 4);
INSERT INTO Courses VALUES('ART 130', 'Drawing I', 3);
INSERT INTO Courses VALUES('THEA 161', 'Acting I', 3);

CREATE TABLE GenEdCourses(Id TEXT, Area TEXT);

-- add all links

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
INSERT INTO Students VALUES(3);
INSERT INTO Students VALUES(4);

CREATE TABLE Records(StudentId int, CourseId TEXT, Grade TEXT);

-- Record for Student ID 1
INSERT INTO Records VALUES(1, 'CSCI 160', 'B');
INSERT INTO Records VALUES(1, 'CSCI 161', 'A');
INSERT INTO Records VALUES(1, 'CSCI 473', 'NA');

-- Record for Student ID 2
INSERT INTO Records VALUES(2, 'CSCI 366', 'F');
INSERT INTO Records VALUES(2, 'CSCI 467', 'F');
INSERT INTO Records VALUES(2, 'CSCI 459', 'NA');

-- Record for Student ID 3
INSERT INTO Records VALUES(3, 'CSCI 222', 'A');
INSERT INTO Records VALUES(3, 'CSCI 313', 'B');
INSERT INTO Records VALUES(3, 'CSCI 445', 'A');

-- Record for Student Id 4
INSERT INTO Records VALUES(4, 'CSCI 222', 'A');
INSERT INTO Records VALUES(4, 'CSCI 313', 'A');
INSERT INTO Records VALUES(4, 'CSCI 445', 'A');
INSERT INTO Records VALUES(4, 'CSCI 366', 'A');
INSERT INTO Records VALUES(4, 'CSCI 467', 'A');
INSERT INTO Records VALUES(4, 'CSCI 459', 'A');
