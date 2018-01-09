Class {
	#name : #BcWallFollower,
	#superclass : #BcStopOnFrontObstacleController,
	#category : #'BotController-Controllers'
}

{ #category : #accessing }
BcWallFollower >> maxAcceptableDistance [
	^moveAction maxAcceptableDistance
]

{ #category : #accessing }
BcWallFollower >> maxAcceptableDistance: distance [
	moveAction maxAcceptableDistance: distance
]

{ #category : #accessing }
BcWallFollower >> minAcceptableDistance [
	^moveAction minAcceptableDistance
]

{ #category : #accessing }
BcWallFollower >> minAcceptableDistance: distance [
	moveAction minAcceptableDistance: distance
]

{ #category : #initialization }
BcWallFollower >> moveActionClass [
	^BcFollowWall
]
