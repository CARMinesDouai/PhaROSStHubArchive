Class {
	#name : #BcStopOnFrontObstacleControllerOLD,
	#superclass : #BcStateMachineController,
	#instVars : [
		'minFrontObstacleDistance'
	],
	#category : #'BotController-Controllers'
}

{ #category : #initialization }
BcStopOnFrontObstacleControllerOLD >> initStatesAndTransitions [
	| moveState |
	super initStatesAndTransitions.
	moveState := stateMachine newStateDoing: [ self move ].
	stopAction transitionTo: moveState when: [ self isObstacleClose not ].
	moveState transitionTo: stopAction when: [ self isObstacleClose ]
]

{ #category : #living }
BcStopOnFrontObstacleControllerOLD >> isFrontEcho: anEcho [
	"Front echoes are ones with angle about Float pi / 3"
	^anEcho angle abs < 1
]

{ #category : #living }
BcStopOnFrontObstacleControllerOLD >> isObstacleClose [
	^minFrontObstacleDistance < 0.15
]

{ #category : #living }
BcStopOnFrontObstacleControllerOLD >> laserScan: echoes [
	minFrontObstacleDistance := 100.
	echoes do: [ :each | self updateObstacleDistanceFrom: each ].
	stateMachine step
]

{ #category : #initialization }
BcStopOnFrontObstacleControllerOLD >> move [
	^ self body velocityForward: 0.2
]

{ #category : #living }
BcStopOnFrontObstacleControllerOLD >> start [
	super start.
	self body onLaserScanDo: [ : echoes | 
		self laserScan: echoes.
		stateMachine step. ].
	self body startLaserScanner.
]

{ #category : #living }
BcStopOnFrontObstacleControllerOLD >> updateObstacleDistanceFrom: anEcho [
	| obstacleDistance |
	(self isFrontEcho: anEcho) ifFalse: [ ^self ].
	obstacleDistance := anEcho distance * anEcho angle cos.
	minFrontObstacleDistance := minFrontObstacleDistance min: obstacleDistance
]
