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
		'moveAction'
	],
	#category : #'BotController-Controllers'
}

{ #category : #initialization }
BcStopOnFrontObstacleController >> initStatesAndTransitions [
	| moveState |
	super initStatesAndTransitions.
	moveState := stateMachine newStateDoing: [ currentAction := moveAction ].
	stopAction transitionTo: moveState when: [ self isObstacleClose not ].
	moveState transitionTo: stopAction when: [ self isObstacleClose ]
]

{ #category : #living }
BcStopOnFrontObstacleController >> start [
	super start.
	self body startLaserScanner.
]
