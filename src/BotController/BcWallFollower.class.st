Class {
	#name : #BcWallFollower,
	#superclass : #BcStopOnFrontObstacleController,
	#instVars : [
		'moveActionClass'
	],
	#category : #'BotController-Controllers'
}

{ #category : #initialization }
BcWallFollower >> followLeftWall [
	moveActionClass := BcFollowLeftWallAtFixedSpeed.
	self resetMoveAction
]

{ #category : #initialization }
BcWallFollower >> followRightWall [
	moveActionClass := BcFollowRightWallAtFixedSpeed.
	self resetMoveAction
]

{ #category : #testing }
BcWallFollower >> isFollowingLeftWall [
	^moveAction isFollowingLeftWall
]

{ #category : #testing }
BcWallFollower >> isFollowingRightWall [
	^moveAction isFollowingRightWall
]

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
	^moveActionClass ifNil: [ BcFollowLeftWallAtFixedSpeed ]
]

{ #category : #initialization }
BcWallFollower >> resetMoveAction [
	| oldMoveAction |
	oldMoveAction := moveAction.
	super resetMoveAction.
	oldMoveAction ifNil: [ ^self ].
	moveAction 
		forwardSpeed: oldMoveAction forwardSpeed;
		minAcceptableDistance: oldMoveAction minAcceptableDistance;
		maxAcceptableDistance: oldMoveAction maxAcceptableDistance. 
]
