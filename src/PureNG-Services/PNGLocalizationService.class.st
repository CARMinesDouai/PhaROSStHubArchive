"
This service provides 2D localization data. The localization provided usually refers to the origin of the robot frame. This is the middle of the wheels axis for a differential robot, or the middle of rear axle for a car robot.
"
Class {
	#name : #PNGLocalizationService,
	#superclass : #PNGNotifyingService,
	#category : #'PureNG-Services'
}

{ #category : #constants }
PNGLocalizationService class >> serviceType [ 
	^ 16r8002
]

{ #category : #'as yet unclassified' }
PNGLocalizationService >> decodePositionFromResponse: encodedResponse [

	| position |
	
	position := PNGRobotPosition new.

	[encodedResponse hasData ] whileTrue: [
		position x:  encodedResponse decoder nextEncodedFloat64.
		position y:  encodedResponse decoder nextEncodedFloat64.
		position orientation:  encodedResponse decoder nextEncodedFloat64.
		position status: encodedResponse decoder nextEncodedUint32.
	].
	^position
]

{ #category : #'as yet unclassified' }
PNGLocalizationService >> get [ 
	"Answers a PNGRobotPosition"

	^ self decodePositionFromResponse: self primitiveGet
	
]

{ #category : #'as yet unclassified' }
PNGLocalizationService >> getCommandString [ 

	^ '01000500'
]
