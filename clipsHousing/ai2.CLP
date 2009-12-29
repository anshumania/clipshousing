
;------------
; DEFCLASSES 
;------------

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


;------------------
; MESSAGE HANDLERS 
;------------------

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
 



;----------------
; DEFFUNCTIONS 
;----------------

(deffunction ask-open-question (?question)
	(format t "%s? " ?question)
	(bind ?question (read))
	?question
)




;--------------------------
; Entry point into the kbs
;--------------------------

(defrule startKBS
	(declare (salience 10))
	=>
	(printout t "------------------------------------------" crlf)
	(printout t "       Expert system to find a house      " crlf)
	(printout t "------------------------------------------" crlf)
	(printout t crlf)
	; execute modules in order  
        ; createUserProfile , output
	(focus createUserProfile output endKBS) ;; todo ...modularize.
)



;----------MODULES--------



;---------------------------------------------------------------
; Create a Profile for the User interacting with the KBS
; This module create an instance of USER_PROFILE by
; asking questions from the user interactiong with the KBS
; It also creates a profiler which the KBS uses to actively
; profile the user according to the information he/she provides
;---------------------------------------------------------------


(defmodule createUserProfile "Generate a user Profile"
	(import MAIN ?ALL)
	(export ?ALL)
)

(defrule user-name "Get the user name"
	(not (object (is-a USER_PROFILE)))
	=>
	(bind ?firstname (ask-open-question "What is your firstname"))
	(bind ?secondName (ask-open-question "What is your secondName"))
  ; create an instance of USER_PROFILE
	(bind ?user (make-instance user of USER_PROFILE))
  ; add the inputs the instance of USER_PROFILE
	(send ?user put-firstName ?firstname)
  	(send ?user put-secondName ?secondName)
  ; create the profiler for the user
        (assert (profiler(user_profile ?user)(completed "FALSE")))


  ; add a fact to indicate the userProfile is ok
  	;(assert (userProfile firstName ok))
	;(assert (userProfile secondName ok))
	(assert (userProfile complete ok))
)

;------------------------------------------
; Fetches all the available offers
;------------------------------------------

(defrule queryRentalOffers
	(userProfile complete ok)
        ?profiler <- (profiler (user_profile ?user)(completed "FALSE"))
	=>
    ; Initialize the KBS by fetching all offers and copying them into
    ; an instance of a Recommendation
	    (do-for-all-instances ((?offer RENTAL_OFFER))
		     ;do-for condition

		     ;do-for execution
	   	 (make-instance of Recommendation (rental_offer ?offer))
    	    )
    ; modify the profiler to indicate that it has got all the offers
	(modify ?profiler(completed "TRUE"))
)




;---------------------------------------------
; Module for printing out the Recommendations
;---------------------------------------------
(defmodule output "Module for printing the Recommendations"
	(import MAIN ?ALL)
        (import createUserProfile ?ALL)
        (export ?ALL)
)


(defrule printall
	?profiler <- (profiler (user_profile ?user)(completed "TRUE"))
	=>
	(printout t "--------------------in printall-------------------------------------------------" crlf)
  	(format t "Sr/a. %s,%s%n" (send ?user get-firstName) (send ?user get-secondName))
	(printout t " THE KBS recommends " crlf crlf)
	(do-for-all-instances 
	    ((?recommendation Recommendation))
	  ; todo only for recommendations which are at right recommendation level
	    (printout t (send (send ?recommendation get-rental_offer) print))
	)
	(modify ?profiler (completed "TERMINATE"))
        (assert(doneIs TRUE))
;	(printout t "-------------------doneISTRUE-------------------------------------------------" crlf)
	;;(pop-focus)
)


;---------------------------------------------
; Module to terminate the KBS
;---------------------------------------------
(defmodule endKBS "Termination MODULE"
	(import MAIN ?ALL)
        (import output ?ALL)
        (export ?ALL)
)


; Termination rule
(defrule terminate "terminate the program"
  ;;(declare (salience -10))
  ;;?profiler <- (profiler (user_profile ?user) (completed "TERMINATE"))
   (doneIs TRUE)
	=>
  (printout t "---------------------------------------------------------------------" crlf)
  (printout t " Hope you liked our recommendations. Than you for using our KBS      " crlf)
  (printout t "---------------------------------------------------------------------" crlf)   
  (printout t crlf)  
  ;;(pop-focus)
)




