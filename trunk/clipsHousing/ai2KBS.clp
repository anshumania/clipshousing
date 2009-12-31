; Thu Dec 31 13:42:27 CET 2009
; 
;+ (version "3.4.1")
;+ (build "Build 537")


(defclass %3ACLIPS_TOP_LEVEL_SLOT_CLASS "Fake class to save top-level slot information"
	(is-a USER)
	(role abstract)
	(single-slot minBudget
		(type INTEGER)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot rent
		(type INTEGER)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot AI2project_Class20012
		(type STRING)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot AI2project_Class20018
;+		(comment "is the second floor of the duplex flat")
		(type STRING)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot floor
;+		(comment "The floor at which this apartment exists")
		(type INTEGER)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot firstName
		(type STRING)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot number
;+		(comment "Identifies the number on the street which this address is.")
		(type INTEGER)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot Housing_Class1
		(type STRING)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot shopAddress
		(type INSTANCE)
;+		(allowed-classes CITY_ADDRESS)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot petsAllowed
;+		(comment "are pets allowed?")
		(type SYMBOL)
		(allowed-values FALSE TRUE)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot AI2project_Class20025
		(type STRING)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot street
;+		(comment "Identifies the street in the City where this address is")
		(type STRING)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot nameOfTheService
;+		(comment "Identifier for the Service")
		(type STRING)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot roomsForRent
		(type INTEGER)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot serviceLocation
		(type INSTANCE)
;+		(allowed-classes CITY_ADDRESS)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot totalBedrooms
		(type INTEGER)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot Y_Coord
		(type FLOAT)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot temperatureControl
;+		(comment "The temperature control units present in this residency.")
		(type SYMBOL)
		(allowed-values FALSE TRUE)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot serviceAddress
;+		(comment "The location at which this service exists")
		(type STRING)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot Car_Box_m2
		(type INTEGER)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot stat
		(type STRING)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot sunshine
		(type STRING)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot m2
		(type INTEGER)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot parkingSpace
;+		(comment "Identifies whether a residency has a swimming pool or not")
		(type SYMBOL)
		(allowed-values FALSE TRUE)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot terrace
		(type SYMBOL)
		(allowed-values FALSE TRUE)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot restaurantType
		(type SYMBOL)
		(allowed-values indian chinese italian japanese fastFood)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot view
;+		(comment "Additional attribute of this residency ; the view that it provides")
		(type SYMBOL)
		(allowed-values city sea garden none)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot typeOfTheService
;+		(comment "This decribes what 'type' of the service it is.")
		(type SYMBOL)
		(allowed-values greenArea recreation school shops health publicTransport)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot minimumRent
;+		(comment "This is the rent which is set by the owner of a residency.  A Rental offer has this as the lower limit")
		(type INTEGER)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot Parking_Space
		(type INSTANCE)
;+		(allowed-classes)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot age
		(type STRING)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot Address
		(type STRING)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot recAddress
		(type INSTANCE)
;+		(allowed-classes CITY_ADDRESS)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot Adress
		(type INSTANCE)
;+		(allowed-classes CITY_ADDRESS)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot variant
		(type SYMBOL)
		(allowed-values duplex attic flat detached villa semi_detached penthouse)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot best_features
		(type STRING)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot residentialOffer
		(type INSTANCE)
;+		(allowed-classes RESIDENTIAL)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot address
;+		(comment "The address of a residency")
		(type INSTANCE)
;+		(allowed-classes CITY_ADDRESS)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot museumType
		(type SYMBOL)
		(allowed-values science historical art)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot NEIGBOURHOOD
		(type INSTANCE)
;+		(allowed-classes Coordinates)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot recommendationScore
		(type INTEGER)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot locCoordinates
;+		(comment "The co-ordinates for this location")
		(type INSTANCE)
;+		(allowed-classes Coordinates)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot secondName
		(type STRING)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot maxBudget
		(type INTEGER)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot sunlight
;+		(comment "Additional attribute about the sunlight recieved by this residency.")
		(type SYMBOL)
		(allowed-values all_day morning afternoon evening)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot stationLocation
		(type INSTANCE)
;+		(allowed-classes)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot locAttribute
;+		(comment "This slot helps determine the area's general attribute")
		(type SYMBOL)
		(allowed-values posh happening classy downtown moderate)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot floor2
;+		(comment "A duplex exists in two floors. This is the value of the second floor.")
		(type INTEGER)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot recommendationCharacteristics
;+		(comment "The criteria which have lead to the recommendation level")
		(type STRING)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot trainStationAddress
		(type INSTANCE)
;+		(allowed-classes CITY_ADDRESS)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot schoolAddress
		(type INSTANCE)
;+		(allowed-classes CITY_ADDRESS)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot Position
		(type INSTANCE)
;+		(allowed-classes)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot Terrace
		(type SYMBOL)
		(allowed-values FALSE TRUE)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot X_Coord
		(type FLOAT)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot Quality
		(type STRING)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot fullFlatForRent
		(type SYMBOL)
		(allowed-values FALSE TRUE)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot furnishing
;+		(comment "The state of furnishing of a residency")
		(type SYMBOL)
		(allowed-values semi full none)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot recomendationLevel
		(type SYMBOL)
		(allowed-values partially_adequate adequate very_recommendable)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot type
		(type SYMBOL)
		(allowed-values house apartment)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot swimmingPool
		(type SYMBOL)
		(allowed-values FALSE TRUE)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot area
;+		(comment "The area of the apartment in metre square")
		(type INTEGER)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot balcony
		(type SYMBOL)
		(allowed-values FALSE TRUE)
;+		(cardinality 1 1)
		(create-accessor read-write)))

(defclass RESIDENTIAL "Abstract Class to capture housing options available to the citizens of AnyWhereTown"
	(is-a USER)
	(role concrete)
	(single-slot variant
		(type SYMBOL)
		(allowed-values duplex attic flat detached villa semi_detached penthouse)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot rent
		(type INTEGER)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot swimmingPool
		(type SYMBOL)
		(allowed-values FALSE TRUE)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot area
;+		(comment "The area of the apartment in metre square")
		(type INTEGER)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot street
;+		(comment "Identifies the street in the City where this address is")
		(type STRING)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot fullFlatForRent
		(type SYMBOL)
		(allowed-values FALSE TRUE)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot parkingSpace
;+		(comment "Identifies whether a residency has a swimming pool or not")
		(type SYMBOL)
		(allowed-values FALSE TRUE)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot address
;+		(comment "The address of a residency")
		(type INSTANCE)
;+		(allowed-classes CITY_ADDRESS)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot roomsForRent
		(type INTEGER)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot sunlight
;+		(comment "Additional attribute about the sunlight recieved by this residency.")
		(type SYMBOL)
		(allowed-values all_day morning afternoon evening)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot number
;+		(comment "Identifies the number on the street which this address is.")
		(type INTEGER)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot furnishing
;+		(comment "The state of furnishing of a residency")
		(type SYMBOL)
		(allowed-values semi full none)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot type
		(type SYMBOL)
		(allowed-values house apartment)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot recomendationLevel
		(type SYMBOL)
		(allowed-values partially_adequate adequate very_recommendable)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot view
;+		(comment "Additional attribute of this residency ; the view that it provides")
		(type SYMBOL)
		(allowed-values city sea garden none)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot totalBedrooms
		(type INTEGER)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot temperatureControl
;+		(comment "The temperature control units present in this residency.")
		(type SYMBOL)
		(allowed-values FALSE TRUE)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot locAttribute
;+		(comment "This slot helps determine the area's general attribute")
		(type SYMBOL)
		(allowed-values posh happening classy downtown moderate)
;+		(cardinality 1 1)
		(create-accessor read-write)))

(defclass Coordinates "The 2 dimensional co-ordinates for any Location in the city AnyWhereTown"
	(is-a USER)
	(role concrete)
	(single-slot X_Coord
		(type FLOAT)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot Y_Coord
		(type FLOAT)
;+		(cardinality 1 1)
		(create-accessor read-write)))

(defclass SERVICES
	(is-a USER)
	(role concrete)
	(single-slot serviceLocation
		(type INSTANCE)
;+		(allowed-classes CITY_ADDRESS)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot typeOfTheService
;+		(comment "This decribes what 'type' of the service it is.")
		(type SYMBOL)
		(allowed-values greenArea recreation school shops health publicTransport)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot nameOfTheService
;+		(comment "Identifier for the Service")
		(type STRING)
;+		(cardinality 1 1)
		(create-accessor read-write)))

(defclass USER_PROFILE "This represents a profile of a particular user"
	(is-a USER)
	(role concrete)
	(single-slot minBudget
		(type INTEGER)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot secondName
		(type STRING)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot maxBudget
		(type INTEGER)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot firstName
		(type STRING)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot age
		(type STRING)
;+		(cardinality 0 1)
		(create-accessor read-write)))

(defclass CITY_ADDRESS "An address within the City AnyWhereTown specified by the number on a particular street"
	(is-a USER)
	(role concrete)
	(single-slot locCoordinates
;+		(comment "The co-ordinates for this location")
		(type INSTANCE)
;+		(allowed-classes Coordinates)
;+		(cardinality 1 1)
		(create-accessor read-write)))

(defclass RENTAL_OFFER
	(is-a USER)
	(role concrete)
	(single-slot recommendationCharacteristics
;+		(comment "The criteria which have lead to the recommendation level")
		(type STRING)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot rent
		(type INTEGER)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot recomendationLevel
		(type SYMBOL)
		(allowed-values partially_adequate adequate very_recommendable)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot residentialOffer
		(type INSTANCE)
;+		(allowed-classes RESIDENTIAL)
;+		(cardinality 1 1)
		(create-accessor read-write)))(definstances ai2KBSinstances
; Thu Dec 31 13:42:27 CET 2009
; 
;+ (version "3.4.1")
;+ (build "Build 537")

([AIProject2pprj_Class4] of  CITY_ADDRESS

	(locCoordinates [AIProject2pprj_Class5]))

([AIProject2pprj_Class5] of  Coordinates

	(X_Coord 1125.0)
	(Y_Coord 1300.0))

([AIProject2pprj_Class8] of  Coordinates

	(X_Coord 1000.0)
	(Y_Coord 1000.0))

([Housing_Class0] of  SERVICES

	(nameOfTheService "park de guel")
	(serviceLocation [Housing_Class40004])
	(typeOfTheService greenArea))

([Housing_Class10000] of  Coordinates

	(X_Coord 2450.0)
	(Y_Coord 9000.0))

([Housing_Class10001] of  CITY_ADDRESS

	(locCoordinates [AIProject2pprj_Class8]))

([Housing_Class10002] of  CITY_ADDRESS

	(locCoordinates [Housing_Class10003]))

([Housing_Class10003] of  Coordinates

	(X_Coord 1500.0)
	(Y_Coord 1000.0))

([Housing_Class2] of  RESIDENTIAL

	(address [Housing_Class10001])
	(area 100)
	(fullFlatForRent TRUE)
	(furnishing semi)
	(locAttribute posh)
	(number 13)
	(parkingSpace TRUE)
	(rent 1200)
	(roomsForRent 5)
	(street "newyork street")
	(swimmingPool TRUE)
	(temperatureControl TRUE)
	(totalBedrooms 5)
	(type apartment)
	(variant attic)
	(view none))

([Housing_Class20000] of  RESIDENTIAL

	(address [Housing_Class30001])
	(area 50)
	(fullFlatForRent TRUE)
	(furnishing none)
	(locAttribute happening)
	(number 23)
	(parkingSpace FALSE)
	(rent 500)
	(roomsForRent 1)
	(street "rome street")
	(sunlight afternoon)
	(swimmingPool FALSE)
	(temperatureControl FALSE)
	(totalBedrooms 1)
	(type apartment)
	(variant flat))

([Housing_Class20001] of  SERVICES

	(nameOfTheService "UPC")
	(serviceLocation [Housing_Class20002])
	(typeOfTheService school))

([Housing_Class20002] of  CITY_ADDRESS

	(locCoordinates [Housing_Class10000]))

([Housing_Class20003] of  CITY_ADDRESS

	(locCoordinates [Housing_Class20004]))

([Housing_Class20004] of  Coordinates

	(X_Coord 2000.0)
	(Y_Coord 9400.0))

([Housing_Class20005] of  SERVICES

	(nameOfTheService "metro")
	(serviceLocation [Housing_Class20003])
	(typeOfTheService publicTransport))

([Housing_Class3] of  SERVICES

	(nameOfTheService "bar new york 57")
	(serviceLocation [AIProject2pprj_Class4])
	(typeOfTheService recreation))

([Housing_Class30000] of  RESIDENTIAL

	(address [Housing_Class40001])
	(area 60)
	(fullFlatForRent TRUE)
	(furnishing semi)
	(locAttribute happening)
	(number 45)
	(parkingSpace FALSE)
	(rent 600)
	(roomsForRent 1)
	(street "london street")
	(sunlight all_day)
	(swimmingPool TRUE)
	(temperatureControl TRUE)
	(totalBedrooms 1)
	(type apartment)
	(variant flat))

([Housing_Class30001] of  CITY_ADDRESS

	(locCoordinates [Housing_Class30002]))

([Housing_Class30002] of  Coordinates

	(X_Coord 2000.0)
	(Y_Coord 9000.0))

([Housing_Class40000] of  SERVICES

	(nameOfTheService "stadium")
	(serviceLocation [Housing_Class50001])
	(typeOfTheService recreation))

([Housing_Class40001] of  CITY_ADDRESS

	(locCoordinates [Housing_Class40002]))

([Housing_Class40002] of  Coordinates

	(X_Coord 3000.0)
	(Y_Coord 8000.0))

([Housing_Class40004] of  CITY_ADDRESS

	(locCoordinates [Housing_Class40005]))

([Housing_Class40005] of  Coordinates

	(X_Coord 7500.0)
	(Y_Coord 4000.0))

([Housing_Class50001] of  CITY_ADDRESS

	(locCoordinates [Housing_Class50002]))

([Housing_Class50002] of  Coordinates

	(X_Coord 1500.0)
	(Y_Coord 6000.0))

([Housing_Class50003] of  SERVICES

	(nameOfTheService "supermarket")
	(serviceLocation [Housing_Class50004])
	(typeOfTheService shops))

([Housing_Class50004] of  CITY_ADDRESS

	(locCoordinates [Housing_Class50005]))

([Housing_Class50005] of  Coordinates

	(X_Coord 4000.0)
	(Y_Coord 4000.0))

([Housing_Class50006] of  SERVICES

	(nameOfTheService "club")
	(serviceLocation [Housing_Class50007])
	(typeOfTheService recreation))

([Housing_Class50007] of  CITY_ADDRESS

	(locCoordinates [Housing_Class50008]))

([Housing_Class50008] of  Coordinates

	(X_Coord 9000.0)
	(Y_Coord 9000.0))

([Housing_Class50009] of  SERVICES

	(nameOfTheService "zoo")
	(serviceLocation [Housing_Class50010])
	(typeOfTheService recreation))

([Housing_Class50010] of  CITY_ADDRESS

	(locCoordinates [Housing_Class50011]))

([Housing_Class50011] of  Coordinates

	(X_Coord 9000.0)
	(Y_Coord 6000.0))

([Housing_Class50012] of  SERVICES

	(nameOfTheService "theater")
	(serviceLocation [Housing_Class50015])
	(typeOfTheService recreation))

([Housing_Class50013] of  CITY_ADDRESS
)

([Housing_Class50014] of  CITY_ADDRESS
)

([Housing_Class50015] of  CITY_ADDRESS

	(locCoordinates [Housing_Class50016]))

([Housing_Class50016] of  Coordinates

	(X_Coord 8500.0)
	(Y_Coord 4000.0))

([Housing_Class50017] of  SERVICES

	(nameOfTheService "hospital")
	(serviceLocation [Housing_Class50018])
	(typeOfTheService health))

([Housing_Class50018] of  CITY_ADDRESS

	(locCoordinates [Housing_Class50019]))

([Housing_Class50019] of  Coordinates

	(X_Coord 8000.0)
	(Y_Coord 4500.0))

([Housing_Class50020] of  RESIDENTIAL

	(address [Housing_Class50021])
	(area 100)
	(fullFlatForRent TRUE)
	(furnishing full)
	(locAttribute downtown)
	(number 32)
	(parkingSpace TRUE)
	(rent 1000)
	(roomsForRent 2)
	(street "berlin street")
	(sunlight morning)
	(swimmingPool FALSE)
	(temperatureControl TRUE)
	(totalBedrooms 2)
	(type apartment)
	(variant flat)
	(view city))

([Housing_Class50021] of  CITY_ADDRESS

	(locCoordinates [Housing_Class50022]))

([Housing_Class50022] of  Coordinates

	(X_Coord 4500.0)
	(Y_Coord 4000.0))

([Housing_Class50023] of  RESIDENTIAL

	(address [Housing_Class50024])
	(area 160)
	(fullFlatForRent TRUE)
	(furnishing semi)
	(locAttribute posh)
	(number 45)
	(parkingSpace FALSE)
	(rent 2000)
	(roomsForRent 1)
	(street "florida street")
	(sunlight all_day)
	(swimmingPool TRUE)
	(temperatureControl TRUE)
	(totalBedrooms 1)
	(type house)
	(variant detached)
	(view city))

([Housing_Class50024] of  CITY_ADDRESS

	(locCoordinates [Housing_Class50025]))

([Housing_Class50025] of  Coordinates

	(X_Coord 8100.0)
	(Y_Coord 4100.0))

([Housing_Class50026] of  RESIDENTIAL

	(address [Housing_Class50027])
	(area 120)
	(fullFlatForRent TRUE)
	(furnishing full)
	(locAttribute posh)
	(number 45)
	(parkingSpace FALSE)
	(rent 2000)
	(roomsForRent 2)
	(street "barcelona street")
	(sunlight all_day)
	(swimmingPool TRUE)
	(temperatureControl TRUE)
	(totalBedrooms 2)
	(type apartment)
	(variant duplex))

([Housing_Class50027] of  CITY_ADDRESS

	(locCoordinates [Housing_Class50028]))

([Housing_Class50028] of  Coordinates

	(X_Coord 8800.0)
	(Y_Coord 8800.0))

([Housing_Class50029] of  RESIDENTIAL

	(address [Housing_Class50030])
	(area 150)
	(fullFlatForRent TRUE)
	(furnishing full)
	(locAttribute classy)
	(number 12)
	(parkingSpace TRUE)
	(rent 2500)
	(roomsForRent 1)
	(street "manchester street")
	(sunlight morning)
	(swimmingPool TRUE)
	(temperatureControl TRUE)
	(totalBedrooms 1)
	(type house)
	(variant semi_detached))

([Housing_Class50030] of  CITY_ADDRESS

	(locCoordinates [Housing_Class50031]))

([Housing_Class50031] of  Coordinates

	(X_Coord 1350.0)
	(Y_Coord 5800.0))

([Housing_Class50032] of  RESIDENTIAL

	(address [Housing_Class50033])
	(area 80)
	(fullFlatForRent TRUE)
	(furnishing semi)
	(locAttribute posh)
	(number 45)
	(parkingSpace FALSE)
	(rent 1500)
	(roomsForRent 1)
	(street "capetown street")
	(sunlight afternoon)
	(swimmingPool TRUE)
	(temperatureControl TRUE)
	(totalBedrooms 1)
	(type apartment)
	(variant flat))

([Housing_Class50033] of  CITY_ADDRESS

	(locCoordinates [Housing_Class50034]))

([Housing_Class50034] of  Coordinates

	(X_Coord 8800.0)
	(Y_Coord 6250.0))
) 
