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
		'obstacleDistances'
	],
	#category : #'BotController-Controllers'
}

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
	moveAction := self newAction: BcMoveAtFixedSpeed.
	obstacleDistances := BcMinLaserObstacleDistances new.

]

{ #category : #testing }
BcStopOnFrontObstacleController >> moveDistance [
	^0.30
]

{ #category : #living }
BcStopOnFrontObstacleController >> sense [
	obstacleDistances updateFromAllEchoes: body latestLaserScan
]

{ #category : #testing }
BcStopOnFrontObstacleController >> shouldMove [
	^obstacleDistances front > self moveDistance
]

{ #category : #testing }
BcStopOnFrontObstacleController >> shouldStop [
	^obstacleDistances front < self stopDistance
]

{ #category : #living }
BcStopOnFrontObstacleController >> start [
	super start.
	self body startLaserScanner.
]

{ #category : #testing }
BcStopOnFrontObstacleController >> stopDistance [
	^0.15
]
