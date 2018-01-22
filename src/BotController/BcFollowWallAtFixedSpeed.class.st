Class {
	#name : #BcFollowWallAtFixedSpeed,
	#superclass : #BcMoveAtFixedSpeed,
	#instVars : [
		'minAcceptableDistance',
		'maxAcceptableDistance'
	],
	#category : #'BotController-Actions'
}

{ #category : #accessing }
BcFollowWallAtFixedSpeed >> distanceToFollowedWall [
	^self subclassResponsibility
]

{ #category : #initialization }
BcFollowWallAtFixedSpeed >> initialize [
	super initialize.
	self minAcceptableDistance: 0.2.
	self maxAcceptableDistance: 0.4.
]

{ #category : #testing }
BcFollowWallAtFixedSpeed >> isFollowingLeftWall [
	^self subclassResponsibility
]

{ #category : #testing }
BcFollowWallAtFixedSpeed >> isFollowingRightWall [
	^self isFollowingLeftWall not
]

{ #category : #accessing }
BcFollowWallAtFixedSpeed >> maxAcceptableDistance [
	^ maxAcceptableDistance
]

{ #category : #accessing }
BcFollowWallAtFixedSpeed >> maxAcceptableDistance: anObject [
	maxAcceptableDistance := anObject
]

{ #category : #accessing }
BcFollowWallAtFixedSpeed >> minAcceptableDistance [
	^ minAcceptableDistance
]

{ #category : #accessing }
BcFollowWallAtFixedSpeed >> minAcceptableDistance: anObject [
	minAcceptableDistance := anObject
]

{ #category : #accessing }
BcFollowWallAtFixedSpeed >> negativeWallFollowingRotationSpeed [
	^self positiveWallFollowingRotationSpeed negated
]

{ #category : #accessing }
BcFollowWallAtFixedSpeed >> obstacleDistances [
	^self worldModel
]

{ #category : #stepping }
BcFollowWallAtFixedSpeed >> perform [
	self updateVelocity.
	super perform.
	
]

{ #category : #accessing }
BcFollowWallAtFixedSpeed >> positiveWallFollowingRotationSpeed [
	^0.3
]

{ #category : #stepping }
BcFollowWallAtFixedSpeed >> turnAwayFromWallRotationSpeed [
	self subclassResponsibility
]

{ #category : #stepping }
BcFollowWallAtFixedSpeed >> turnTowardsWallRotationSpeed [
	^self turnAwayFromWallRotationSpeed negated
]

{ #category : #stepping }
BcFollowWallAtFixedSpeed >> updateVelocity [
	self distanceToFollowedWall < self minAcceptableDistance ifTrue: [ ^self rotationSpeed: self turnAwayFromWallRotationSpeed].
	self distanceToFollowedWall > self maxAcceptableDistance ifTrue: [ ^self rotationSpeed: self turnTowardsWallRotationSpeed ].
	self rotationSpeed: 0
]
