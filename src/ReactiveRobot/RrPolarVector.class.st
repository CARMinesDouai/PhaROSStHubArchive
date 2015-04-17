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
	length := newLength.
	newAngle abs > Float pi ifFalse: [ ^angle := newAngle  ].
	newAngle < 0 
		ifTrue: [^ angle := 2 * Float pi + newAngle ].
	angle := newAngle - 2 * Float pi
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
