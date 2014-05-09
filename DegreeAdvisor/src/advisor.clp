;; TEMPLATES FOR MODEL CLASSES
(import com.joshktan.advisor.model.*)
(deftemplate Course (declare (from-class Course)))
(deftemplate Record (declare (from-class Record)))
(deftemplate Advice (declare (from-class Advice)))
(deftemplate Congrats (declare (from-class Congrats)))


;; GLOBAL VARIABLES
(defglobal ?*total-credit-req* = (get-member com.joshktan.advisor.req.BachelorScienceRequirement TOTAL_CREDITS_REQUIRED))
(defglobal ?*lab-seq-credits* = 8)


;; GENERAL EDUCATION REQUIREMENTS

;; General Education Lower Degree Requirements

;; First Year Experience (F) Requirements
(defrule gen-ed-f
  "Check if Gen Ed First Year Experience category requirements are satisfied."
  (not (exists (Course {courseId == "UNIV 189"})))
  =>
  (assert (gen-ed-not-satisfied))
  (add (new Advice "GenEdRequirement" "First Year Experience (F) category requirements not satisfied." "'Skills for Academic Success' (UNIV 189) is required." "ISSUE")))

;; Communication (C) Requirements
(defrule gen-ed-c
  "Check if Gen Ed Communication category requirements are satisfied."
  (not (exists (Course {courseId == "COMM 110"})))
  (not (exists (Course {courseId == "ENGL 110"})))
  (not (exists (Course {courseId == "ENGL 120"})))
  =>
  (assert (gen-ed-not-satisfied))
  (add (new Advice "GenEdRequirement" "Communication (C) category requirements not satisfied." "'College Composition I' (ENGL 110), 'College Composition II' (ENGL 120), and 'Fundamentals of Public Speaking' (COMM 110) are required." "ISSUE")))

;; Quantitative Reasoning (R) Requirements
(defrule gen-ed-r
  "Check if Quantitative Reasoning (R) category requirements are satisfied."
  (not (Course {courseId == "MATH 165"}))
  =>
  (assert (gen-ed-not-satisfied))
  (add (new Advice "GenEdRequirement" "Quantitative Reasoning (R) category requirements not satisfied." "'Calculus I' (MATH 165) is required." "ISSUE")))

;; Science & Technology (S) Requirements
(defrule gen-ed-s
  "Check if Science & Technology (S) category requirements are satisfied."
  ?totalCredits <- (accumulate (bind ?count 0)
			       (bind ?count (+ ?count ?credits))
			       ?count
			       (Course (credits ?credits) (courseId ?t&:(is-gen-ed ?t "S"))))
  (test (< ?totalCredits 10))
  =>
  (assert (gen-ed-not-satisfied))
  (bind ?rem (- 10 ?totalCredits))
  (add (new Advice "GenEdRequirement" "Science & Technology (S) category requirements not satisfied." (str-cat "At least 10 General Education credits in the Science and Technology (S) area are required. [" ?rem " additional credits required.]")  "ISSUE")))

;; Humanities & Fine Arts (A) Requirements
(defrule gen-ed-a
  "Check if Humanities & Fine Arts (A) category requirements are satisfied."
  ?totalCredits <- (accumulate (bind ?count 0)
			       (bind ?count (+ ?count ?credits))
			       ?count
			       (Course (credits ?credits) (courseId ?t&:(is-gen-ed ?t "A"))))
  (test (< ?totalCredits 6))
  =>
  (assert (gen-ed-not-satisfied))
  (bind ?rem (- 6 ?totalCredits))
  (add (new Advice "GenEdRequirement" "Humanities & Fine Arts (A) category requirements not satisfied." (str-cat "At least 6 General Education credits in the Humanities & Fine Arts (A) area are required. [" ?rem " additional credits required.]") "ISSUE")))

;; Social & Behavioral Sciences (B) Requirements
(defrule gen-ed-b
  "Check if Social & Behavioral Sciences (B) category requirements are satisfied."
  ?totalCredits <- (accumulate (bind ?count 0)
			       (bind ?count (+ ?count ?credits))
			       ?count
			       (Course (credits ?credits) (courseId ?t&:(is-gen-ed ?t "B"))))
  (test (< ?totalCredits 6))
  =>
  (assert (gen-ed-not-satisfied))
  (bind ?rem (- 6 ?totalCredits))
  (add (new Advice "GenEdRequirement" "Social & Behavioral Sciences (A) category requirements not satisfied." (str-cat "At least 6 General Education credits in the Social & Behavioral Sciences (B) area are required. [" ?rem " additional credits required.]") "ISSUE")))

;; Wellness (W) Requirements
(defrule gen-ed-w
  "Check if Wellness (W) category requirements are satisfied."
  ?totalCredits <- (accumulate (bind ?count 0)
			       (bind ?count (+ ?count ?credits))
			       ?count
			       (Course (credits ?credits) (courseId ?t&:(is-gen-ed ?t "W"))))
  (test (< ?totalCredits 2))
  =>
  (assert (gen-ed-not-satisfied))
  (bind ?rem (- 2 ?totalCredits))
  (add (new Advice "GenEdRequirement" "Wellness (W) category requirements not satisfied." (str-cat "At least 2 General Education credits in the Wellness (W) area are required. [" ?rem " additional credits required.]") "ISSUE")))

;; Cultural Diversity (D) Requirements
(defrule gen-ed-d
  "Check if Cultural Diversity (D) requirements are satisfied."
  (not (exists (Course (courseId ?t&:(is-gen-ed ?t "D")))))
  =>
  (assert (gen-ed-not-satisfied))
  (add (new Advice "GenEdRequirement" "Cultural Diversity (D) category requirements not satisfied." "At least 1 General Education course in the Cultural Diversity (D) area is required." "ISSUE")))

;; Global Perspectives (G) Requirements
(defrule gen-ed-g
  "Check if Global Perspectives (G) requirements are satisfied."
  (not (exists (Course (courseId ?t&:(is-gen-ed ?t "G")))))
  =>
  (assert (gen-ed-not-satisfied))
  (add (new Advice "GenEdRequirement" "Global Perspectives (G) category requirements not satisfied." "At least 1 General Education course in the Global Perspectives (G) area is required." "ISSUE")))

;; General Education Upper Division Requirements
(defrule gen-ed-ud
  "Check if General Education Upper Division requirements are satisfied."
  (not (exists (Course {courseId == "ENGL 321" || courseId == "ENGL 324"})))
  =>
  (assert (gen-ed-not-satisfied))
  (add (new Advice "GenEdRequirement" "General Education Upper Division requirements not satisfied." "Either 'Writing in the Technical Professions' (ENGL 321) or 'Writing in the Sciences' (ENGL 324) is required." "ISSUE")))

;; General Education Requirements
(defrule gen-ed
  "Check if General Education requirements are satisfied."
  (not (exists (gen-ed-not-satisfied)))
  =>
  (add (new Congrats "All General Education requirements are satisfied.")))


;; B.S. COMPUTER SCIENCE (MAJOR) REQUIREMENTS

;; CSCI Course Grade Requirement
(defrule core-cs-course-grade
  "Check if a grade of 'C' or better has been obtained for all CSCI courses."
  (exists (Course (courseId ?cId&:(eq "CSCI" (sub-string 1 4 ?cId)))
 		  (grade "D"|"F")))
  =>
  (assert (bs-cs-degree-req-not-met))
  (add (new Advice "MajorRequirement" "CSCI course grade requirement not satisfied." "A grade of 'C' or better is required for all CSCI courses." "ISSUE")))

;; Core CSCI Courses Requirement
(defrule core-courses-taken
  "Check if all core CSCI courses have are listed in student record."
  (not (exists (Record (studentId ?s&:(core-courses-satisfied ?s)))))
  =>
  (assert (bs-cs-degree-req-not-met))
  (add (new Advice "MajorRequirement" "Core Computer Science course requirements not satisfied." "All core CSCI courses are required. See curriculum guide for current list of core CSCI courses." "ISSUE")))

;; Computer Science Elective Credit Requirement
(defrule cs-elective-req-credits
  "Check if at least 3 Computer Science electives are listed among student courses."
  ?totalCourses <- (accumulate (bind ?count 0)
			       (bind ?count (+ ?count 1))
			       ?count
			       (Course (courseId ?cId&:(is-elective ?cId))))
  (test (< ?totalCourses 3))
  =>
  (assert (elective-req-not-met)))

;; Computer Science Elective Category Requirement
(defrule cs-elective-req-cat
  "Check if student record contains Computer Science electives belonging to at least 2 different categories."
  (not (exists (Record (studentId ?sId&:(at-least-2-elect-cat ?sId)))))
  =>
  (assert (elective-req-not-met)))

;; Computer Science Elective Requirements
(defrule cs-elective-req
  "Check if Computer Science Elective requirements are satisfied."
  (exists (elective-req-not-met))
  =>
  (assert (bs-cs-degree-req-not-met))
  (add (new Advice "MajorRequirement" "Computer Science Elective requirements not satisfied." "3 CSCI elective courses from at least 2 categories are required." "ISSUE")))

;; B.S. Computer Science Degree Requirement
(defrule bs-cs-degree-req
  "Check if B.S. Computer Science degree requirements are satisified."
  (not (exists (bs-cs-degree-req-not-met)))
  =>
  (add (new Congrats "All B.S. Computer Science degree requirements are satisfied.")))


;; RELATED REQUIRED COURSES

;; BIOL 126/L, BIOL 220/L Sequence
(defrule lab-sci-biol-126
  "Check if BIOL 126/L, BIOL 220/L sequence is satisfied."
  (not (exists (Course {courseId == "BIOL 126"})))
  (not (exists (Course {courseId == "BIOL 126L"})))
  (not (exists (Course {courseId == "BIOL 220"})))
  (not (exists (Course {courseId == "BIOL 220L"})))
  =>
  (assert (no-biol-126-seq)))

;; CHEM 121/L, CHEM 122/L Sequence
(defrule lab-sci-chem-121
  "Check if CHEM 121/L, CHEM 122/L sequence is satisfied."
  (not (exists (Course {courseId == "CHEM 121"})))
  (not (exists (Course {courseId == "CHEM 121L"})))
  (not (exists (Course {courseId == "CHEM 122"})))
  (not (exists (Course {courseId == "CHEM 122L"})))
  =>
  (assert (no-chem-121-seq)))

;; CHEM 150/160, CHEM 151/161 Sequence
(defrule lab-sci-chem-150
  "Check if CHEM 150/160, CHEM 151/161 sequence is satisfied."
  (not (exists (Course {courseId == "CHEM 150"})))
  (not (exists (Course {courseId == "CHEM 160"})))
  (not (exists (Course {courseId == "CHEM 151"})))
  (not (exists (Course {courseId == "CHEM 161"})))
  =>
  (assert (no-chem-150-seq)))

;; GEOL 105/L, GEOL 106/L Sequence
(defrule lab-sci-geol-105
  "Check if GEOL 105/L, GEOL 106/L sequence is satisfied."
  (not (exists (Course {courseId == "GEOL 105"})))
  (not (exists (Course {courseId == "GEOL 105L"})))
  (not (exists (Course {courseId == "GEOL 106"})))
  (not (exists (Course {courseId == "GEOL 106L"})))
  =>
  (assert (no-geol-105-seq)))

;; PHYS 211/L, PHYS 212/L Sequence
(defrule lab-sci-phys-211
  "Check if PHYS 211/L, PHYS 212/L sequence is satisfied."
  (not (exists (Course {courseId == "PHYS 211"})))
  (not (exists (Course {courseId == "PHYS 211L"})))
  (not (exists (Course {courseId == "PHYS 212"})))
  (not (exists (Course {courseId == "PHYS 212L"})))
  =>
  (assert (no-phys-211-seq)))

;; PHYS 251/L, PHYS 252/L Sequence
(defrule lab-sci-phys-251
  "Check if PHYS 251/L, PHYS 252/L sequence is satisfied."
  (not (exists (Course {courseId == "PHYS 251"})))
  (not (exists (Course {courseId == "PHYS 251L"})))
  (not (exists (Course {courseId == "PHYS 252"})))
  (not (exists (Course {courseId == "PHYS 252L"})))
  =>
  (bind ?*lab-seq-credits* 10)
  (assert (no-phys-251-seq)))


;; One Year Lab Science Sequence Requirement
(defrule lab-sci-seq-req
  "Check if One Year Lab Science Sequence requirement is satisified."
  (no-biol-126-seq)
  (no-chem-121-seq)
  (no-chem-150-seq)
  (no-geol-105-seq)
  (no-phys-211-seq)
  (no-phys-251-seq)
  =>
  (assert (related-course-req-not-sat))
  (add (new Advice "RelatedRequirement" "One Year Lab Science Sequence requirement not satisfied." "A one year lab science sequence is required. See curriculum guide for qualifying courses." "ISSUE")))

;; Mathematics and Statistics Requirement
(defrule related-course-req-math-stats
  "Check if Mathematics and Statistics requirements are satisfied."
  (not (exists (Course {courseId == "MATH 166"})))
  (not (exists (Course {courseId == "STAT 367"})))
  (not (exists (Course {courseId == "STAT 368"})))
  =>
  (assert (related-course-req-not-sat))
  (add (new Advice "RelatedRequirement" "Mathematics and Statistics requirements not satisfied." "'Calculus II' (MATH 166), 'Probability' (STATS 367), and 'Statistics' (STATS 368) are required." "ISSUE")))

;; Additional Science Course Requirement
(defrule related-course-req-science
  "Check if Additional Science Course requirement is satisfied."
  ?totalCredits <- (accumulate (bind ?count 0)
			       (bind ?count (+ ?count ?credits))
			       ?count
			       (Course (credits ?credits) (courseId ?t&:(is-gen-ed ?t "S"))))
  (test (< (- ?totalCredits ?*lab-seq-credits*) 3))
  =>
  (assert (related-course-req-not-sat))
  (add (new Advice "RelatedRequirement" "Additional Science Course requirement not satisfied." "One additional 3-credit General Education course in the Science & Technology (S) area is required." "ISSUE")))

;; Related Courses Requirement
(defrule related-course-req
  "Check if Related Courses requirement is satisfied."
  (not (exists (related-course-req-not-sat)))
  =>
  (add (new Congrats "All Related Course requirements are satisfied.")))


;; COLLEGE REQUIREMENTS

;; Additional Humanities / Social Sciences Requirement
(defrule additional-human-soc-sci
  "Check if Additional Humanities / Social Sciences requirement is satisfied."
  (not (exists (Record (studentId ?s&:(additional-human-soc-sci-satisfied ?s)))))
  =>
  (assert (college-req-not-sat))
  (add (new Advice "CollegeRequirement" "Additional Humanities / Social Sciences requirement not satisfied." "An additional 9 credits in Humanities or Social Sciences are required. See curriculum guide for details, including restrictions." "ISSUE")))

;; College of Science & Mathematics Requirements
(defrule college-sci-math-req
  "Check if College of Science & Mathematics requirements are satisfied."
  (not (exists (college-req-not-sat)))
  (not (exists (gen-ed-not-satisfied)))
  (not (exists (bs-cs-degree-req-not-met)))
  =>
  (add (new Congrats "All College of Science & Mathematics requirements are satisfied.")))


;; BACHELOR OF SCIENCE REQUIREMENTS

;; Total Credits Requirement
(defrule total-credits-req
  "Check if Total Credits requirement is satisfied."
  ?r <- (Record)
  =>
  (if (< ?r.totalCredits ?*total-credit-req*) then (assert (not-enough-credits))
      else (assert (bs-sat))))

;; Total Credits Requirement (not satisfied)
(defrule total-credits-not-enough
  "Advise student if Total Credits requirement is not satisfied."
  (not-enough-credits)
  ?r <- (Record)
  =>
  (add (new Advice "BachelorScienceRequirement" "Too little credits" (str-cat "Have " ?r.totalCredits " credits, but need " ?*total-credit-req* ".") "ISSUE")))

;; Bachelor of Science Requirements
(defrule bachelor-science-req
  "Congratulate student if Bachelor of Science requirements are satisfied."
  (bs-sat)
  =>
  (add (new Congrats "All Bachelor of Science requirements are satisfied.")))


;; GRADUATING WITH HONOR

;; Critera for Graduating with Honor
(defrule graduate-with-honors
  "Check if student will graduate with honor and, if so, the specific honor achieved."
  ?record <- (Record {gpa >= 3.5})
  (not (exists (Course {grade == "NA"})))
  (not (exists (gen-ed-not-satisfied)))
  (not (exists (bs-cs-degree-req-not-met)))
  (not (exists (related-course-req-not-sat)))
  (not (exists (college-req-not-sat)))
  (bs-sat)
  =>
  (assert (honors))
  (if (>= ?record.gpa 3.90) then
    (add (new Congrats "You will graduate summa cum laude."))
   elif (>= ?record.gpa 3.70) then
    (add (new Congrats "You will graduate magna cum laude."))
   else
    (add (new Congrats "You will graduate cum laude."))))
