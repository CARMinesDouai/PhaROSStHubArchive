Class {
	#name : #RrFeelForceTest,
	#superclass : #ParameterizedTestCase,
	#instVars : [
		'builder',
		'integrator'
	],
	#category : #'ReactiveRobot-CollisionAvoidance'
}

{ #category : #testing }
RrFeelForceTest >> assertScan: distances from: angles resultInto: expectedVector [
	<testParametersSelector: #distancesAnglesAndExpectedVector>
	builder sensorAngles: angles.
	builder input: distances.
	self assert: integrator dataOnOutputPort equals: expectedVector 
]

{ #category : #testing }
RrFeelForceTest >> distancesAnglesAndExpectedVector [
	^{
	{#(). #(). RrVector zero}.
	{#(0.5). #(0). RrVector length: 0.5 angle: 0}.
	{#(0.5). {Float pi/4}. RrVector length: 0.5 angle: Float pi/4}.
	{#(0.5). {Float pi/3}. RrVector length: 0.5 angle: Float pi/3}.
	{#(0.5). {Float pi/2}. RrVector length: 0.5 angle: Float pi/2}.
	{#(0.5). {Float pi}. RrVector length: 0.5 angle: Float pi}.
	{#(2 3 4). {0. Float pi/3. Float pi / -3}. RrVector zero}.
	{#(0.5 2 3). {0. Float pi/3. Float pi / -3}. RrVector length: 0.5 angle: 0}.
	{#(2 0.5 3). {0. Float pi/3. Float pi / -3}. RrVector length: 0.5 angle: Float pi/3}.
	{#(2 3 0.5). {0. Float pi/3. Float pi / -3}. RrVector length: 0.5 angle: Float pi / -3}.
	{#(2 0.5 0.5). {0. Float pi/3. Float pi / -3}. RrVector length: (Float pi / 3) cos angle: 0}.
	{#(2 0.5 0.5). {0. Float pi/2. Float pi / -2}. RrVector zero}.
	}
]

{ #category : #testing }
RrFeelForceTest >> setUp [
	super setUp.
	builder := RrForceVectorsBuilder new.
	builder distanceThreshold: 1.
	integrator := RrForceIntegrator new.
	builder => integrator 
]
