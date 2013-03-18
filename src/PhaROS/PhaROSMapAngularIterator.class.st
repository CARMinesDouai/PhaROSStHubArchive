Class {
	#name : #PhaROSMapAngularIterator,
	#superclass : #Object,
	#instVars : [
		'circularAccessor',
		'zero',
		'currentPosition'
	],
	#category : #'PhaROS-MapMatcher'
}

{ #category : #'as yet unclassified' }
PhaROSMapAngularIterator class >> for: aMap withCenterIn: aPosition radius: aRadius [ 
	 | pointMapper accessor |
	
	pointMapper := PhaROSCircularPointMapper withCenterIn: aPosition andRadius: aRadius.
	accessor := PhaROSMapCircularAccessor for: aMap and: pointMapper.
	

	^ self new circularAccessor: accessor; zero: aMap zeroAngle; yourself.
]

{ #category : #'as yet unclassified' }
PhaROSMapAngularIterator >> atBeginning [
	^ currentPosition  < zero.
]

{ #category : #'as yet unclassified' }
PhaROSMapAngularIterator >> atEnd [
	^ currentPosition  > (zero + (Float pi * 2))
]

{ #category : #'as yet unclassified' }
PhaROSMapAngularIterator >> circularAccessor: anAccessor [
	circularAccessor := anAccessor
]

{ #category : #'as yet unclassified' }
PhaROSMapAngularIterator >> current [
	^ circularAccessor valueAt: currentPosition . 
]

{ #category : #'as yet unclassified' }
PhaROSMapAngularIterator >> next [
	currentPosition  := currentPosition  + 1 degreesToRadians.
	self assert: currentPosition  <= (zero + (Float pi * 2)).
	^ circularAccessor valueAt: currentPosition . 
]

{ #category : #'as yet unclassified' }
PhaROSMapAngularIterator >> previous [
	currentPosition  := currentPosition - 1 degreesToRadians.
	self assert: currentPosition  >=  zero.
	^ circularAccessor valueAt: currentPosition . 
]

{ #category : #'as yet unclassified' }
PhaROSMapAngularIterator >> reset [
	currentPosition := zero - 1 degreesToRadians.
]

{ #category : #'as yet unclassified' }
PhaROSMapAngularIterator >> useCurrentAsZero [
	zero := currentPosition.
]

{ #category : #'as yet unclassified' }
PhaROSMapAngularIterator >> zero: aZeroAngle [
	zero := aZeroAngle.
	self reset.
]
