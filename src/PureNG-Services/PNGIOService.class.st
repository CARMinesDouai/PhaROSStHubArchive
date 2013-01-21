"
This service gives access to digital and analog inputs and outputs. The values exposed by this service might as well corresponds to physical I/O or internal values of the PURE controller. The meaning of the values is detailed in the robot documentation.
"
Class {
	#name : #PNGIOService,
	#superclass : #PNGNotifyingService,
	#category : #'PureNG-Services'
}

{ #category : #constants }
PNGIOService class >> serviceType [ 
	^ 16r4001
]
