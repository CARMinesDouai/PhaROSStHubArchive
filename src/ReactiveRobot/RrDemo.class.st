Class {
	#name : #RrDemo,
	#superclass : #Object,
	#category : #'ReactiveRobot-Kernel'
}

{ #category : #demo }
RrDemo class >> collisionAvoider [
	^self demo: RrCollisionAvoiderController0
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

{ #category : #demo }
RrDemo class >> showObstacleSensors [
	| controller viewer |
	controller := self demo: RrController.
	viewer := RrRobulabObstacleSensorsViewerDecorator on: controller.
	UIManager default alert: 'Click to stop'.
	controller stop; shutdown. 
	viewer stop.
]
