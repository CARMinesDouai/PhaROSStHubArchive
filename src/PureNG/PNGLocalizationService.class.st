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
PNGLocalizationService >> currentPose [
	^self get
]

{ #category : #public }
PNGLocalizationService >> currentPosition [
	^self currentPose asPoint
]

{ #category : #actions }
PNGLocalizationService >> decodeGetResponseFrom: decoder [
	^self decodePositionFromDecoder:  decoder
	
]

{ #category : #actions }
PNGLocalizationService >> decodePositionFromDecoder: decoder [

	| position |
	position := PNGRobotPose new.
	position x:  decoder nextEncodedFloat64.
	position y:  decoder nextEncodedFloat64.
	position orientation:  decoder nextEncodedFloat64.
	position status: decoder nextEncodedUInt32.
	^position
]

{ #category : #actions }
PNGLocalizationService >> getCommandString [ 

	^ '01000500'
]

{ #category : #public }
PNGLocalizationService >> pose: aPNGRobotPose [ 
	^ self x: aPNGRobotPose x y: aPNGRobotPose y orientation: aPNGRobotPose orientation.

]

{ #category : #public }
PNGLocalizationService >> resetPose [
	self x: 0 y: 0 orientation: 0
]

{ #category : #public }
PNGLocalizationService >> suggest: aPNGRobotPose [ 
	^ self suggestX: aPNGRobotPose x y: aPNGRobotPose y orientation: aPNGRobotPose orientation.

]

{ #category : #public }
PNGLocalizationService >> suggestX: newX y: newY orientation: newOrientation [
	| requestEncoder |
	requestEncoder := PNGEncoder new.
	requestEncoder  
		nextPutRequestId ;
		nextPutUpdateActionCode;
		encodeInt16: self id;
		encodeInt64: self robot timestamp;
		encodeFloat64: newX;
		encodeFloat64: newY;
		encodeFloat64: newOrientation.
	self robot sendAndWaitForResult: requestEncoder contents 
]

{ #category : #public }
PNGLocalizationService >> x: newX y: newY orientation: newOrientation [
	| requestEncoder |
	requestEncoder := PNGEncoder new.
	requestEncoder  
		nextPutRequestId ;
		nextPutReplaceActionCode;
		encodeInt16: self id;
		encodeInt64: self robot timestamp;
		encodeFloat64: newX;
		encodeFloat64: newY;
		encodeFloat64: newOrientation.
	self robot sendAndWaitForResult: requestEncoder contents 
]
