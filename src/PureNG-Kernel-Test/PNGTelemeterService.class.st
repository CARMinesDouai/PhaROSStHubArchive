"
This service exposes an array of telemeters. A telemeter is a sensor that measures a distance. Typically, ultrasonic sensors, or infrared sensors are available through this service.
"
Class {
	#name : #PNGTelemeterService,
	#superclass : #PNGService,
	#category : #'PureNG-Kernel'
}

{ #category : #constants }
PNGTelemeterService class >> serviceType [ 
	^ 16r4008
]
