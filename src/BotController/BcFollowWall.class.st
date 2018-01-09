Class {
	#name : #BcFollowWall,
	#superclass : #BcMoveAtFixedSpeed,
	#instVars : [
		'minAcceptableDistance',
		'maxAcceptableDistance'
	],
	#category : #'BotController-Actions'
}

{ #category : #stepping }
BcFollowWall >> distanceToWall [
	^self controller obstacleDistances sideLeftFront 
]

{ #category : #accessing }
BcFollowWall >> maxAcceptableDistance [
	^ maxAcceptableDistance
]

{ #category : #accessing }
BcFollowWall >> maxAcceptableDistance: anObject [
	maxAcceptableDistance := anObject
]

{ #category : #accessing }
BcFollowWall >> minAcceptableDistance [
	^ minAcceptableDistance
]

{ #category : #accessing }
BcFollowWall >> minAcceptableDistance: anObject [
	minAcceptableDistance := anObject
]

{ #category : #stepping }
BcFollowWall >> step [
	self updateVelocity.
	super step.
	
]

{ #category : #stepping }
BcFollowWall >> updateVelocity [
	self distanceToWall < self minAcceptableDistance ifTrue: [ ^self rotationSpeed: 0.1 ].
	self distanceToWall > self maxAcceptableDistance ifTrue: [ ^self rotationSpeed: -0.1 ].
	self rotationSpeed: 0
]
