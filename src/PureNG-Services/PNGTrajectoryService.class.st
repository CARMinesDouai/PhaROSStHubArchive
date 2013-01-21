"
This service provides an access to the input of a trajectory following algorithm.
"
Class {
	#name : #PNGTrajectoryService,
	#superclass : #PNGNotifyingService,
	#category : #'PureNG-Services'
}

{ #category : #constants }
PNGTrajectoryService class >> serviceType [ 
	^ 16r8001
]
