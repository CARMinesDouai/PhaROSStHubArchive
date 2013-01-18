"
This service provides measurements from a laser range finder. A laser range finder is a sensor that measures an array distances at different angles, called a scan. A pair (angle, distance) is called an echo.
"
Class {
	#name : #PNGLaserService,
	#superclass : #PNGNotifyingService,
	#category : #'PureNG-Services'
}

{ #category : #constants }
PNGLaserService class >> serviceType [ 
	^ 16r4004
]
