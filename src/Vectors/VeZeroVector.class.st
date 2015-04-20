"
A VeZeroVector is a null 2D vector.

"
Class {
	#name : #VeZeroVector,
	#superclass : #VeVector,
	#classInstVars : [
		'defaultInstance'
	],
	#category : #Vectors
}

{ #category : #'instance creation' }
VeZeroVector class >> defaultInstance [
	^defaultInstance ifNil: [ defaultInstance := super new ]
]

{ #category : #arithmetics }
VeZeroVector >> + aVector [
	^aVector
]

{ #category : #accessing }
VeZeroVector >> angle [
	^0
]

{ #category : #accessing }
VeZeroVector >> length [
	^0
]

{ #category : #accessing }
VeZeroVector >> x [
	^0
]

{ #category : #accessing }
VeZeroVector >> y [
	^0
]
