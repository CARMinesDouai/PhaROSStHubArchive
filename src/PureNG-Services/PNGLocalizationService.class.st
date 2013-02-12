"
This service provides 2D localization data. The localization provided usually refers to the origin of the robot frame. This is the middle of the wheels axis for a differential robot, or the middle of rear axle for a car robot.
"
Class {
	#name : #PNGLocalizationService,
	#superclass : #PNGNotifyingService,
	#category : #'PureNG-Services'
}

{ #category : #constants }
PNGLocalizationService class >> notificationClass [
	^PNGLocalizationNotification 
]

{ #category : #constants }
PNGLocalizationService class >> serviceType [ 
	^ 16r8002
]

{ #category : #public }
PNGLocalizationService >> currentPosition [
	^self get
]

{ #category : #actions }
PNGLocalizationService >> decodeGetResponseFrom: decoder [
	^self decodePositionFromDecoder:  decoder
	
]

{ #category : #actions }
PNGLocalizationService >> decodePositionFromDecoder: decoder [

	| position |
	position := PNGRobotPosition new.
	position x:  decoder nextEncodedFloat64.
	position y:  decoder nextEncodedFloat64.
	position orientation:  decoder nextEncodedFloat64.
	position status: decoder nextEncodedUint32.
	^position
]

{ #category : #actions }
PNGLocalizationService >> getCommandString [ 

	^ '01000500'
]
