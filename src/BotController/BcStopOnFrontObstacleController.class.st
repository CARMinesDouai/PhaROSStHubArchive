"
I am a controller with 2 states: move forward or stop.
Transition from one to the other is triggered if there is an obstacle too close to the front. Obstacles are sensed based on laser scanner.
I receive laser scans repeatly. Transitions are triggered by these scans.

Examples
-create and start :
bot := BcStopOnFrontObstacleController pureRobulab2.
bot start.

-once done, the threads for communicating with the actual robot body can be terminated by evaluating
bot stop


    Instance Variables
	minFrontObstacleDistance:		<Float> distance to the nearest obstactle on the front.

"
Class {
	#name : #BcStopOnFrontObstacleController,
	#superclass : #BcStateMachineController,
	#instVars : [
		'moveAction',
		'obstacleDistances',
		'stopDistance',
		'moveDistance'
	],
	#category : #'BotController-Controllers'
}

{ #category : #initialization }
BcStopOnFrontObstacleController >> defaultMoveDistance [
	^self defaultStopDistance + 0.05
]

{ #category : #initialization }
BcStopOnFrontObstacleController >> defaultStopDistance [
	^0.2
]

{ #category : #accessing }
BcStopOnFrontObstacleController >> forwardSpeed: newForwardSpeed [
	moveAction forwardSpeed: newForwardSpeed
]

{ #category : #accessing }
BcStopOnFrontObstacleController >> forwardSpeed: newForwardSpeed rotationSpeed: newRotationSpeed [
	moveAction forwardSpeed: newForwardSpeed rotationSpeed: newRotationSpeed
]

{ #category : #initialization }
BcStopOnFrontObstacleController >> initStatesAndTransitions [
	| moveState |
	super initStatesAndTransitions.
	moveState := stateMachine newStateDoing: [ currentAction := moveAction ].
	stopState transitionTo: moveState when: [ self shouldMove ].
	moveState transitionTo: stopState when: [ self shouldStop ]
]

{ #category : #initialization }
BcStopOnFrontObstacleController >> initialize [
	super initialize.
	moveAction := self newAction: self moveActionClass.
	self obstacleDistances: BcMinLaserObstacleDistances new.
	self stopDistance: self defaultStopDistance.
	self moveDistance: self defaultMoveDistance.
]

{ #category : #initialization }
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
	^ obstacleDistances
]

{ #category : #accessing }
BcStopOnFrontObstacleController >> obstacleDistances: anObject [
	obstacleDistances := anObject
]

{ #category : #accessing }
BcStopOnFrontObstacleController >> rotationSpeed: newRotationSpeed [
	moveAction rotationSpeed: newRotationSpeed
]

{ #category : #living }
BcStopOnFrontObstacleController >> sense [
	self obstacleDistances updateFromAllEchoes: body latestLaserScan
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
