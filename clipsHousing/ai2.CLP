
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
   (slot currentState)
)

(defclass Recommendation
	(is-a USER)
	(role concrete)
;;	(slot user_profile)
	(slot recoScore)
	(slot residential)
        (slot recommendationLevel)
	(slot recommendationCharacteristics)
	(slot recommendationUserPrefs
	(type STRING)
        (create-accessor read-write)
        )
)


;------------------
; MESSAGE HANDLERS 
;------------------



;(defmessage-handler SYMBOL print()
;  (str-cat ?self "")
;)

(defmessage-handler Coordinates print()
;;  (printout t (send ?self:address)) 
  (format t "X : %d" ?self:X_Coord)
  (format t "Y : %d" ?self:Y_Coord) 
)


(defmessage-handler CITY_ADDRESS print()
; (printout t " [ " (send (send ?self get-locCoordinates) print) " ]") 
 (printout t " [ " (send ?self:locCoordinates print ) " ]") 
;  (format t "Name of the Street : %s%n" ?self:street)
;  (printout t crlf)
;  (format t "Number on the Street: %d%n" ?self:number) 
;  (printout t crlf)
;  (format t "Address attribute :  %s%n" ?self get-locAttribute) 
;  (printout t crlf)
)


(defmessage-handler RESIDENTIAL print()
;;  (printout t (send ?self:address)) 
;;  (format t "address of the residence: %s%n" ?self:address)
  (printout t "Address [")
  (format t " Number, Street %d, %s%n" ?self:number ?self:street)	
  (printout t (send ?self:address print))
  (printout t crlf)
 
  (printout t "]")
  (format t " Rent %f%n" ?self:rent)
  (printout t crlf)
 ; (format t "Recommendation Characteristics : %s%n" ?self:recommendationCharacteristics)
 ; (printout t crlf)

)


;(defmessage-handler RENTAL_OFFER print()
;  (printout t "------------RENTAL OFFER-------------------" crlf)
;;  (format t "Rental Offer: %s%n" ?self:title) 
;  (printout t (send ?self:residentialOffer print))
;  (format t " Rent %f%n" ?self:rent)
;  (printout t crlf)
;  (format t "Recommendation Characteristics : %s%n" ?self:recommendationCharacteristics)
 ;; (format t "Score: %f%n" ?self:score)
;  (printout t crlf)
;  (printout t "------------END OF OFFER-------------------" crlf)
;)



 
(defmessage-handler SERVICES print()
  (format t "Type of the Service : %s%n" ?self:typeOfTheService)
  (printout t crlf)
)

(defmessage-handler Recommendation print()
  (printout t (send ?self:residential print))
  (printout t "RecommendationScore : " ?self:recoScore crlf)
  (printout t "RecommendationChars : " ?self:recommendationCharacteristics crlf)
  (printout t "RecommendationUserPrefs : " ?self:recommendationUserPrefs crlf)
  (printout t "RecommendationLevel : " ?self:recommendationLevel crlf)
  (printout t crlf)
)



;----------------
; DEFFUNCTIONS 
;----------------

; a question which is asked
(deffunction ask-question (?question $?allowed-values)
   (printout t ?question)
   (bind ?answer (read))
   (if (lexemep ?answer) 
       then (bind ?answer (lowcase ?answer)))
   (while (not (member ?answer ?allowed-values)) do
      (printout t ?question)
      (bind ?answer (read))
      (if (lexemep ?answer) 
          then (bind ?answer (lowcase ?answer))))
   ?answer)



; an open question
(deffunction ask-open-question (?question)
	(format t "%s? " ?question)
	(bind ?question (read))
	?question
)

; a yes/no question
(deffunction yes-or-no (?question)
   (bind ?response (ask-question ?question yes no y n))
   (if (or (eq ?response yes) (eq ?response y))
       then TRUE 
       else FALSE)
)

; a number range question
(deffunction ask-number (?question ?range-start ?range-end)
	(format t "%s? [%d, %d] " ?question ?range-start ?range-end)
	(bind ?response (read))
	(while (not(and(>= ?response ?range-start)(<= ?response ?range-end))) do
		(format t "%s? [%d, %d] " ?question ?range-start ?range-end)
		(bind ?response (read))
	)
	?response
)


; calculate the distance between two co-ordinates
(deffunction distance (?c1 ?c2)
	(bind ?result 0.0)
	(bind ?x (- (send ?c1 get-X_Coord) (send ?c2 get-X_Coord)))
	(bind ?y (- (send ?c1 get-Y_Coord) (send ?c2 get-Y_Coord)))
	(bind ?result (sqrt (+ (** ?x 2) (** ?y 2))))
	?result
)


; calculate distance between two addresses
(deffunction calculate-distance (?address1 ?address2)
  ;(printout t (send ?adr1  print) crlf)
  ;(printout t (send ?adr2 get-coordinates) crlf)
  (bind ?result (distance (send ?address1 get-locCoordinates) (send ?address2 get-locCoordinates)))
  ?result
)

; calculate the nearness based on the distance
(deffunction compare-distance (?d1)
 ( if(<= ?d1 500 ) 
	then (bind ?result NEAR)
	else
		(if(<= ?d1 1000 )
		then (bind ?result MID-DISTANCE)
		else (bind ?result FAR)
		)
)

  ?result
)


; calculate the bonus for the nearness 
(deffunction bonus-nearness (?n1)

(if(=( str-compare ?n1 "NEAR")0 )
	then (bind ?result 5)
	else
		(if(=( str-compare ?n1 "MID-DISTANCE")0 )
		then (bind ?result 2)
		else (bind ?result 0)
		)
)

  ?result
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
	(focus createUserProfile kbsProfiler advancedProfiler factProfiler  output endKBS) ;; todo ...modularize.
	;(focus factProfiler output endKBS) ;; todo ...modularize.
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
	
	(printout t "Kindly interact with the KBS to get personalized recommendations " crlf)
	(bind ?firstname (ask-open-question "What is your firstname"))
	(bind ?secondName (ask-open-question "What is your secondName"))
  ; create an instance of USER_PROFILE
	(bind ?user (make-instance user of USER_PROFILE))
  ; add the inputs the instance of USER_PROFILE
	(send ?user put-firstName ?firstname)
  	(send ?user put-secondName ?secondName)
  ; create the profiler for the user
        (assert (profiler(user_profile ?user)(currentState "GOTNAME")))


  ; add a fact to indicate the userProfile is ok
  	;(assert (userProfile firstName ok))
	;(assert (userProfile secondName ok))
	(assert (userProfile complete ok))
)

;------------------------------------------
; Fetches all the available offers
;------------------------------------------

(defrule queryRentalOffers
;	(userProfile complete ok)
        ?profiler <- (profiler (user_profile ?user)(currentState "GOTNAME"))
	=>
    ; Initialize the KBS by fetching all offers and copying them into
    ; an instance of a Recommendation
	    (do-for-all-instances ((?offer RESIDENTIAL))
		     ;do-for condition
;	(printout t "--------------------makingInstance-------------------------------------------------" crlf)

		     ;do-for execution
	 (make-instance of Recommendation (residential ?offer)(recoScore 0)(recommendationCharacteristics "")(recommendationUserPrefs "")(recommendationLevel ""))
    ; modify the profiler to indicate that it has got all the offers
	(modify ?profiler(currentState "FETCHEDOFFERS"))
)
)

;------------------------------------------
; Module that actually profiles the user
;------------------------------------------

(defmodule kbsProfiler "Module for profiling the user"
	(import MAIN ?ALL)
        (import createUserProfile ?ALL)
        (export ?ALL)
)

;------------------------------------------
; Assert preferences based on age ,
; occupation , activities , mode of transport
;------------------------------------------

(defrule determine-user-age "Determines the age of the user being Profiled"
   (not (profiled-user age ?))
   ?profiler <- (profiler (user_profile ?user)(currentState "FETCHEDOFFERS"))
   ;(not (repair ?))
   =>
   (if (yes-or-no "Is your age above 35 (yes/no)? ") 
       then 
       (if (yes-or-no "Is your age below 55 (yes/no)? ")
           then (assert (profiled-user age middle))
           else (assert (profiled-user age elderly))
       )
   else 
       (assert (profiled-user age young))
  )
  (modify ?profiler(currentState "DETERMINEDAGEGROUP"))
)

(defrule determine-mode-of-transport "Determines whether the user will prefer public or his own transport"
   (profiled-user age ?)
   (not (profiled-user modeOfTransport ?))
   ?profiler <- (profiler (user_profile ?user)(currentState "DETERMINEDAGEGROUP"))
;   (not (repair ?))   
   =>
   (if (yes-or-no "Do you own a car (yes/no)? ")
       then
       (assert (profiled-user modeOfTransport ownCar))
;       (assert (spark-state engine irregular-spark))
   else
       (assert (profiled-user modeOfTransport public))       
       (assert (profiled-user publicTransport NEAR))
  )
  (modify ?profiler(currentState "DETERMINEDMODEOFTRANSPORT"))
)


; Get the weekend activities
(defrule determine-weekend-activities "Determines the weekend activities of a profiled person"
   (profiled-user age ?)
   (profiled-user modeOfTransport ?)
   (not (profiled-user weekendActivity ?))
   (not (profiled-user watchLiveMatches ?))
   ?profiler <- (profiler (user_profile ?user)(currentState "DETERMINEDMODEOFTRANSPORT"))   
   =>
   
   (bind ?activity (ask-question "What do you generally do on weekends ? ( dine clubbing sports movie ) " dine clubbing sports movie))
   (assert (profiled-user weekendActivity ?activity))


   (if (yes-or-no "Is your favourite team AnyWhereTownClub (yes/no)? ")
       then
       (assert (profiled-user watchLiveMatches stadium))
   else
       (assert (profiled-user watchLiveMatches none))       
   )
  (modify ?profiler(currentState "DETERMINEDWEEKENDACTIVITIES"))
)

; Determine daily routines
(defrule determine-shop-routine "Determines the shopping routine of a person"
   (profiled-user age ?)
   (profiled-user modeOfTransport ?)
   (profiled-user watchLiveMatches ?)
   (not (profiled-user shoppingMode ?))
   ?profiler <- (profiler (user_profile ?user)(currentState "DETERMINEDWEEKENDACTIVITIES"))   

   =>
   
  (if (yes-or-no "Do you shop in bulk (yes/no)? ") 
       then 
       (if (yes-or-no "Do you prefer discounts in your purchases ? (yes/no)? ")
           then (assert (profiled-user shoppingMode superMarket))
           else (assert (profiled-user shoppingMode shoppingCenter))
       )
   else 
       (assert (profiled-user shoppingMode miniMarket))
  )
  (modify ?profiler(currentState "DETERMINEDSHOPROUTINE"))
)

; Determine the budget of the profiled user
(defrule determine-budget " Determines the maximum budget of the profiled user"
        (profiled-user age ?)
        (profiled-user modeOfTransport ?)
        (not (profiled-user budget ?))
	?profiler <- (profiler (user_profile ?user)(currentState "DETERMINEDSHOPROUTINE"))

	=>

	(bind ?maximumBudget (ask-number "What is your maximum budget ? " 500 5000))
 	(if (yes-or-no "Is this budget fixed (not negotiable) (yes/no) ?" ) 
         then
	    ( send ?user put-maxBudget (* ?maximumBudget 1.375 ))
	  else
	    ( send ?user put-maxBudget ?maximumBudget)
	)
  (modify ?profiler(currentState "ADVANCEDPROFILING"))
  )


;---------------------------------------------
; Advance analysis after trivial questions
;---------------------------------------------


(defmodule advancedProfiler "Module for advance Profiling of the user"
	(import MAIN ?ALL)
        (import createUserProfile ?ALL)
        (import kbsProfiler ?ALL)
        (export ?ALL)
)



(defrule uni-person "Advanced profiling for person  who studies"
	(profiled-user age ?)
        (profiled-user modeOfTransport ?transport)
	(not(profiled-user university ?))
	?profiler <- (profiler (user_profile ?user)(currentState "ADVANCEDPROFILING"))
	=>
	
       	(if (yes-or-no "Do you study (yes/no) ?" ) 
         then
	    (bind ?university (ask-number "Which University ? (1) UPC (2) ESADE (3) IESE (4) UB " 1 4 ))
		
	    (if(= ?university 1) then (assert(profiled-user university UPC)))
	    (if(= ?university 2) then (assert(profiled-user university ESADE)))
	    (if(= ?university 3) then (assert(profiled-user university IESE)))
	    (if(= ?university 4) then (assert(profiled-user university UB)))
		
        else
	    (assert(profiled-user university none))
	)

            ; young person characteristics
	    (assert(profiled-user bars NEAR))
	    (assert(profiled-user clubs NEAR))
            (assert(profiled-user sports NEAR))

;  (modify ?profiler(currentState "FINISHED"))
)


(defrule married-person "Advanced profiling for a married person "
        (profiled-user age ?)
        (profiled-user modeOfTransport ?transport)
	(not(profiled-user married ?))
	?profiler <- (profiler (user_profile ?user)(currentState "ADVANCEDPROFILING"))
	=>
	
 	(if (yes-or-no "Are you married (yes/no) ?" ) 
         then
	     ; person is married
             (assert(profiled-user married YES))

	     (if (yes-or-no "Do you have children (yes/no) ?" ) 	
		then
		    (bind ?homeType (ask-number "What are you planning on renting ? (1) House (2) Apartment (3) Undecided " 1 3 ))
		
		    (if(= ?homeType 1) then (assert(profiled-user homeType house)))
		    (if(= ?homeType 2) then (assert(profiled-user homeType apartment)))
		    (if(= ?homeType 3) then (assert(profiled-user homeType Undecided)))
		
		; children need schools 
		(assert(profiled-user school NEAR))
		(assert(profiled-user locationPref moderate))
                ; going to take the whole house
                (assert(profiled-user rooms 3)) 

	    )	
	
        else
	    ; an unmarried person does not want the whole house
	    (assert(profiled-user homeType Apartment))

	    (bind ?rooms (ask-number "How many rooms you looking for ? (1) One (2) Two or More (3) Whole Flat " 1 3 ))
	    (assert(profiled-user rooms ?rooms))
            (assert(profiled-user married NO))


	)


)

(defrule house-specifications "Advanced questions for house"
 ?profiler <- (profiler (user_profile ?user)(currentState "ADVANCEDPROFILING"))
 (profiled-user university ?)
 (profiled-user married ?)
 (not(profiled-user advanced ?))
 =>
   (if (yes-or-no "Are you looking for some specific features for your house (yes/no) ?" ) 
         then
              (if (yes-or-no "Do you wish for temperature control features in your house (yes/no) ?" ) 
		then (assert(profiled-user temperatureControl TRUE))
		else (assert(profiled-user temperatureControl FALSE))
	      )
	    (bind ?furnishing (ask-number "Preference of Furnishing ? (1) Semi (2) Fully (3) Doesnt Matter" 1 3 ))
;	    (assert(profiled-user furnishing ?furnishing))

		    (if(= ?furnishing 1) then (assert(profiled-user furnishing semi)))
		    (if(= ?furnishing 2) then (assert(profiled-user furnishing full)))
		    (if(= ?furnishing 3) then (assert(profiled-user furnishing none)))

              
	     (if (yes-or-no "Is a good view from your house very important (yes/no) ?" ) 
		then (assert(profiled-user goodView TRUE))
		else (assert(profiled-user goodView FALSE))
	      )
	     (if (yes-or-no "Do you like to swim (yes/no) ?" ) 
		then (assert(profiled-user swim TRUE))
		else (assert(profiled-user swim FALSE))
	     )
    else
         (assert(profiled-user temperatureControl FALSE))
         (assert(profiled-user goodView FALSE))
         (assert(profiled-user swim FALSE))
         (assert(profiled-user furnishing none))
  )
     (assert(profiled-user advanced done))
)
  

; finish filters
(defrule finished-AdvancedProfiling "Rule to check if all advancedProfiling is complete"
  ?profiler <- (profiler (user_profile ?user)(currentState "ADVANCEDPROFILING"))
  (profiled-user university ?)
  (profiled-user married ?)
  (profiled-user advanced ?)
 =>
  ;;(printout t "--------------------finishedAdvancedProfiling-------------------------------------------------" crlf)

  (modify ?profiler(currentState "FINISHED"))
)






;----------------------------------------------
; Module to Profile all the facts in the system
;----------------------------------------------
(defmodule factProfiler "Module for Profiling the facts and filtering the Recommendations"
	(import MAIN ?ALL)
        (import createUserProfile ?ALL)
        (import kbsProfiler ?ALL)
	(import advancedProfiler ?ALL)
        (export ?ALL)

)

(defrule distance-filter "Filter the offers by distance"
   ?profiler <- (profiler (user_profile ?user)(currentState "FINISHED11"))
   ?recommendation <- (object (is-a Recommendation))
   ?service <- (object (is-a SERVICES))

   =>
(printout t "--------------------actualfactProfiler-------------------------------------------------" crlf)

 (printout t (send (send ?recommendation get-residential) print))
 (format t "residential offer-%s%n" (send (send ?recommendation get-residential)get-parkingSpace)) 
        (bind ?serviceName (send ?service get-typeOfTheService))
        (bind ?distance (calculate-distance (send (send ?recommendation get-residential) get-address) 
		(send ?service get-serviceLocation)))
	(format t "distance of %s,%d%n" ?serviceName ?distance)
)




; Filter the offers by budget
(defrule budget-filter "Filter the offers by budget"
   ?profiler <- (profiler (user_profile ?user)(currentState "FINISHED"))
   ?recommendation <- (object (is-a Recommendation))
   =>
;;	(printout t "--------------------budgetFilter-------------------------------------------------" crlf)
   
;   (format t "Dear %s,%d%n" (send ?user get-firstName) (send ?user get-maxBudget))

 ;   (do-for-all-instances 
  ;       ((?recommendation Recommendation))
		
	 (bind ?rent (send (send ?recommendation get-residential) get-rent) )
	 (bind ?budget ( send ?user get-maxBudget))

;	  (if (> 5 ( send ?user get-maxBudget))
         
	  (if (> (send (send ?recommendation get-residential) get-rent) (send ?user get-maxBudget))
	   	then

             (bind ?reco (send ?recommendation get-recommendationCharacteristics))
	    ; update the recommendation characteristic
	     (send ?recommendation put-recommendationCharacteristics (str-cat ?reco "RENT is HIGH. "))
	     (send ?recommendation put-recommendationCharacteristics "REJECTED")
;	         (send (send ?recommendation get-residential) put-recommendationCharacteristics 
;			(str-cat (send (send ?recommendation get-residential) get-recommendationCharacteristics) "Rent is HIGH."))

;        (printout t (send (send ?recommendation get-rental_offer) print))
	  
	      else
             (bind ?reco (send ?recommendation  get-recommendationCharacteristics))
 	      	     (send ?recommendation put-recommendationCharacteristics (str-cat ?reco "RENT within BUDGET. "))
		     (send ?recommendation put-recoScore (+ (send ?recommendation get-recoScore) 10))

		 ;; (printout t "SCORE FOR BUDGET --- " (send ?recommendation get-recoScore) crlf)
;   (send (send ?recommendation get-residential) put-recommendationCharacteristics 
;			(str-cat (send (send ?recommendation get-residential) get-recommendationCharacteristics) "Rent is in BUDGET."))

	  )
;   )
;   (assert(budgetFilter done));

)


(defrule distance-filterByUserProfile "Filter the offers based on User Profile"
   ?profiler <- (profiler (user_profile ?user)(currentState "FINISHED"))
   ?recommendation <- (object (is-a Recommendation))
   ?service <- (object (is-a SERVICES))
   (profiled-user age ?ageGroup)
   (profiled-user modeOfTransport ?transport)
   (profiled-user weekendActivity ?activity)
   (profiled-user watchLiveMatches ?watchLiveMatches)
   (profiled-user university ?university)
   (profiled-user shoppingMode ?shop)
   =>
;(printout t "--------------------factProfiler-------------------------------------------------" crlf)

  ; find the type of service
  (bind ?serviceType (send ?service get-typeOfTheService))
  ;;(printout t "serviceType " ?serviceType crlf)

  ; find the actual service
  (bind ?serviceName (send ?service get-nameOfTheService))
  ;;(printout t "serviceName " ?serviceName crlf)

  

  ; calculate the distance of the service
  (bind ?distance (calculate-distance (send (send ?recommendation get-residential) get-address) 
		(send ?service get-serviceLocation)))
;  (format t "distance of %s,%d%n" ?serviceName ?distance)

  ;find the NEARNESS distance of the service
  (bind ?nearness (compare-distance ?distance))
  ;;(printout t "nearness " ?nearness crlf)

  ;find the bonus for the NEARNESS
  (bind ?bonus (bonus-nearness ?nearness))
;;  (printout t "bonus " ?bonus crlf)


   ; profile the user to the service 
   (bind ?reco (send ?recommendation get-recommendationCharacteristics))
   ;;(printout t "SCORE FOR SERVICES --- " (send ?recommendation get-recoScore) crlf)
 
  ; service is a public transport and user uses public transport  (max +5)
  (and(=( str-compare ?serviceType "publicTransport")0 ) (= (str-compare ?transport "public") 0 )
  ;TODO add condition to check distance
  (send ?recommendation put-recommendationCharacteristics (str-cat ?reco ?serviceName " IS " ?nearness ". "))
  (send ?recommendation put-recoScore (+ (send ?recommendation get-recoScore) ?bonus))
  )

  

  ; the service is recreation and the person is young  (max +5)
  (and(=( str-compare ?serviceType "recreation")0 ) (= (str-compare ?ageGroup "young") 0 )
  ;TODO add condition to check distance
  (send ?recommendation put-recommendationCharacteristics (str-cat ?reco ?serviceName " IS " ?nearness ". "))
  (send ?recommendation put-recoScore (+ (send ?recommendation get-recoScore) ?bonus))
  )

  ; the service is health and the person is elderly  (max +5)
  (and(=( str-compare ?serviceType "health")0 ) (= (str-compare ?ageGroup "elderly") 0 )
  ;TODO add condition to check distance
  (send ?recommendation put-recommendationCharacteristics (str-cat ?reco ?serviceName " IS " ?nearness ". "))
  (send ?recommendation put-recoScore (+ (send ?recommendation get-recoScore) ?bonus))
  )
   
  ; the service is a green-area and the person is not young (middle-aged or elderly) (max +5)
  (and(=( str-compare ?serviceType "greenArea")0 ) (not(= (str-compare ?ageGroup "young") 0 ))
  ;;(printout t "the user should NOT BE YOUNG" ?ageGroup)
  (send ?recommendation put-recommendationCharacteristics (str-cat ?reco ?serviceName " IS " ?nearness ". "))
  (send ?recommendation put-recoScore (+ (send ?recommendation get-recoScore) ?bonus))
  )

  ;the service corresponds to the user's weekend activity  (max +20)
  (or(and(=( str-compare ?serviceName "restaurant")0 ) (= (str-compare ?activity "dine") 0 ))
     (and(=( str-compare ?serviceName "theatre")0 ) (= (str-compare ?activity "movie") 0 ))
     (and(=( str-compare ?serviceName "gym")0 ) (= (str-compare ?activity "sports") 0 ))  
     (and(=( str-compare ?serviceName "club")0 ) (= (str-compare ?activity "clubbing") 0 ))
   (send ?recommendation put-recommendationCharacteristics (str-cat ?reco ?serviceName " IS " ?nearness ". "))
   (send ?recommendation put-recoScore (+ (send ?recommendation get-recoScore) ?bonus))
  )

 ; the service is the school in which the person studies
  (or(and(=( str-compare ?serviceName "UPC")0 ) (= (str-compare ?university "UPC") 0 ))
     (and(=( str-compare ?serviceName "ESADE")0 ) (= (str-compare ?university "ESADE") 0 ))
     (and(=( str-compare ?serviceName "IESE")0 ) (= (str-compare ?university "IESE") 0 ))  
     (and(=( str-compare ?serviceName "UB")0 ) (= (str-compare ?university "UB") 0 ))
   (send ?recommendation put-recommendationCharacteristics (str-cat ?reco ?serviceName " IS " ?nearness ". "))
   (send ?recommendation put-recoScore (+ (send ?recommendation get-recoScore) ?bonus))
  )

  ; the service is a shop and is the mode of shopping the user prefers
;   (printout t " ---- " ?serviceName  ?shop "are equal ?" crlf)
;   (if(eq ?serviceName ?shop)
   (if(=( str-compare ?serviceName ?shop)0 )
    then
  ;(printout t " ---- " ?serviceName  ?shop "are equal")
   (send ?recommendation put-recommendationCharacteristics (str-cat ?reco ?serviceName " IS " ?nearness ". "))
   (send ?recommendation put-recoScore (+ (send ?recommendation get-recoScore) ?bonus))
   )
  

  ;the user is a fan of the AnyWhereTownClub ! (max +5)
  (and(=( str-compare ?serviceName "stadium")0 ) (not(= (str-compare ?watchLiveMatches "none") 0 ))
  ;TODO add condition to check distance
  (send ?recommendation put-recommendationCharacteristics (str-cat ?reco ?serviceName " IS " ?nearness ". "))
  (send ?recommendation put-recoScore (+ (send ?recommendation get-recoScore) ?bonus))
  )

 	
)



; Filter the offers by user activities
(defrule rentalOffer-filterByUserPreference "Filter the offers by user preferences"
   ?profiler <- (profiler (user_profile ?user)(currentState "FINISHED"))
   ?recommendation <- (object (is-a Recommendation))
   (profiled-user homeType ?type)
   (profiled-user rooms ?rooms)
   (profiled-user modeOfTransport ?transport)
   (profiled-user temperatureControl ?temperature)
   (profiled-user furnishing ?furnishing)
   (profiled-user goodView ?view)
   (profiled-user swim ?swim)
   =>

  ; the type of the residency
  (bind ?offerType (send (send ?recommendation get-residential) get-type) )
  ;;(printout t "offerType" ?offerType crlf)
  ;;(printout t "homeType" ?type crlf)
  ; the full flat is for rent or not
  (bind ?offerFullFlat (send (send ?recommendation get-residential) get-fullFlatForRent) )
  ;;(printout t "offerfullflat" ?offerFullFlat crlf)
  ; the number of rooms for rent
  (bind ?furnished (send (send ?recommendation get-residential) get-furnishing) )
  ;;(printout t "furnishing" ?furnished crlf)  
  ; the furnishing of the house
  (bind ?roomsForRent (send (send ?recommendation get-residential) get-roomsForRent) )
  ;;(printout t "roomsForRent" ?roomsForRent crlf)  
  ; the furnishing of the house
  (bind ?tempOffer (send (send ?recommendation get-residential) get-temperatureControl) )
  ;;(printout t "roomsForRent" ?tempOffer crlf)  
  ;the swimmingPool
  (bind ?pool (send (send ?recommendation get-residential) get-swimmingPool) )
  ;;(printout t "swimmingPool" ?pool crlf)  
  ;the view
  (bind ?offerView (send (send ?recommendation get-residential) get-view) )
  ;;(printout t "offerView" ?offerView crlf)
  (bind ?parking (send (send ?recommendation get-residential) get-parkingSpace) )  
  ;;(printout t "offerView" ?parking crlf)

   ; profile the user to the rental offer
  (bind ?reco (send ?recommendation get-recommendationUserPrefs))
 ; (printout t "recommendationUSERPREFS" ?reco crlf)

  ; the homeType is of the user's preference (max +5)
  (if(eq ?offerType ?type) 
  then
  ;;(printout t "the flat is of " ?type crlf)
  ;(send ?recommendation put-recommendationUserPrefs (str-cat ?reco " IS of " ?type ". "))
  (bind ?reco (str-cat ?reco " IS of " ?type ". "))
  (send ?recommendation put-recoScore (+ (send ?recommendation get-recoScore) 7))
  )


  ; has either 1 room for rent OR  >2 rooms for rent as per-user-prefernce (max +5)
  (or (and(eq ?rooms 2) ( >= ?roomsForRent 2 ))
      (and(eq ?rooms 1) ( = ?roomsForRent 1 ))
  ;;(printout t "Number for rooms on rent are equal to userPreference" crlf)
;  (send ?recommendation put-recommendationUserPrefs (str-cat ?reco "Has requested rooms. "))
  (bind ?reco (str-cat ?reco "Has requested rooms. "))
  (send ?recommendation put-recoScore (+ (send ?recommendation get-recoScore) 7))
  )

  ; the whole flat is on rent and the userPreference is that (max +5)
  (and(eq ?rooms 3) (= (str-compare ?offerFullFlat "TRUE") 0 )
  ;;(printout t "the full flat is for rent" crlf)
;  (send ?recommendation put-recommendationUserPrefs (str-cat ?reco " IS for full rent. "))
   (bind ?reco (str-cat ?reco "IS for full rent. "))
  (send ?recommendation put-recoScore (+ (send ?recommendation get-recoScore) 7))
  )


; the user has a car and the offer has parking space
  (and(= (str-compare ?transport "ownCar") 0 ) (= (str-compare ?parking "TRUE") 0 )
;  (printout t "HAS PARKING ..." crlf)
;  (send ?recommendation put-recommendationUserPrefs (str-cat ?reco " IS for full rent. "))
   (bind ?reco (str-cat ?reco "Has parking. "))
  (send ?recommendation put-recoScore (+ (send ?recommendation get-recoScore) 7))
  )

  ; furnishing
  (if(eq ?furnishing ?furnished)
  then
  ;;(printout t "has specified funrishing" crlf)
 ; (send ?recommendation put-recommendationUserPrefs (str-cat ?reco " IS " ?furnishing " furnished. "))
   (bind ?reco (str-cat ?reco "IS " ?furnishing " furnished. "))
  (send ?recommendation put-recoScore (+ (send ?recommendation get-recoScore) 5))
  ) 

  ;temperature control
  (if(eq ?tempOffer ?temperature)
  then
;  (send ?recommendation put-recommendationUserPrefs (str-cat ?reco " Has specified temp. control. "))
  (bind ?reco (str-cat ?reco "Has specified temp. control. "))
  (send ?recommendation put-recoScore (+ (send ?recommendation get-recoScore) 5))
  )

  ; there is a swimming pool and the user wants it
  (and(eq ?swim ?pool) (= (str-compare ?pool "TRUE") 0 )
  (bind ?reco (str-cat ?reco "Has SwimmingPool. "))
  (send ?recommendation put-recoScore (+ (send ?recommendation get-recoScore) 5))
  )

  ; there is a view and the user wants it
  (and(not(=(str-compare ?offerView "none")0)) (= (str-compare ?view "TRUE") 0 )
  (bind ?reco (str-cat ?reco "Has view of " ?offerView))
  (send ?recommendation put-recoScore (+ (send ?recommendation get-recoScore) 5))
  )

;    (printout t "at-endrecommendationUSERPREFS" ?reco crlf)
    (send ?recommendation put-recommendationUserPrefs ?reco)
)






; calculate recommendation Level
(defrule recommendLevel-filter "Rule to set the recommendation Levels"
  ?profiler <- (profiler (user_profile ?user)(currentState "FINISHED"))
   ?recommendation <- (object (is-a Recommendation))
 =>
         (bind ?recoScore (send ?recommendation get-recoScore))
         (bind ?recoLevel (send ?recommendation get-recommendationLevel))
     
         (if(> 15 ?recoScore)
         then  (send ?recommendation put-recommendationLevel "PARTIALLY_ADEQUATE")
         else
            (if (> 30 ?recoScore)
              then (send ?recommendation put-recommendationLevel "ADEQUATE")
            else
               (send ?recommendation put-recommendationLevel "VERY_RECOMMENDABLE")
 	    )
	)

)

; finish filters
(defrule completed-filter "Rule to check if all filters have been applied and set the recommendation Levels"
  ?profiler <- (profiler (user_profile ?user)(currentState "FINISHED"))
 =>
   (modify ?profiler(currentState "PRINTOFFERS"))
)



;---------------------------------------------
; Module for printing out the Recommendations
;---------------------------------------------
(defmodule output "Module for printing the Recommendations"
	(import MAIN ?ALL)
        (import createUserProfile ?ALL)
        (import kbsProfiler ?ALL)
        (import factProfiler ?ALL)
        (export ?ALL)
)


(defrule printall
	?profiler <- (profiler (user_profile ?user)(currentState "PRINTOFFERS"))
	?recommendation <- (object (is-a Recommendation))
	=>
	(printout t "--------------------in printall-------------------------------------------------" crlf)
  	(format t "Dear %s,%s%n" (send ?user get-firstName) (send ?user get-secondName))
	(printout t " THE KBS recommends " crlf crlf)
;	(do-for-all-instances 
;	    ((?recommendation Recommendation))
	  ; todo only for recommendations which are at right recommendation level

         
	    (printout t (send ?recommendation print))
;	)
;	(modify ?profiler (currentState "TERMINATE"))
;        (assert(doneIs TRUE))
;	(printout t "-------------------doneISTRUE-------------------------------------------------" crlf)
	;;(pop-focus)
)


; finish filters
(defrule completed-print "Rule to check that all have been printed "
  ?profiler <- (profiler (user_profile ?user)(currentState "FINISHED"))
 =>
   (modify ?profiler(currentState "TERMINATE"))
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
   ?profiler <- (profiler (user_profile ?user) (currentState "TERMINATE"))
   ;(doneIs TRUE)
	=>
  (printout t "---------------------------------------------------------------------" crlf)
  (printout t " Hope you liked our recommendations. Than you for using our KBS      " crlf)
  (printout t "---------------------------------------------------------------------" crlf)   
  (printout t crlf)  
  ;;(pop-focus)
)




