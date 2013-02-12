"
This service provides an access to the input of a trajectory following algorithm. The trajectory service manages a trajectory buffer. Each element of this buffer is a segment associated with a target speed. The trajectory following algorithm that uses the trajectory buffer is supposed to dequeue the segments as the robot moves.
The client can feed this trajectory buffer using the INSERT request, or the REPLACE request.

The trajectory following algorithm is also exepected to manage the speed with respect to the target specified on each segement.It is not guaranteed that the requested speed will be reached, but it is guaranteed that the actual speed will always be lower than the requested. This is useful when specifying a lower speed for cornering. The client doesn't have to account for the deceleration that must occur before. It can just specify at a given point the maximum speed allowable, and the trajectory following will reduce the speed to respect the constraint.
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

{ #category : #actions }
PNGTrajectoryService >> decodeGetResponseFrom: decoder [
	| state |
	state := PNGTrajectoryState new.
	^state 
		timestamp: decoder nextEncodedUInt64;
		status: decoder nextEncodedByte;
		distanceCovered: decoder nextEncodedFloat64;
		lateralError: decoder nextEncodedFloat64;
		orientationError: decoder nextEncodedFloat64;
		yourself 
]

{ #category : #actions }
PNGTrajectoryService >> getCommandString [
	^'01000B00'
]

{ #category : #public }
PNGTrajectoryService >> trajectoryState [
	^self get
]
