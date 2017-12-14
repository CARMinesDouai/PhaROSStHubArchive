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
		'minFrontObstacleDistance'
	],
	#category : #'BotController-Controllers'
}

{ #category : #initialization }
BcStopOnFrontObstacleController >> initStatesAndTransitions [
	| moveForwardState |
	super initStatesAndTransitions.
	moveForwardState := stateMachine newStateDoing: [self body velocityForward: 0.2  ].
	stopState transitionTo: moveForwardState when: [self isObstacleClose not]. 
	moveForwardState transitionTo: stopState when: [self isObstacleClose]. 

]

{ #category : #living }
BcStopOnFrontObstacleController >> isObstacleClose [
	^minFrontObstacleDistance < 0.15
]

{ #category : #living }
BcStopOnFrontObstacleController >> start [
	super start.
	self body onLaserScanDo: [ : echoes | self updateMinObstacleDistance: echoes ].
	self body startLaserScanner.
]

{ #category : #living }
BcStopOnFrontObstacleController >> stop [
	self body stopLaserScanner
]

{ #category : #living }
BcStopOnFrontObstacleController >> updateMinObstacleDistance: echoes [
	| frontEchoesDistances |
	frontEchoesDistances := SortedCollection new.
	"Front echoes are ones with angle about Float pi / 3"
	echoes do: [ : each | 
		each angle abs < 1 ifTrue: [ frontEchoesDistances add: each distance * each angle cos]].
	minFrontObstacleDistance := frontEchoesDistances first.
	stateMachine step.

]
