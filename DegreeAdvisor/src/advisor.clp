;; First define templates for the model classes so we can use them
;; in our pricing rules. This doesn't create any model objects --
;; it just tells Jess to examine the classes and set up templates
;; using their properties

(import com.joshktan.advisor.model.*)
(deftemplate Course       (declare (from-class Course)))
(deftemplate GradedCourse   (declare (from-class GradedCourse)))
(deftemplate LabScienceSequence (declare (from-class LabScienceSequence)))
(deftemplate Record (declare (from-class Record)))
(deftemplate Advice (declare (from-class Advice)))


;; Global variables
(defglobal ?*total-credit-req* = (get-member com.joshktan.advisor.req.TotalCreditsRequirement TOTAL_CREDITS_REQUIRED))

;; University Graduation Requirements

(defrule total-credit-req
    "Advise to take more credits if total credit amount is less than the required amount."
    ?r <- (Record {totalCredits < ?*total-credit-req*})
    =>
    (add (new Advice "TotalCreditsRequirement" "Too little credits" (str-cat "Have " ?r.totalCredits " credits, but need " ?*total-credit-req* ".") "ISSUE")))


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

;; (defrule graduate-with-honors
;;   (forall (Course (CourseId ?i))
;; 	  (instanceof ?i "GradedCourse"))
;;   ;; add another rule to check GPA
  
;;   ;; add other requirements here
;;   =>
;;   ((System.out) println "Congrats, dude."))



;; (defrule 10%-volume-discount
;;     "Give a 10% discount to everybody who spends more than $100."
;;     ?o <- (Order {total > 100})
;;     =>
;;     (add (new Offer "10% volume discount" (/ ?o.total 10))))

;; (defrule 25%-multi-item-discount
;;     "Give a 25% discount on items the customer buys three or more of."
;;     (OrderItem {quantity >= 3} (price ?price))
;;     =>
;;     (add (new Offer "25% multi-item discount" (/ ?price 4))))

;; (defrule free-cd-rw-disks
;;     "If somebody buys a CD writer, send them a free sample of CD-RW
;;     disks, catalog number 782321; but only if they're a repeat customer.
;;     We use a regular expression to match the CD writer's description."
;;     (CatalogItem (partNumber ?partNumber) (description /CD Writer/))
;;     (CatalogItem (partNumber 782321) (price ?price))
;;     (OrderItem (partNumber ?partNumber))
;;     (Customer {orderCount > 1})
;;     =>	
;;     (add (new Offer "Free CD-RW disks" ?price)))

