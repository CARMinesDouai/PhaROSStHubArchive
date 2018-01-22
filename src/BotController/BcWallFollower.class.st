"
I am a wall follower based on a state machine. I follow either the left or the right wall. 

Following wall means moving parallel to the wall. The side distance to the wall is kept beween minAcceptableDistance and maxAcceptable distance. Theses values are parameters that can be changed using accessors.

I rely on the same state machine as my superclass. So, I stop if front obstacle is too close. I move if it is far enough. However, I provide a different moveAction to allow following walls. The moveAction object changes when I follow left or right wall.  

Switching from following the wall on one side to following the wall on the other side is performed using messages:
-followLeftWall
-followRightWall

Upon calling these messages, the moveActionClass is replaced by the appropriate action class (e.g. BcFollowLeftWallAtFixedSpeed). The moveAction object is replaced by an instance of the new class. Wall following parameters are preseved. See resetMoveAction method

    Instance Variables
	moveActionClass:		<BcFollowWallAtFixedSpeed class>

Example
""Create, set up, and start a controller to follow the right wall""
bot := BcWallFollower pureRobulab2.
bot minAcceptableDistance: 0.6.
bot maxAcceptableDistance: 0.7.
bot followRightWall.
bot start.

""Once done perform""
bot stop



"
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
