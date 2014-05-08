;; Define templates for model classes
(import com.joshktan.advisor.model.*)
(deftemplate Course
  (declare (from-class Course)))
(deftemplate Record
  (declare (from-class Record)))
(deftemplate Advice
  (declare (from-class Advice)))

;; GLOBAL VARIABLES
(defglobal ?*total-credit-req* = (get-member com.joshktan.advisor.req.TotalCreditsRequirement TOTAL_CREDITS_REQUIRED))

;; GEN ED REQUIREMENTS

;; First Year Experience (F) Requirements
(defrule gen-ed-f
  "Advise student if Gen Ed First Year Experience requirements not satisfied."
  (not (Course {courseId == "UNIV 189"}))
  =>
  (assert (gen-ed-ld-not-satisfied))
  (add (new Advice "GenEdRequirement" "Gen Ed First Year Experience requirements not satisfied" "Skills for Academic Success (UNIV 189) is required, but is not listed among courses." "ISSUE")))

;; Communication (C) Requirements
(defrule gen-ed-c
  "Advise student if Gen Ed Communication requirements not satisfied."
  (not (exists (Course {courseId == "COMM 110"})))
  (not (exists (Course {courseId == "ENGL 110"})))
  (not (exists (Course {courseId == "ENGL 120"})))
  =>
  (assert (gen-ed-ld-not-satisfied))
  (add (new Advice "GenEdRequirement" "Gen Ed Communication requirements not satisfied" "College Composition I (ENGL 110), College Composition II (ENGL 120), and Fundamentals of Public Speaking (COMM 110) are required." "ISSUE")))

;; Quantitative Reasoning (R) Requirements
(defrule gen-ed-r
  "Advise student if Gen Ed Quantitative Reasoning requirements not satisfied."
  (not (Course {courseId == "MATH 165"}))
  =>
  (assert (gen-ed-ld-not-satisfied))
  (add (new Advice "GenEdRequirement" "Gen Ed Quantitative Reasoning requirements not satisfied" "Calculus I (MATH 165) is required, but is not listed among courses." "ISSUE")))

;; Science & Technology (S) Requirements
;; TODO - make sure all different
(defrule gen-ed-s
  "Advise student if Gen Ed Science & Technology requirements not satisfied."
  ?totalCredits <- (accumulate (bind ?count 0)                                                ;; initializer
			       (bind ?count (+ ?count ?credits))                              ;; action
			       ?count                                                         ;; result
			       (Course (credits ?credits) (courseId ?t&:(is-gen-ed ?t "S")))) ;; CE
  (test (< ?totalCredits 10))
  =>
;;  ((System.out) println (?totalCredits toString))
  (assert (gen-ed-ld-not-satisfied))
  (add (new Advice "GenEdRequirement" "Gen Ed Science & Technology requirements not satisfied" "At least 10 credits in the General Education Science and Technology area are required." "ISSUE")))

;; Humanities & Fine Arts (A) Requirements
;; TODO - make sure all different
(defrule gen-ed-a
  "Advise student if Gen Ed Humanities & Fine Arts requirements not satisfied."
  ?totalCredits <- (accumulate (bind ?count 0)                                                ;; initializer
			       (bind ?count (+ ?count ?credits))                              ;; action
			       ?count                                                         ;; result
			       (Course (credits ?credits) (courseId ?t&:(is-gen-ed ?t "A")))) ;; CE
  (test (< ?totalCredits 6))
  =>
  (assert (gen-ed-ld-not-satisfied))
  (add (new Advice "GenEdRequirement" "Gen Ed Humanities & Fine Arts requirements not satisfied" "At least 6 credits in the General Education Humanities & Fine Arts area are required." "ISSUE")))

;; Social & Behavioral Sciences (B) Requirements
;; TODO - make sure all different
(defrule gen-ed-b
  "Advise student if Gen Ed Social & Behavioral Sciences requirements not satisfied."
  ?totalCredits <- (accumulate (bind ?count 0)                                                ;; initializer
			       (bind ?count (+ ?count ?credits))                              ;; action
			       ?count                                                         ;; result
			       (Course (credits ?credits) (courseId ?t&:(is-gen-ed ?t "B")))) ;; CE
  (test (< ?totalCredits 6))
  =>
  (assert (gen-ed-ld-not-satisfied))
  (add (new Advice "GenEdRequirement" "Gen Ed Social & Behavioral Sciences requirements not satisfied" "At least 6 credits in the General Education Social & Behavioral Sciences area are required." "ISSUE")))

;; Wellness (W) Requirements
;; TODO - make sure all different
(defrule gen-ed-w
  "Advise student if Gen Ed Wellness requirements not satisfied."
  ?totalCredits <- (accumulate (bind ?count 0)                                                ;; initializer
			       (bind ?count (+ ?count ?credits))                              ;; action
			       ?count                                                         ;; result
			       (Course (credits ?credits) (courseId ?t&:(is-gen-ed ?t "W")))) ;; CE
  (test (< ?totalCredits 2))
  =>
  (assert (gen-ed-ld-not-satisfied))
  (add (new Advice "GenEdRequirement" "Gen Ed Wellness requirements not satisfied" "At least 6 credits in the General Education Wellness area are required." "ISSUE")))

;; Cultural Diversity (D) Requirements
(defrule gen-ed-d
  "Advise student if Gen Ed Cultural Diversity requirements not satisfied."
  (not (exists (Course (courseId ?t&:(is-gen-ed ?t "D")))))
  =>
  (assert (gen-ed-ld-not-satisfied))
  (add (new Advice "GenEdRequirement" "Gen Ed Cultural Diversity requirements not satisfied" "At least 1 course in the General Education Cultural Diversity area is required." "ISSUE")))

;; Global Perspectives (G) Requirements
(defrule gen-ed-g
  "Advise student if Gen Ed Global Perspectives requirements not satisfied."
  (not (exists (Course (courseId ?t&:(is-gen-ed ?t "G")))))
  =>
  (assert (gen-ed-ld-not-satisfied))
  (add (new Advice "GenEdRequirement" "Gen Ed Global Perspectives requirements not satisfied" "At least 1 course in the General Education Global Perspectives area is required." "ISSUE")))

;; Gen Ed Lower Division Requirements
(defrule gen-ed-ld
  "Adivce student if Gen Ed lower division requirements are not satisfied."
  (exists (gen-ed-ld-not-satisfied))
  =>
  (assert (gen-ed-not-satisfied))
  (add (new Advice "GenEdRequirement" "Gen Ed lower division requirements not satisfied" "See curriculum guide for details." "ISSUE")))

;; Gen Ed Upper Division Requirements
(defrule gen-ed-ud
  "Advise student if Gen Ed upper division requirements not satisfied."
  (not (exists (Course {courseId == "ENGL 321" || courseId == "ENGL 324"})))
  =>
  (assert (gen-ed-not-satisfied))
  (add (new Advice "GenEdRequirement" "Gen Ed upper division requirements not satisfied" "Either Writing in the Technical Professions (ENGL 321) or Writing in the Sciences (ENGL 324) is required, but neither is listed among courses." "ISSUE")))

;; Gen Ed Requirements
(defrule gen-ed
  "Advise student if Gen Ed requirements not satisfied."
  (or (exists (gen-ed-ld-not-satisfied)) (exists (gen-ed-ud-not-satisfied)))
  =>
  (assert (deg-req-not-satisfied))
  (add (new Advice "GenEdRequirement" "Gen Ed requirements not satisfied" "See curriculm guide for details." "ISSUE")))



;; One Year Lab Science Sequence Requirement
(defrule lab-sci-biol-126
  (not (exists (Course {courseId == "BIOL 126"})))
  (not (exists (Course {courseId == "BIOL 126L"})))
  (not (exists (Course {courseId == "BIOL 220"})))
  (not (exists (Course {courseId == "BIOL 220L"})))
  =>
  (assert (no-biol-126-seq)))

(defrule lab-sci-chem-121
  (not (exists (Course {courseId == "CHEM 121"})))
  (not (exists (Course {courseId == "CHEM 121L"})))
  (not (exists (Course {courseId == "CHEM 122"})))
  (not (exists (Course {courseId == "CHEM 122L"})))
  =>
  (assert (no-chem-121-seq)))

(defrule lab-sci-chem-150
  (not (exists (Course {courseId == "CHEM 150"})))
  (not (exists (Course {courseId == "CHEM 160"})))
  (not (exists (Course {courseId == "CHEM 151"})))
  (not (exists (Course {courseId == "CHEM 161"})))
  =>
  (assert (no-chem-150-seq)))

(defrule lab-sci-geol-105
  (not (exists (Course {courseId == "GEOL 105"})))
  (not (exists (Course {courseId == "GEOL 105L"})))
  (not (exists (Course {courseId == "GEOL 106"})))
  (not (exists (Course {courseId == "GEOL 106L"})))
  =>
  (assert (no-geol-105-seq)))

(defrule lab-sci-phys-211
  (not (exists (Course {courseId == "PHYS 211"})))
  (not (exists (Course {courseId == "PHYS 211L"})))
  (not (exists (Course {courseId == "PHYS 212"})))
  (not (exists (Course {courseId == "PHYS 212L"})))
  =>
  (assert (no-phys-211-seq)))

(defrule lab-sci-phys-251
  (not (exists (Course {courseId == "PHYS 251"})))
  (not (exists (Course {courseId == "PHYS 251L"})))
  (not (exists (Course {courseId == "PHYS 252"})))
  (not (exists (Course {courseId == "PHYS 252L"})))
  =>
  (assert (no-phys-251-seq)))

(defrule lab-sci-seq-req
  (no-biol-126-seq)
  (no-chem-121-seq)
  (no-chem-150-seq)
  (no-geol-105-seq)
  (no-phys-211-seq)
  (no-phys-251-seq)
  =>
  (add (new Advice "LabScienceRequirement" "Lab Science Sequence requirements not satisfied" "A one year sequence of lab science courses (with corresponding labs) is required." "ISSUE")))

;; B.S. COMPUTER SCIENCE REQUIREMENTS

;; "C" or better required for all CSCI courses
(defrule c-in-cs-course
  "Advise that will have to retake a CS course if it's a degree requirement and a D or worse received."
  (exists (Course (courseId ?cId&:(is-core ?cId))
 		  (grade "D"|"F")))
  =>
  (add (new Advice "MajorRequirement" "Computer Science Major requirements not satisfied" "A grade of 'C' or better is required for all CSCI courses." "ISSUE")))

;; all core CSCI courses taken
(defrule core-courses-taken
  "Advise student if all core CSCI courses have not been taken."
  (not (exists (Record (studentId ?s&:(core-courses-satisfied ?s)))))
  =>
  (add (new Advice "MajorRequirement" "Major requirements not satisfied" "All core CSCI courses have not been taken." "ISSUE")))

;; Computer Science Electives
(defrule cs-elective-req
  "Computer Science Elective requirements"
  (exists (elective-req-not-met))
  =>
  (add (new Advice "ElectiveRequirement" "Computer Science Elective requirements not satisfied" "3 CS electives are required from at least 2 categories." "ISSUE")))

(defrule cs-elective-req-credits
  "Credit subrequirement for Computer Science Elective requirements"
  ?totalCourses <- (accumulate (bind ?count 0)
			       (bind ?count (+ ?count 1))
			       ?count
			       (Course (courseId ?cId&:(is-elective ?cId))))
  (test (< ?totalCourses 3))
  =>
  (assert (elective-req-not-met)))

(defrule cs-elective-req-cat
  "Category subrequirement for Computer Science Elective requirements"
  (not (exists (Record (studentId ?sId&:(at-least-2-elect-cat ?sId)))))
  =>
  (assert (elective-req-not-met)))

;; Related required courses (MATH and STATS)
(defrule related-course-req
  (not (exists (Course {courseId == "MATH 166"})))
  (not (exists (Course {courseId == "STAT 367"})))
  (not (exists (Course {courseId == "STAT 368"})))
  =>
  (add (new Advice "RelatedRequirement" "Related course requirements for mathemtatics and statistics not satisfied." "Calculus II (MATH 166), Probability (STATS 367), and Statistics (STATS 368) are required." "ISSUE")))

;; UNIVERSITY GRADUATION REQUIREMENTS
;; Total Degree Credits Requirement
(defrule total-credits
    "Advise to take more credits if total credit amount is less than the required amount."
    ?r <- (Record)
    =>
    (if (< ?r.totalCredits ?*total-credit-req*) then
    (assert (not-enough-credits))
    else
    (assert (enough-credits))))

(defrule not-enough-credits
    "Advise to take more credits if total credit amount is less than the required amount."
    (not-enough-credits)
    ?r <- (Record)
    =>
    (add (new Advice "TotalCreditsRequirement" "Too little credits" (str-cat "Have " ?r.totalCredits " credits, but need " ?*total-credit-req* ".") "ISSUE")))

;; CRITERA FOR GRADUATING WITH HONOR
(defrule graduate-with-honors
  ?record <- (Record {gpa >= 3.5})
  (not (exists (Course {grade == "NA"})))
  ;; TODO add other requirements here
  =>
   (assert (honors))
    (if (>= ?record.gpa 3.90) then
      (add (new Congrats "You will graduate summa cum laude."))
     elif (>= ?record.gpa 3.70) then
      (add (new Congrats "You will graduate magna cum laude."))
     else
      (add (new Congrats "You will graduate cum laude."))))

;; ---------------------------------------------------------------------- ;;

;; Just so you know how to do it
;; (defrule enough-credits-and-honors
;;   "enough credits and honors also"
;;   (and (honors) (enough-credits))
;;   =>
;;   ((System.out) println "Both enough credits and also honorable!"))

;; (# semesters left * 20 ) < (needed - already have) => advise warning: fill out form thing for +20 credits / semester (or summer school or postpone grad)

;; Graduating Honors (figure out how to chain rules: (if all courses have grades) && (all requirements fulfilled) => (add congrats)

;; COULD BE USEFUL:
;; The not CE can be used in arbitrary combination with the and and or CEs. You can define complex logical structures this way. For example, suppose you want a rule to fire once if for every fact (a ?x), there is a fact (b ?x). You could express that as
;; Jess> (defrule forall-example
;;   (not (and (a ?x) (not (b ?x))))
;;   =>)
;; i.e., "It is not true that for some ?x, there is an (a ?x) and no (b ?x)". This is actually how the the forall CE is implemented.

;; note: (instanceof <external-address> <class-name>)

;; COULD ALSO BE USEFUL
;; The logical conditional element lets you specify logical dependencies among facts. All the facts asserted on the RHS of a rule become dependent on the matches to the logical patterns on that rule's LHS. If any of the matches later become invalid, the dependent facts are retracted automatically.
;; (defrule rule-1
;;   (logical (faucet-open))
;;   =>
;;   (assert (water-flowing)))
;;   =>
;;   (assert (all-cour)))

;; Graduation with honor eligibility is determined in two steps:
;; Step One: Earn a minimum NDSU (institutional) GPA of 3.50
;; NDSU GPA's below 3.50 are not considered (and step two is not necessary)
;; Step Two: Earn an overall (cumulative) GPA of 3.50 or greater, which includes:
;; all credits and grades earned at NDSU
;; the inclusion of all transfer work and all attempts of repeated coursework
;;
;; Candidates who achieve an overall GPA of 3.50 or higher according to the criteria listed above will graduate: 
;; Cum Laude — greater than or equal to 3.50 and less than 3.70 
;; Magna Cum Laude — greater than or equal to 3.70 and less than 3.90 
;; Summa Cum Laude — greater than or equal to 3.90 and up to 4.00 
;; The complete Graduation with Honor policy may be reviewed in the online Undergraduate Bulletin
;; PLEASE BE AWARE grade-point averages are NOT rounded (for example, a GPA of 3.497 is not rounded to 3.5) 
;; PLEASE BE AWARE graduation with honor levels are subject to change once final grades are determined and posted to the official academic record

;; ;; matches any
;; (defrule any
;;   (Record (studentId ?sId))
;;   =>
;;   ((System.out) println "Testing 1,2,3" ))

;; Old rule - University Graduation Requirements
;; (defrule total-credit-req
;;     "Advise to take more credits if total credit amount is less than the required amount."
;;     ?r <- (Record {totalCredits < ?*total-credit-req*})
;;     =>
;;    (assert (enough-credits))
;;     (add (new Advice "TotalCreditsRequirement" "Too little credits" (str-cat "Have " ?r.totalCredits " credits, but need " ?*total-credit-req* ".") "ISSUE")))
