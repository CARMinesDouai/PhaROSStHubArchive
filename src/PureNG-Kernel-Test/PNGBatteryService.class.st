"
This service exposes the robot battery state. It is useful for autonomous operation, where you need to know when batteries need charging.
"
Class {
	#name : #PNGBatteryService,
	#superclass : #PNGService,
	#category : #'PureNG-Kernel'
}

{ #category : #constants }
PNGBatteryService class >> serviceType [ 
	^ 16r400D
]
