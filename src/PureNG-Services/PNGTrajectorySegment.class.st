Class {
	#name : #PNGTrajectorySegment,
	#superclass : #Object,
	#instVars : [
		'origin',
		'destination',
		'speed'
	],
	#category : #'PureNG-Services'
}

{ #category : #'instance creation' }
PNGTrajectorySegment class >> from: origin to: destination speed: speed [
	^self new
		origin: origin;
		destination: destination;
		speed: speed;
		yourself
]

{ #category : #accessing }
PNGTrajectorySegment >> destination [
	^ destination
]

{ #category : #accessing }
PNGTrajectorySegment >> destination: anObject [
	destination := anObject
]

{ #category : #encoding }
PNGTrajectorySegment >> encodeInto: requestEncoder [
	requestEncoder
		encodeFloat64: self origin x;
		encodeFloat64: self origin y;
		encodeFloat64: self destination x;
		encodeFloat64: self destination y;
		encodeFloat64: self speed
]

{ #category : #accessing }
PNGTrajectorySegment >> origin [
	^ origin
]

{ #category : #accessing }
PNGTrajectorySegment >> origin: anObject [
	origin := anObject
]

{ #category : #accessing }
PNGTrajectorySegment >> speed [
	^ speed
]

{ #category : #accessing }
PNGTrajectorySegment >> speed: anObject [
	speed := anObject
]
