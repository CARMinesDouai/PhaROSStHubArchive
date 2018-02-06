"
I follow a wall. I move the robot body at a fixed speed parallel to the wall. I ensure the distance between the body and the wall is within the interval: 
[minAcceptableDistance maxAcceptableDistance] inclusive.
If the distanceToFollowedWall is greater than maxAcceptableDistance, I turn the body towards the wall at a fixed rotation speed.
If the distanceToFollowedWall is less than minAcceptableDistance, I turn the body away from the wall at a fixed rotation speed.
In all situations, the forward speed is the same. So, when adjusting the distance to the wall, the body moves following an arc.

I am an abstract class. Subclasses must define methods:
-distanceToFollowedWall
This distance is obtained from the world model obstacleDistances
-isFollowingLeftWall
Answers true to follow left wall
-turnAwayFromWallRotationSpeed
Answers the appropriate rotation speed to turn left or right depending on the followed wall.

    Instance Variables
	maxAcceptableDistance:		<Number> distance above which the body is turned towards the wall
	minAcceptableDistance:		<Number> distance below which the body is turned away from the wall.

"
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
