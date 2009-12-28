
;;**************
;;* DEFCLASSES *
;;**************

(defclass MAIN::Result
	(is-a USER)
	(single-slot value
		(type INSTANCE))
	(single-slot quantity
		(type INTEGER))
)

(defmodule MAIN (export ?ALL))


(deftemplate profiler
   (slot user_profile)
   (slot completed)
)

(defclass Recommendation
	(is-a USER)
	(role concrete)
;;	(slot user_profile)
	;;(slot score)
	(slot rental_offer)
	;;(slot is_proposed)
)


;;************
;;* MESSAGES *
;;************

(defmessage-handler RENTAL_OFFER print()
  (printout t "------------RENTAL OFFER-------------------" crlf)
;;  (format t "Rental Offer: %s%n" ?self:title) 
  (printout t (send ?self:residentialOffer print))
  (format t " Rent %f%n" ?self:rent)
  (printout t crlf)
 ;; (format t "Score: %f%n" ?self:score)
  (printout t crlf)
  (printout t "------------END OF OFFER-------------------" crlf)
)

(defmessage-handler RESIDENTIAL print()
;;  (printout t (send ?self:address)) 
;;  (format t "address of the residence: %s%n" ?self:address)
  (printout t "** Address **" crlf)
  (printout t (send ?self:address print))
  (printout t crlf)
  (printout t "** Address **" crlf)
)


(defmessage-handler CITY_ADDRESS print()
;;  (printout t (send ?self:address)) 
  (format t "Name of the Street : %s%n" ?self:street)
  (printout t crlf)
  (format t "Number on the Street: %d%n" ?self:number) 
  (printout t crlf)
)
 



;;****************
;;* DEFFUNCTIONS *
;;****************

(deffunction ask-open-question (?question)
	(format t "%s? " ?question)
	(bind ?question (read))
	?question
)




;;;*********
;;; RULES 
;;;*********

;;;---------------------------------------------------
;;;- Entry point into the system
;;;--------------------------------------------------

(defrule start
	(declare (salience 10))
	=>
	(printout t "------------------------------------------" crlf)
	(printout t "------ Expert system to find a house -----" crlf)
	(printout t "------------------------------------------" crlf)
	(printout t crlf)
	;;;go to module personal-questions
	(focus createUserProfile output) ;; todo ...modularize.
)


;;;------------------------------------------
;;;- create the user-profile
;;;------------------------------------------

(defmodule createUserProfile "Generate a user Profile"
	(import MAIN ?ALL)
	(export ?ALL)
)

(defrule user-name "Get the user name"
	(not (object (is-a USER_PROFILE)))
	=>
	(bind ?firstname (ask-open-question "What is your firstname"))
	(bind ?secondName (ask-open-question "What is your secondName"))
  ;;;create an instance of USER_PROFILE
	(bind ?user (make-instance user of USER_PROFILE))
  ;;;add this to our instance of USER_PROFILE
	(send ?user put-firstName ?firstname)
  (send ?user put-secondName ?secondName)
  ;;;insert this Person into recommendation
    
      ;;(bind ?recommend (make-instance user of Recommendation))
      ;;(send ?recommend put-user_profile ?user)
       
      (assert (profiler(user_profile ?user)(completed "FALSE")))


  ;;;add facts that our first and surname are ok
  (assert (userProfile firstName ok))
  (assert (userProfile secondName ok))
  (assert (userProfile complete ok))
)

;;;------------------------------------------
;;;- fetch available offers
;;;------------------------------------------

(defrule queryRentalOffers
	(userProfile complete ok)
        ?profiler <- (profiler (user_profile ?user)(completed "FALSE"))
	=>
    ;;;initialize our system and so get all instances of offer and copy them into
    ;;;a new instance proposal
   ;; (assert(loop-continue TRUE))
    (do-for-all-instances ((?offer RENTAL_OFFER))
     ;do-for condition

     ;do-for execution
     (make-instance of Recommendation (rental_offer ?offer))
    )
    (assert(loop-continue FALSE))
  ;;(assert(doneIs TRUE))
    (modify ?profiler(completed "TRUE"))

  ;;(focus output)
)


(defrule terminate "terminate the program"
  ;;(declare (salience -10))
  ;;?profiler <- (profiler (user_profile ?user) (completed "TERMINATE"))
   (doneIs TRUE)
	=>
  (printout t "---------------------------------------------------------------------" crlf)
  (printout t "Thank you for using our housing service" crlf)
  (printout t "---------------------------------------------------------------------" crlf)   
  (printout t crlf)  
  ;;(pop-focus)
)



;;;----------------------------------------------- -
;;;- define a module for the output of our program -
;;;-------------------------------------------------
(defmodule output "Module for outputting the results"
	(import MAIN ?ALL)
        (import createUserProfile ?ALL)
        (export ?ALL)
;;	(printout t "--------------------in output-------------------------------------------------" crlf)
)



(defrule printall
	?profiler <- (profiler (user_profile ?user)(completed "TRUE"))
        ;;(doneIs TRUE)
	=>
	(printout t "--------------------in printall-------------------------------------------------" crlf)
  ;;;%s stands for string
  ;;;%n stands for newline
	(format t "Sr/a. %s,%s%n" (send ?user get-firstName) (send ?user get-secondName))
	(printout t "This is the list of recommmendations" crlf crlf)
	(do-for-all-instances 
	    ((?recommendation Recommendation))
	  ;;  (eq (send ?proposal get-is_proposed) TRUE)
	    ;action
	    (printout t (send (send ?recommendation get-rental_offer) print))
	)
	(modify ?profiler (completed "TERMINATE"))
        (assert(doneIs TRUE))
	(printout t "-------------------doneISTRUE-------------------------------------------------" crlf)
	;;(pop-focus)
)


