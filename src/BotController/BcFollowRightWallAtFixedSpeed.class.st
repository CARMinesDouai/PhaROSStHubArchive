Class {
	#name : #BcFollowRightWallAtFixedSpeed,
	#superclass : #BcFollowWallAtFixedSpeed,
	#category : #'BotController-Actions'
}

{ #category : #accessing }
BcFollowRightWallAtFixedSpeed >> distanceToFollowedWall [
	^self obstacleDistances sideRightFront
]

{ #category : #testing }
BcFollowRightWallAtFixedSpeed >> isFollowingLeftWall [
	^false
]

{ #category : #stepping }
BcFollowRightWallAtFixedSpeed >> turnAwayFromWallRotationSpeed [
	^self positiveWallFollowingRotationSpeed
]
