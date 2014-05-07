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
  (not (Course {title == "UNIV 189"}))
  =>
  (assert (gen-ed-f-not-satisfied))
  (add (new Advice "GenEdRequirement" "Gen Ed First Year Experience requirements not satisfied" "Skills for Academic Success (UNIV 189) is required, but is not listed among courses." "ISSUE")))

;; Communication (C) Requirements
(defrule gen-ed-c
  "Advise student if Gen Ed Communication requirements not satisfied."
  (not (exists (Course {title == "COMM 110"})))
  (not (exists (Course {title == "ENGL 110"})))
  (not (exists (Course {title == "ENGL 120"})))
  =>
  (assert (gen-ed-c-not-satisfied))
  (add (new Advice "GenEdRequirement" "Gen Ed Communication requirements not satisfied" "College Composition I (ENGL 110), College Composition II (ENGL 120), and Fundamentals of Public Speaking (COMM 110) are required." "ISSUE")))

;; Quantitative Reasoning (R) Requirements
(defrule gen-ed-r
  "Advise student if Gen Ed Quantitative Reasoning requirements not satisfied."
  (not (Course {title == "MATH 165"}))
  =>
  (assert (gen-ed-r-not-satisfied))
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
  (assert (gen-ed-s-not-satisfied))
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
  (assert (gen-ed-a-not-satisfied))
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
  (assert (gen-ed-b-not-satisfied))
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
  (assert (gen-ed-w-not-satisfied))
  (add (new Advice "GenEdRequirement" "Gen Ed Wellness requirements not satisfied" "At least 6 credits in the General Education Wellness area are required." "ISSUE")))

;; Cultural Diversity (D) Requirements
(defrule gen-ed-d
  "Advise student if Gen Ed Cultural Diversity requirements not satisfied."
  (not (exists (Course (courseId ?t&:(is-gen-ed ?t "D")))))
  =>
  (assert (gen-ed-w-not-satisfied))
  (add (new Advice "GenEdRequirement" "Gen Ed Cultural Diversity requirements not satisfied" "At least 1 course in the General Education Cultural Diversity area is required." "ISSUE")))

;; Global Perspectives (G) Requirements
(defrule gen-ed-g
  "Advise student if Gen Ed Global Perspectives requirements not satisfied."
  (not (exists (Course (courseId ?t&:(is-gen-ed ?t "G")))))
  =>
  (assert (gen-ed-g-not-satisfied))
  (add (new Advice "GenEdRequirement" "Gen Ed Global Perspectives requirements not satisfied" "At least 1 course in the General Education Global Perspectives area is required." "ISSUE")))

;; Gen Ed Lower Division Requirements
(defrule gen-ed-ld
  "Adivce student if Gen Ed lower division requirements are not satisfied."
  (or (gen-ed-f-not-satisfied)
      (gen-ed-c-not-satisfied)
      (gen-ed-r-not-satisfied)
      (gen-ed-s-not-satisfied)
      (gen-ed-a-not-satisfied)
      (gen-ed-b-not-satisfied)
      (gen-ed-w-not-satisfied)
      (gen-ed-d-not-satisfied)
      (gen-ed-g-not-satisfied))
  =>
  (add (new Advice "GenEdRequirement" "Gen Ed lower division requirements not satisfied" "See curriculum guide for details." "ISSUE")))

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
