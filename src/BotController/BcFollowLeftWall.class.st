Class {
	#name : #BcFollowLeftWall,
	#superclass : #BcFollowWall,
	#category : #'BotController-Actions'
}

{ #category : #accessing }
BcFollowLeftWall >> distanceToFollowedWall [
	^self obstacleDistances sideLeftFront
]

{ #category : #testing }
BcFollowLeftWall >> isFollowingLeftWall [
	^true
]

{ #category : #stepping }
BcFollowLeftWall >> turnAwayFromWallRotationSpeed [
	^self negativeWallFollowingRotationSpeed
]
