; Mon Dec 28 23:44:38 CET 2009
; 
;+ (version "3.4.1")
;+ (build "Build 537")

(definstances ai2instances

([AI2project_Class20004] of  ATTIC

	(address [AI2project_Class30015])
	(area 120)
	(minimumRent 1200)
	(numberOfBedrooms 3)
	(parkingSpace TRUE)
	(sunlight all_day)
	(swimmingPool TRUE)
	(temperatureControl both)
	(terrace TRUE)
	(view sea))

([AI2project_Class30005] of  CITY_ADDRESS

	(locAttribute classy)
	(locCoordinates [AI2project_Class30008])
	(number 2)
	(street "diagonal"))

([AI2project_Class30008] of  Coordinates

	(X_Coord 20.0)
	(Y_Coord 30.0))

([AI2project_Class30010] of  FLAT

	(address [AI2project_Class30005])
	(area 100)
	(balcony TRUE)
	(floor 2)
	(furnishing semi)
	(minimumRent 1000)
	(numberOfBedrooms 2)
	(parkingSpace TRUE)
	(petsAllowed FALSE)
	(sunlight all_day)
	(swimmingPool FALSE)
	(temperatureControl air_conditioning)
	(view city))

([AI2project_Class30012] of  FLAT

	(address [AI2project_Class30013])
	(area 60)
	(balcony TRUE)
	(floor 2)
	(minimumRent 800)
	(numberOfBedrooms 1)
	(parkingSpace TRUE)
	(petsAllowed TRUE)
	(swimmingPool FALSE)
	(temperatureControl heating)
	(view sea))

([AI2project_Class30013] of  CITY_ADDRESS

	(locAttribute downtown)
	(locCoordinates [AI2project_Class30014])
	(number 3)
	(street "badal"))

([AI2project_Class30014] of  Coordinates

	(X_Coord 40.0)
	(Y_Coord 20.0))

([AI2project_Class30015] of  CITY_ADDRESS

	(locAttribute happening)
	(locCoordinates [AI2project_Class30016])
	(number 1)
	(street "rambla catalunya"))

([AI2project_Class30016] of  Coordinates

	(X_Coord 50.0)
	(Y_Coord 50.0))

([AI2project_Class30017] of  RENTAL_OFFER

	(rent 1200)
	(residentialOffer [AI2project_Class30012]))

([AI2project_Class30018] of  RENTAL_OFFER

	(rent 1200)
	(residentialOffer [AI2project_Class20004]))
)