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

;; Now define the pricing rules themselves. Each rule matches a set
;; of conditions and then creates an Offer object to represent a
;; bonus of some kind given to a customer. The rules assume that
;; there will be just one Order, its OrderItems, and its Customer in 
;; working memory, along with all the CatalogItems.

(defrule total-credit-req
    "Advise to take more credits if total credit amount is less 10."
    ?r <- (Record {totalCredits < 10})
    =>
    (add (new Advice "TotalCreditsRequirement" "Too little credits" "Details on too little credits" "ISSUE")))

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

