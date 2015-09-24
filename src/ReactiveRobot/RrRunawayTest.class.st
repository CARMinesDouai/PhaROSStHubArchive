Class {
	#name : #RrRunawayTest,
	#superclass : #ParameterizedTestCase,
	#instVars : [
		'builder',
		'integrator',
		'runaway'
	],
	#category : #'ReactiveRobot-02-CollisionAvoidance'
}

{ #category : #testing }
RrRunawayTest >> assertObstacleForce: obstacleVector resultInto: resultingSpeed [
	<testParametersSelector: #obstacleVectorAndResultingSpeed>
	runaway speedVector: (VeVector length: 1).
	runaway input: obstacleVector. 
	self assert: runaway dataOnOutputPort equals: resultingSpeed 
]

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
		{ VeVector zero. VeVector zero. VeVector zero}.
		{ VeVector length: 1. VeVector length: 1. VeVector angle: VeAngle halfPi}.
		{ VeVector length: 1. VeVector length: 1 angle: VeAngle halfPi. VeVector length: 1}.
		{ VeVector length: 1 angle: VeAngle halfPi. VeVector length: 1. VeVector length: 1  angle: VeAngle halfPi}.
		{ VeVector length: 1. VeVector length: 1 angle: VeAngle halfPiNegated. VeVector length: 1}.
		{ VeVector length: 1 angle: VeAngle halfPiNegated. VeVector length: 1. VeVector length: 1  angle: VeAngle halfPiNegated}.
		{ VeVector length: 1. VeVector length: 1 angle: VeAngle pi/4. VeVector length: 0.2928932188134524 angle: VeAngle pi/4 negated}.
		{ VeVector length: 1 angle: VeAngle pi/4. VeVector length: 1 angle: VeAngle pi/4. VeVector angle: VeAngle pi / -4}.
		{ VeVector length: 0.1. VeVector length: 1 angle: VeAngle pi/4. VeVector length:   0.02928932188134524 angle: VeAngle pi/ -4}.
		{ VeVector length: 1. VeVector length: 1 angle: VeAngle pi/ -4. VeVector length: 0.2928932188134524 angle: VeAngle pi/4}.
		{ VeVector length: 0.1. VeVector length: 1 angle: VeAngle pi/ -4. VeVector length: 0.02928932188134524 angle: VeAngle pi/4}.
		{ VeVector length: 1 angle: VeAngle pi/ -4. VeVector length: 1 angle: VeAngle pi/ -4. VeVector angle: VeAngle pi/4}.
	}
]

{ #category : #testing }
RrRunawayTest >> obstacleVectorAndResultingSpeed [
	^{
		{VeVector zero. VeVector length: 1}.
		{VeVector length: 1. VeVector angle: VeAngle halfPi}.
		{VeVector length: 0.1. VeVector length: 0.9 angle: VeAngle halfPiNegated/10}.
		{VeVector length: 1 angle: VeAngle halfPi. VeVector length: 1}.
		{VeVector length: 1 angle: VeAngle halfPiNegated. VeVector length: 1}.
		{VeVector length: 1 angle: VeAngle quarterPi . VeVector length: 0.2928932188134524 angle: VeAngle quarterPiNegated}.
		{VeVector length: 0.1 angle: VeAngle quarterPi . VeVector length:  0.9292893218813453 angle: VeAngle quarterPiNegated/10}.
		{VeVector length: 1 angle: VeAngle quarterPiNegated. VeVector length: 0.2928932188134524 angle: VeAngle quarterPi}.
		{VeVector length: 0.1 angle: VeAngle quarterPiNegated. VeVector length:  0.9292893218813453 angle: VeAngle quarterPi/10}.
	}
]

{ #category : #testing }
RrRunawayTest >> setUp [
	super setUp.
	runaway := RrRunaway new.

]
