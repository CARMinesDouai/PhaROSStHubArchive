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
	builder vectorAngles: angles.
	builder input: distances.
	self assert: integrator dataOnOutputPort equals: expectedVector 
]

{ #category : #testing }
RrFeelForceTest >> distancesAnglesAndExpectedVector [
	^{
	{#(). #(). VeVector zero}.
	{#(0.5). #(0). VeVector length: 0.5 angle: 0}.
	{#(0.1). #(0). VeVector length: 0.9 angle: 0}.
	{#(0.9). #(0). VeVector length: 0.1 angle: 0}.
	{#(0.5). {VeAngle quarterPi}. VeVector length: 0.5 angle: VeAngle quarterPi}.
	{#(0.5). {VeAngle pi/3}. VeVector length: 0.5 angle: VeAngle pi/3}.
	{#(0.5). {VeAngle halfPi}. VeVector length: 0.5 angle: VeAngle halfPi}.
	{#(0.5). {VeAngle pi}. VeVector length: 0.5 angle: VeAngle pi}.
	{#(2 3 4). {0. VeAngle pi/3. VeAngle pi / -3}. VeVector zero}.
	{#(0.5 2 3). {0. VeAngle pi/3. VeAngle pi / -3}. VeVector length: 0.5 angle: 0}.
	{#(2 0.5 3). {0. VeAngle pi/3. VeAngle pi / -3}. VeVector length: 0.5 angle: VeAngle pi/3}.
	{#(2 3 0.5). {0. VeAngle pi/3. VeAngle pi / -3}. VeVector length: 0.5 angle: VeAngle pi / -3}.
	{#(2 0.5 0.5). {0. VeAngle pi/3. VeAngle pi / -3}. VeVector length: (VeAngle pi / 3) cos angle: 0}.
	{#(2 0.5 0.5). {0. VeAngle pi/2. VeAngle pi / -2}. VeVector zero}.
	}
]

{ #category : #testing }
RrFeelForceTest >> setUp [
	super setUp.
	builder := RrForceVectorsBuilder new.
	builder threshold: 1.
	integrator := RrForceIntegrator new.
	builder => integrator 
]
