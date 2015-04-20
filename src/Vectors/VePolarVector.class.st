"
A VePolarVector is a polar representation of a 2D vector.

Instance Variables
	angle:		<VeAngle>
	length:		<Number>

angle
	- angle with the X axis

length
	- distance to the point 0@0

"
Class {
	#name : #VePolarVector,
	#superclass : #VeVector,
	#instVars : [
		'length',
		'angle'
	],
	#category : #Vectors
}

{ #category : #accessing }
VePolarVector >> angle [
	^ angle
]

{ #category : #converting }
VePolarVector >> asCartesianVector [
	^ VeVector x: self x y: self y
]

{ #category : #accessing }
VePolarVector >> length [
	^ length
]

{ #category : #'initialize-release' }
VePolarVector >> length: newLength angle: newAngle [
	length := newLength.
	angle := newAngle
]

{ #category : #printing }
VePolarVector >> printOn: aStream [
	aStream
		nextPutAll: '[length = ';
		print: self length;
		nextPutAll: ', angle = ';
		print: self angle;
		nextPut: $]
		  
]

{ #category : #accessing }
VePolarVector >> x [
	^ self length * self angle cos
]

{ #category : #accessing }
VePolarVector >> y [
	^ self length * self angle sin
]
