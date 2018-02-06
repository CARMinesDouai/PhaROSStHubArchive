"
I am the action of following the left wall at fixed speed
"
Class {
	#name : #BcFollowLeftWallAtFixedSpeed,
	#superclass : #BcFollowWallAtFixedSpeed,
	#category : #'BotController-Actions'
}

{ #category : #accessing }
BcFollowLeftWallAtFixedSpeed >> distanceToFollowedWall [
	^self obstacleDistances sideLeftFront
]

{ #category : #testing }
BcFollowLeftWallAtFixedSpeed >> isFollowingLeftWall [
	^true
]

{ #category : #stepping }
BcFollowLeftWallAtFixedSpeed >> turnAwayFromWallRotationSpeed [
	^self negativeWallFollowingRotationSpeed
]
