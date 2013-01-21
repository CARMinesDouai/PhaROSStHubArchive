"
This service executes step motion commands. A step motion is either a rotation or translation (but not both at the same time) relative to the current position.
"
Class {
	#name : #PNGStepService,
	#superclass : #PNGNotifyingService,
	#category : #'PureNG-Services'
}

{ #category : #constants }
PNGStepService class >> serviceType [ 
	^ 16r8003
]
