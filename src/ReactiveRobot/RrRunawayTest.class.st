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
		{ RrVector length: 1. RrVector length: 1. RrVector angle: Float pi/10}.
		{ RrVector length: 1. RrVector length: 1 angle: Float halfPi. RrVector length: 1}.
		{ RrVector length: 1. RrVector length: 1 angle: Float pi/4. RrVector x: 0.5 y: -0.5}.
		{ RrVector length: 1. RrVector length: 1 angle: Float pi * 3/4. RrVector x: 1.5 y: -0.5}.
	}
]

{ #category : #testing }
RrRunawayTest >> setUp [
	super setUp.
	runaway := RrRunaway new.
	integrator => runaway.
	runaway speedVector: (RrVector length: 1)
]
