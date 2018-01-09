Class {
	#name : #BcFollowWall,
	#superclass : #BcMoveAtFixedSpeed,
	#instVars : [
		'minAcceptableDistance',
		'maxAcceptableDistance'
	],
	#category : #'BotController-Actions'
}

{ #category : #accessing }
BcFollowWall >> distanceToFrontWall [
	^self controller obstacleDistances frontLeft
]

{ #category : #accessing }
BcFollowWall >> distanceToSideWall [
	^self controller obstacleDistances sideLeftFront 
]

{ #category : #initialization }
BcFollowWall >> initialize [
	super initialize.
	self minAcceptableDistance: 0.2.
	self maxAcceptableDistance: 0.4.
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
	self distanceToSideWall < self minAcceptableDistance ifTrue: [ ^self rotationSpeed: -0.2 ].
	self distanceToSideWall > self maxAcceptableDistance ifTrue: [ ^self rotationSpeed: 0.2 ].
	self rotationSpeed: 0
]
