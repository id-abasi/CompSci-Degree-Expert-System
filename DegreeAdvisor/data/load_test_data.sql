-- TEST DATA
DROP TABLE IF EXISTS Students;
DROP TABLE IF EXISTS Records;

CREATE TABLE Students(StudentId int);
INSERT INTO Students VALUES(1);
INSERT INTO Students VALUES(2);
INSERT INTO Students VALUES(3);
INSERT INTO Students VALUES(4);
INSERT INTO Students VALUES(5);

CREATE TABLE Records(StudentId int, CourseId TEXT, Grade TEXT);

-- Record for Student ID 1
INSERT INTO Records VALUES(1, 'CSCI 160', 'B');
INSERT INTO Records VALUES(1, 'CSCI 161', 'A');
INSERT INTO Records VALUES(1, 'CSCI 473', 'NA');

-- Record for Student ID 2
INSERT INTO Records VALUES(2, 'CSCI 366', 'F');
INSERT INTO Records VALUES(2, 'CSCI 467', 'F');
INSERT INTO Records VALUES(2, 'CSCI 160', 'F');
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
INSERT INTO Records VALUES(4, 'BIOL 315', 'A');
INSERT INTO Records VALUES(4, 'CHEM 121', 'A');
INSERT INTO Records VALUES(4, 'CHEM 121L', 'A');
INSERT INTO Records VALUES(4, 'SOIL 217', 'A');
INSERT INTO Records VALUES(4, 'ENGL 321', 'B');
INSERT INTO Records VALUES(4, 'PHIL 215', 'B');


-- Record for Student Id 5
INSERT INTO Records VALUES(5, 'BIOL 150', 'A');
INSERT INTO Records VALUES(5, 'BIOL 150L', 'A');
INSERT INTO Records VALUES(5, 'PHIL 215', 'A');
INSERT INTO Records VALUES(5, 'PHYS 252', 'A');
INSERT INTO Records VALUES(5, 'PHYS 252L', 'A');
INSERT INTO Records VALUES(5, 'PHYS 252R', 'A');
INSERT INTO Records VALUES(5, 'PSYC 111', 'A');
INSERT INTO Records VALUES(5, 'COMM 110', 'A');
INSERT INTO Records VALUES(5, 'CSCI 160', 'A');
INSERT INTO Records VALUES(5, 'CSCI 161', 'A');
INSERT INTO Records VALUES(5, 'CSCI 222', 'A');
INSERT INTO Records VALUES(5, 'HNES 100', 'A');
INSERT INTO Records VALUES(5, 'STAT 367', 'A');
INSERT INTO Records VALUES(5, 'CSCI 366', 'A');
INSERT INTO Records VALUES(5, 'CSCI 372', 'A');
INSERT INTO Records VALUES(5, 'CSCI 459', 'A');
INSERT INTO Records VALUES(5, 'CSCI 467', 'A');
INSERT INTO Records VALUES(5, 'STAT 368', 'A');
INSERT INTO Records VALUES(5, 'CSCI 213', 'A');
INSERT INTO Records VALUES(5, 'CSCI 413', 'A');
INSERT INTO Records VALUES(5, 'CSCI 477', 'A');
INSERT INTO Records VALUES(5, 'ENGL 324', 'A');
INSERT INTO Records VALUES(5, 'CSCI 313', 'A');
INSERT INTO Records VALUES(5, 'CSCI 336', 'A');
INSERT INTO Records VALUES(5, 'CSCI 374', 'A');
INSERT INTO Records VALUES(5, 'CSCI 489', 'A');
INSERT INTO Records VALUES(5, 'CSCI 415', 'A');
INSERT INTO Records VALUES(5, 'CSCI 469', 'A');
INSERT INTO Records VALUES(5, 'CSCI 474', 'A');
INSERT INTO Records VALUES(5, 'CSCI 479', 'A');
INSERT INTO Records VALUES(5, 'CSCI 426', 'A');
INSERT INTO Records VALUES(5, 'CSCI 445', 'A');
INSERT INTO Records VALUES(5, 'ECON 201', 'A');
INSERT INTO Records VALUES(5, 'MATH 429', 'C');
INSERT INTO Records VALUES(5, 'UNIV 189', 'A');
INSERT INTO Records VALUES(5, 'MATH 165', 'A');
INSERT INTO Records VALUES(5, 'MATH 166', 'A');
INSERT INTO Records VALUES(5, 'CHEM 121', 'C');
INSERT INTO Records VALUES(5, 'CHEM 121L', 'C');
INSERT INTO Records VALUES(5, 'ENGRD 111', 'S');
INSERT INTO Records VALUES(5, 'MATH 265', 'C');
INSERT INTO Records VALUES(5, 'HNES 134', 'S');
INSERT INTO Records VALUES(5, 'HNES 112', 'S');
INSERT INTO Records VALUES(5, 'PHYS 251', 'C');
INSERT INTO Records VALUES(5, 'PHYS 251L', 'C');
INSERT INTO Records VALUES(5, 'MATH 266', 'C');
INSERT INTO Records VALUES(5, 'PHIL 101', 'B');
INSERT INTO Records VALUES(5, 'ENGL 110', 'A');
INSERT INTO Records VALUES(5, 'ENGL 120', 'A');
-- substitute for 3 credit transfer course (grade = A)
INSERT INTO Records VALUES(5, 'POLS 621', 'A');
-- substitute for 1 credit transfer course (grade = S)
INSERT INTO Records VALUES(5, 'POLS 622', 'S');
-- substitute for 3 credit transfer course (grade = A)
INSERT INTO Records VALUES(5, 'POLS 630', 'A');
-- substitute for 4 credit MATH transfer course (grade = D)
INSERT INTO Records VALUES(5, 'ADHM 470', 'D');
-- substitute for 3 credit PHIL transfer course (grade = A)
INSERT INTO Records VALUES(5, 'PHIL 625', 'A');
-- substitute for 3 credit HIST transfer course (grade = A)
INSERT INTO Records VALUES(5, 'HIST 481', 'A');
-- substitute for 3 credit HIST transfer course (grade = A)
INSERT INTO Records VALUES(5, 'HIST 482', 'A');
