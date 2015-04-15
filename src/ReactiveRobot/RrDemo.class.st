Class {
	#name : #RrDemo,
	#superclass : #Object,
	#category : #'ReactiveRobot-Demo'
}

{ #category : #demo }
RrDemo class >> collisionAvoider [
	^self demo: RrCollisionAvoiderController
]

{ #category : #demo }
RrDemo class >> demo: aControllerClass [
	| controller |
	controller := aControllerClass new.
	controller robot: RrRobulabBody kompai2.
	controller start.
	^controller
]

{ #category : #demo }
RrDemo class >> emergencyStop [
	^self demo:  RrEmergencyStopController
]
