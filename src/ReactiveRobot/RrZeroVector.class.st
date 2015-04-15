Class {
	#name : #RrZeroVector,
	#superclass : #RrVector,
	#classInstVars : [
		'defaultInstance'
	],
	#category : #'ReactiveRobot-Vectors'
}

{ #category : #'instance creation' }
RrZeroVector class >> defaultInstance [
	^defaultInstance ifNil: [ defaultInstance := super new ]
]

{ #category : #arithmetics }
RrZeroVector >> + aVector [
	^aVector
]

{ #category : #accessing }
RrZeroVector >> angle [
	^0
]

{ #category : #accessing }
RrZeroVector >> length [
	^0
]

{ #category : #accessing }
RrZeroVector >> x [
	^0
]

{ #category : #accessing }
RrZeroVector >> y [
	^0
]
