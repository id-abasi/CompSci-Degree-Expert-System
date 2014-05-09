;; Define templates for model classes
(import com.joshktan.advisor.model.*)
(deftemplate Course
  (declare (from-class Course)))
(deftemplate Record
  (declare (from-class Record)))
(deftemplate Advice
  (declare (from-class Advice)))

;; GLOBAL VARIABLES
(defglobal ?*total-credit-req* = (get-member com.joshktan.advisor.req.BachelorScienceRequirement TOTAL_CREDITS_REQUIRED))
(defglobal ?*lab-seq-credits* = 8)

;; GEN ED REQUIREMENTS

;; First Year Experience (F) Requirements
(defrule gen-ed-f
  "Advise student if Gen Ed First Year Experience requirements not satisfied."
  (not (exists (Course {courseId == "UNIV 189"})))
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
  (add (new Advice "GenEdRequirement" "Gen Ed upper division requirements not satisfied" "Either Writing in the Technical Professions (ENGL 321) or Writing in the Sciences (ENGL 324) is required." "ISSUE")))

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
  (bind ?*lab-seq-credits* 10)
  (assert (no-phys-251-seq)))

(defrule lab-sci-seq-req
  (no-biol-126-seq)
  (no-chem-121-seq)
  (no-chem-150-seq)
  (no-geol-105-seq)
  (no-phys-211-seq)
  (no-phys-251-seq)
  =>
  (add (new Advice "RelatedRequirement" "Lab Science Sequence requirements not satisfied" "A one year sequence of lab science courses (with corresponding labs) is required." "ISSUE")))

;; B.S. COMPUTER SCIENCE REQUIREMENTS

;; "C" or better required for all CSCI courses
(defrule c-in-cs-course
  "Advise that will have to retake a CS course if it's a degree requirement and a D or worse received."
  (exists (Course (courseId ?cId&:(is-core ?cId))
 		  (grade "D"|"F")))
  =>
  (assert (bs-cs-degree-req-not-met))
  (add (new Advice "MajorRequirement" "Computer Science Major requirements not satisfied" "A grade of 'C' or better is required for all CSCI courses." "ISSUE")))

;; all core CSCI courses taken
(defrule core-courses-taken
  "Advise student if all core CSCI courses have not been taken."
  (not (exists (Record (studentId ?s&:(core-courses-satisfied ?s)))))
  =>
  (assert (bs-cs-degree-req-not-met))
  (add (new Advice "MajorRequirement" "Major requirements not satisfied" "All core CSCI courses have not been taken." "ISSUE")))

;; Computer Science Electives
(defrule cs-elective-req
  "Computer Science Elective requirements"
  (exists (elective-req-not-met))
  =>
  (assert (bs-cs-degree-req-not-met))
  (add (new Advice "MajorRequirement" "Computer Science Elective requirements not satisfied" "3 CS electives are required from at least 2 categories." "ISSUE")))

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

(defrule bs-cs-degree-req
  "Requirements for a B.S. in CS"
  (exists (bs-cs-degree-req-not-met))
  =>
  (add (new Advice "MajorRequirement" "Computer Science B.S. degree requirements not satisfied" "Must take all required core courses and at least 3 computer science electives." "ISSUE")))

;; RELATED REQUIRED COURSES
(defrule related-course-req
  (exists (related-course-req-not-sat))
  =>
  (add (new Advice "RelatedRequirement" "Related course requirements not satisfied." "See curriculum guide for details." "ISSUE")))

;; Related required courses (MATH and STATS)
(defrule related-course-req-math-stats
  (not (exists (Course {courseId == "MATH 166"})))
  (not (exists (Course {courseId == "STAT 367"})))
  (not (exists (Course {courseId == "STAT 368"})))
  =>
  (assert (related-course-req-not-sat))
  (add (new Advice "RelatedRequirement" "Related course requirements for mathemtatics and statistics not satisfied." "Calculus II (MATH 166), Probability (STATS 367), and Statistics (STATS 368) are required." "ISSUE")))

;; Additional Science course
(defrule related-course-req-science
  "Advise student if additional science course requirement not fulfilled."
  ?totalCredits <- (accumulate (bind ?count 0)                                                ;; initializer
			       (bind ?count (+ ?count ?credits))                              ;; action
			       ?count                                                         ;; result
			       (Course (credits ?credits) (courseId ?t&:(is-gen-ed ?t "S")))) ;; CE
  (test (< (- ?totalCredits ?*lab-seq-credits*) 3))
  =>
  (assert (related-course-req-not-sat))
  (add (new Advice "RelatedRequirement" "Related course requirements for additional science course not satisfied." "One additional science course that satisifies general education is required." "ISSUE")))

;; COLLEGE REQUIREMENTS
(defrule additional-human-soc-sci
  "Advise student if additional humanities and social sciences requirements not fulfilled."
  (not (exists (Record (studentId ?s&:(additional-human-soc-sci-satisfied ?s)))))
  =>
  (add (new Advice "CollegeRequirement" "College requirements not satisfied" "An additional 9 credits in Humanities or Social Sciences are required." "ISSUE")))


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
    (add (new Advice "BachelorScienceRequirement" "Too little credits" (str-cat "Have " ?r.totalCredits " credits, but need " ?*total-credit-req* ".") "ISSUE")))

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
