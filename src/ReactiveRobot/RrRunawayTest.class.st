Class {
	#name : #RrRunawayTest,
	#superclass : #RrFeelForceTest,
	#instVars : [
		'runaway'
	],
	#category : #'ReactiveRobot-CollisionAvoidance'
}

{ #category : #testing }
RrRunawayTest >> assertSpeed: initialSpeed obstacleForce: obstacleVector resultInto: resultingSpeed [
	<testParametersSelector: #initialSpeedObstacleVectorAndResultingSpeed>
	runaway speedVector: initialSpeed.
	runaway input: obstacleVector. 
	self assert: runaway dataOnOutputPort equals: resultingSpeed 
]

{ #category : #testing }
RrRunawayTest >> initialSpeedObstacleVectorAndResultingSpeed [
	^{
		{ RrVector zero. RrVector zero. RrVector zero}.
		{ RrVector length: 1. RrVector length: 1. RrVector angle: Float halfPi}.
		{ RrVector length: 1. RrVector length: 1 angle: Float halfPi. RrVector length: 1}.
		{ RrVector length: 1. RrVector length: 1 angle: Float halfPi negated. RrVector length: 1}.
		{ RrVector length: 1. RrVector length: 1 angle: Float pi/4. RrVector length:   0.2928932188134524 angle: Float pi/4 negated}.
		{ RrVector length: 0.1. RrVector length: 1 angle: Float pi/4. RrVector length:   0 angle: Float pi/4 negated}.
		{ RrVector length: 1. RrVector length: 1 angle: Float pi/4 negated. RrVector length: 0.2928932188134524 angle: Float pi/4}.
		{ RrVector length: 0.1. RrVector length: 1 angle: Float pi/4 negated. RrVector length: 0 angle: Float pi/4}.
	}
]

{ #category : #testing }
RrRunawayTest >> setUp [
	super setUp.
	runaway := RrRunaway new.
	integrator => runaway.
	runaway speedVector: (RrVector length: 1)
]
