Class {
	#name : #RrPolarVector,
	#superclass : #RrVector,
	#instVars : [
		'length',
		'angle'
	],
	#category : #'ReactiveRobot-Vectors'
}

{ #category : #accessing }
RrPolarVector >> angle [
	^ angle
]

{ #category : #converting }
RrPolarVector >> asCartesianVector [
	^ RrVector x: self x y: self y
]

{ #category : #accessing }
RrPolarVector >> length [
	^ length
]

{ #category : #'initialize-release' }
RrPolarVector >> length: newLength angle: newAngle [
	newLength < 0 ifTrue: [
		^self 
			length: newLength negated 
			angle: newAngle + Float pi].
	length := newLength.
	angle := newAngle 
]

{ #category : #printing }
RrPolarVector >> printOn: aStream [
	aStream
		nextPutAll: '[length = ';
		print: self length;
		nextPutAll: ', angle = ';
		print: self angle;
		nextPut: $]
		  
]

{ #category : #accessing }
RrPolarVector >> x [
	^ self length * self angle cos
]

{ #category : #accessing }
RrPolarVector >> y [
	^ self length * self angle sin
]
