"
This service executes step motion commands. A step motion is either a rotation or translation (but not both at the same time) relative to the current position.
"
Class {
	#name : #PNGStepService,
	#superclass : #PNGNotifyingService,
	#category : #'PureNG-Services'
}

{ #category : #constants }
PNGStepService class >> notificationClass [
	^PNGStepNotification
]

{ #category : #constants }
PNGStepService class >> serviceType [ 
	^ 16r8003
]

{ #category : #'as yet unclassified' }
PNGStepService >> decodeGetResponseFrom: decoder [
	^ self decodeStepPropertiesFromDecoder: decoder.
]

{ #category : #'as yet unclassified' }
PNGStepService >> decodeStepPropertiesFromDecoder: decoder [

	| step |
	
	step := PNGStepProperties new.
	step motionType:  decoder nextEncodedByte.
	step targetDistance: decoder nextEncodedFloat32.
	step traveledDistance: decoder nextEncodedFloat32.
	step status:  decoder nextEncodedByte.

	^step
]

{ #category : #'as yet unclassified' }
PNGStepService >> getCommandString [ 
	self error: ' Get is not implemented for this service '
]

{ #category : #'as yet unclassified' }
PNGStepService >> move: aDistance at: aMaximumSpeed as: aMotionType [
	| encoder |
	encoder := PNGEncoder new.
	encoder 
		nextPutNotificationId;
		encodeInt16: self id;
		encodeInt8: aMotionType;
		encodeFloat32: aDistance;
		encodeFloat32: aMaximumSpeed.
			 
	self robot sendNotification:   encoder contents.
]

{ #category : #'as yet unclassified' }
PNGStepService >> moveForward: aDistance at: aMaximumSpeed [
	^ self move: aDistance at: aMaximumSpeed as: PNGStepProperties translation.
	
	
]

{ #category : #'as yet unclassified' }
PNGStepService >> primitiveNotify: aNotification [
	^self robot sendAndWaitForResult: self getCommandString.
]

{ #category : #'as yet unclassified' }
PNGStepService >> rotate: aDistance at: aMaximumSpeed [
	^ self move: aDistance at: aMaximumSpeed as: PNGStepProperties rotation.
	
	
]

{ #category : #'as yet unclassified' }
PNGStepService >> stop [
	self move: 0.0 at: 0.0 as: PNGStepProperties stop.
]
