Class {
	#name : #BcFollowRightWall,
	#superclass : #BcFollowWall,
	#category : #'BotController-Actions'
}

{ #category : #accessing }
BcFollowRightWall >> distanceToFollowedWall [
	^self obstacleDistances right
]

{ #category : #stepping }
BcFollowRightWall >> turnAwayFromWallRotationSpeed [
	^self positiveWallFollowingRotationSpeed
]

{ #category : #stepping }
BcFollowRightWall >> turnTowardsWallRotationSpeed [
	^self negativeWallFollowingRotationSpeed
]
