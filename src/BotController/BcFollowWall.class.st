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
BcFollowWall >> distanceToFollowedWall [
	^self subclassResponsibility
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

{ #category : #accessing }
BcFollowWall >> negativeWallFollowingRotationSpeed [
	^self positiveWallFollowingRotationSpeed negated
]

{ #category : #accessing }
BcFollowWall >> obstacleDistances [
	^self controller obstacleDistances
]

{ #category : #accessing }
BcFollowWall >> positiveWallFollowingRotationSpeed [
	^0.3
]

{ #category : #stepping }
BcFollowWall >> step [
	self updateVelocity.
	super step.
	
]

{ #category : #stepping }
BcFollowWall >> turnAwayFromWallRotationSpeed [
	self subclassResponsibility
]

{ #category : #stepping }
BcFollowWall >> turnTowardsWallRotationSpeed [
	self subclassResponsibility
]

{ #category : #stepping }
BcFollowWall >> updateVelocity [
	self distanceToFollowedWall < self minAcceptableDistance ifTrue: [ ^self rotationSpeed: self turnAwayFromWallRotationSpeed].
	self distanceToFollowedWall > self maxAcceptableDistance ifTrue: [ ^self rotationSpeed: self turnTowardsWallRotationSpeed ].
	self rotationSpeed: 0
]
