"
This service exposes a differential robot. A differential robot is controlled through a linear speed and an angular speed. The linear speed component is obtained by applying the same speed to the left and right wheels. The angular speed component is obtained by applying speeds with opposite signs on the left and right wheels.
"
Class {
	#name : #PNGDifferentialService,
	#superclass : #PNGNotifyingService,
	#instVars : [
		'linearSpeed',
		'angularSpeed',
		'linearAcceleration',
		'angularAcceleration',
		'wheelsDistance'
	],
	#category : #'PureNG-Services'
}

{ #category : #constants }
PNGDifferentialService class >> notificationClass [
	^ PNGDifferentialNotification.
]

{ #category : #constants }
PNGDifferentialService class >> serviceType [ 
	^ 16r4005
]

{ #category : #'as yet unclassified' }
PNGDifferentialService >> decodeGetResponseFrom: decoder [
	
	self decodeMovementLimitsFrom: decoder into: linearSpeed.
	self decodeMovementLimitsFrom: decoder into: angularSpeed.	
	self decodeMovementLimitsFrom: decoder into: linearAcceleration.	
	self decodeMovementLimitsFrom: decoder into: angularAcceleration.	
	
	wheelsDistance := decoder nextEncodedFloat32.
]

{ #category : #'as yet unclassified' }
PNGDifferentialService >> decodeMovementLimitsFrom: decoder into: aMovementLimitsHolder [

	
	aMovementLimitsHolder max: decoder nextEncodedFloat32.
	aMovementLimitsHolder min: decoder nextEncodedFloat32.
	
]

{ #category : #'as yet unclassified' }
PNGDifferentialService >> getCommandString [ 
	^'01000300'.
]

{ #category : #'as yet unclassified' }
PNGDifferentialService >> initialize [ 
	super initialize.
	linearSpeed := PNGInterval new.
	angularSpeed := PNGInterval new.
	linearAcceleration := PNGInterval new.
	angularAcceleration := PNGInterval new.
]

{ #category : #'as yet unclassified' }
PNGDifferentialService >> moveAt: aDifferentialVelocity [
	^ self  moveAt: aDifferentialVelocity linear and: aDifferentialVelocity angular.
]

{ #category : #'as yet unclassified' }
PNGDifferentialService >> moveAt: aLinearSpeed and: anAngularSpeed [ 
	| encoder |
	encoder := PNGEncoder new.
	encoder 
		nextPutNotificationId;
		encodeInt16: self id;
		encodeInt8: 1;
		encodeFloat32: aLinearSpeed;
		encodeFloat32: anAngularSpeed.
			 
	self robot sendNotification:   encoder contents.
]
