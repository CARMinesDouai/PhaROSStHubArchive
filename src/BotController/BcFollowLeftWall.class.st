Class {
	#name : #BcFollowLeftWall,
	#superclass : #BcFollowWall,
	#category : #'BotController-Actions'
}

{ #category : #accessing }
BcFollowLeftWall >> distanceToFollowedWall [
	^self obstacleDistances left
]

{ #category : #stepping }
BcFollowLeftWall >> turnAwayFromWallRotationSpeed [
	^self negativeWallFollowingRotationSpeed
]

{ #category : #stepping }
BcFollowLeftWall >> turnTowardsWallRotationSpeed [
	^self positiveWallFollowingRotationSpeed
]
