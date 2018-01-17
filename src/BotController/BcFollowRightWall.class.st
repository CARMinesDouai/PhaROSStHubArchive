Class {
	#name : #BcFollowRightWall,
	#superclass : #BcFollowWall,
	#category : #'BotController-Actions'
}

{ #category : #accessing }
BcFollowRightWall >> distanceToFollowedWall [
	^self obstacleDistances sideRightFront
]

{ #category : #testing }
BcFollowRightWall >> isFollowingLeftWall [
	^false
]

{ #category : #stepping }
BcFollowRightWall >> turnAwayFromWallRotationSpeed [
	^self positiveWallFollowingRotationSpeed
]
