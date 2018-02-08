"
I am a state machine-based controller with 2 states: move forward or stop.  

The state machine operates as following:
-The initial state is stopState. 
-When the distance to the nearest front obstacle is above the move threshold (message moveDistance), I switch to the moveState. The moveAction is then selected.
-When the distance to the nearest front obstacle is below the stop threshold (message stopDistance), I swich to stopState. the stopAction is then selected.

The distance to nearest front obstacle is provided by the world model.

I provide accessors to read and write the following parameters:
-forwardSpeed and rotationSpeed
Define the speed of the robot while in moveState
-stopDistance and moveDistance
Distances to trigger transitions to stopState and moveState

Examples
-create and start :
bot := BcStopOnFrontObstacleController pureRobulab2.
bot start.

-to stop the robot simply evaluate :
bot stop

    Instance Variables
	stopDistance  <Float>  When distance to a front obstactle is below this threshold, the stopState is activated
	moveDistance	<Float> When the distance to a front obstacle is above this threshold, the moveState is activated
	moveAction	<Object> defined by instantiating the class returned by message moveActionClass
	moveState	<SmState> selects the currentAction to moveAction

"
Class {
	#name : #BcStopOnFrontObstacleController,
	#superclass : #BcStateMachineController,
	#instVars : [
		'stopDistance',
		'moveDistance',
		'moveAction',
		'moveState'
	],
	#category : #'BotController-Controllers'
}

{ #category : #'initialize-release' }
BcStopOnFrontObstacleController >> defaultMoveDistance [
	^self defaultStopDistance + 0.05
]

{ #category : #'initialize-release' }
BcStopOnFrontObstacleController >> defaultStopDistance [
	^0.2
]

{ #category : #accessing }
BcStopOnFrontObstacleController >> forwardSpeed [
	^moveAction forwardSpeed
]

{ #category : #accessing }
BcStopOnFrontObstacleController >> forwardSpeed: newForwardSpeed [
	moveAction forwardSpeed: newForwardSpeed
]

{ #category : #accessing }
BcStopOnFrontObstacleController >> forwardSpeed: newForwardSpeed rotationSpeed: newRotationSpeed [
	moveAction forwardSpeed: newForwardSpeed rotationSpeed: newRotationSpeed
]

{ #category : #'initialize-release' }
BcStopOnFrontObstacleController >> initStatesAndTransitions [
	super initStatesAndTransitions.
	moveState := self newStateSelectingAction: [moveAction].
	stopState transitionTo: moveState when: [ self shouldMove ].
	moveState transitionTo: stopState when: [ self shouldStop ]
]

{ #category : #'initialize-release' }
BcStopOnFrontObstacleController >> initialize [
	super initialize.
	self resetMoveAction.
	self stopDistance: self defaultStopDistance.
	self moveDistance: self defaultMoveDistance
]

{ #category : #'initialize-release' }
BcStopOnFrontObstacleController >> moveActionClass [
	^ BcMoveAtFixedSpeed
]

{ #category : #accessing }
BcStopOnFrontObstacleController >> moveDistance [
	^moveDistance
]

{ #category : #accessing }
BcStopOnFrontObstacleController >> moveDistance: newMoveDistance [
	^moveDistance := newMoveDistance
]

{ #category : #accessing }
BcStopOnFrontObstacleController >> obstacleDistances [
	^ self worldModel
]

{ #category : #'initialize-release' }
BcStopOnFrontObstacleController >> resetMoveAction [
	moveAction := self newAction: self moveActionClass
]

{ #category : #accessing }
BcStopOnFrontObstacleController >> rotationSpeed [
	^moveAction rotationSpeed
]

{ #category : #accessing }
BcStopOnFrontObstacleController >> rotationSpeed: newRotationSpeed [
	moveAction rotationSpeed: newRotationSpeed
]

{ #category : #testing }
BcStopOnFrontObstacleController >> shouldMove [
	^self obstacleDistances front > self moveDistance
]

{ #category : #testing }
BcStopOnFrontObstacleController >> shouldStop [
	^self obstacleDistances front < self stopDistance
]

{ #category : #living }
BcStopOnFrontObstacleController >> start [
	super start.
	self body startLaserScanner.
]

{ #category : #accessing }
BcStopOnFrontObstacleController >> stopDistance [
	^stopDistance
]

{ #category : #accessing }
BcStopOnFrontObstacleController >> stopDistance: newStopDistance [
	^stopDistance := newStopDistance
]

{ #category : #'initialize-release' }
BcStopOnFrontObstacleController >> worldModelBuilderClass [
	^Bc2ZonesObstacleDistancesBuilderFromLaser270 
]
