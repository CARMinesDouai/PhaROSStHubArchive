Class {
	#name : #RrForceVectorsBuilderTest,
	#superclass : #ParameterizedTestCase,
	#instVars : [
		'builder'
	],
	#category : #'ReactiveRobot-Kernel'
}

{ #category : #testing }
RrForceVectorsBuilderTest >> assert: threashold andValues: values leadTo: expectedVectors [
	<testParametersSelector: #withThresholdValuesLeadToVectors> 
	
	builder threshold: threashold.
	builder input: values.
	self assert: builder dataOnOutputPort asArray equals: expectedVectors
]

{ #category : #testing }
RrForceVectorsBuilderTest >> setUp [
	super setUp.
	builder := RrForceVectorsBuilder new.
	builder sensorAngles: #(0 0 0) 
]

{ #category : #testing }
RrForceVectorsBuilderTest >> withThresholdValuesLeadToVectors [
	| expectedVectors |
	expectedVectors := {VeVector length: 0.9. VeVector length: 0.5. VeVector length: 0.1}.
	^{
		{1. #(4 2 3). #()}.
		{1. #(0.1 0.5 0.9). expectedVectors}. 
		{0.1. #(0.01 0.05 0.09). expectedVectors}.
		{2. #(0.2 1 1.8). expectedVectors}.
	}
]
