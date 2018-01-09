Class {
	#name : #BcWallFollower,
	#superclass : #BcStopOnFrontObstacleController,
	#category : #'BotController-Controllers'
}

{ #category : #initialization }
BcWallFollower >> maxAcceptableDistance: distance [
	moveAction maxAcceptableDistance: distance
]

{ #category : #initialization }
BcWallFollower >> minAcceptableDistance: distance [
	moveAction minAcceptableDistance: distance
]

{ #category : #initialization }
BcWallFollower >> moveActionClass [
	^BcFollowWall
]
