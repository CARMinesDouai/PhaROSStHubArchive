Class {
	#name : #RrVectorTest,
	#superclass : #ParameterizedTestCase,
	#category : #'ReactiveRobot-Vectors'
}

{ #category : #testing }
RrVectorTest >> assert: vect1 plus: vect2 equals: expectedResult [
	<testParametersSelector: #twoVectorsAndExpectedAddition>
	
	self assert: vect1 + vect2 equals: expectedResult
	
	
]

{ #category : #testing }
RrVectorTest >> assertCartesian: vect1 convertsToPolar: vect2 [ 
	<testParametersSelector: #cartesianAndExpectedPolar>
	
	self assert: vect1 asPolarVector equals: vect2 
]

{ #category : #testing }
RrVectorTest >> cartesianAndExpectedPolar [
	^{
	{RrVector x: 1 y: 1. RrVector length: 2 sqrt angle: Float pi /4}.
	{RrVector x: 1 y: -1. RrVector length: 2 sqrt angle: Float pi / -4}.
	{RrVector x: -1 y: 1. RrVector length: 2 sqrt angle: Float pi * 3/4}.
	{RrVector x: -1 y: -1. RrVector length: 2 sqrt angle: Float pi * 3/ -4}.
	{RrVector x: 0 y: 1. RrVector length: 1 angle: Float halfPi}.
	{RrVector x: 0 y: -1. RrVector length: 1 angle: Float halfPi negated}.
	{RrVector x: 0 y: 0. RrVector length: 0 angle: 0}.
	}
]

{ #category : #testing }
RrVectorTest >> twoVectorsAndExpectedAddition [
	| polarVector cartesianVector |
	polarVector := RrVector length: 0.5 angle: Float halfPi.
	cartesianVector := RrVector x: 1 y: 0.5.
	^{
	{RrVector length: 0 angle: Float pi. RrVector zero. RrVector zero}.
	{RrVector length: -1 angle:0. RrVector zero. RrVector length: 1 angle: Float pi}.
	{RrVector length: 1 angle: Float pi. RrVector length: 1 angle: 0. RrVector zero}.
	{polarVector. polarVector. RrVector length: 1 angle: Float halfPi}.
	{polarVector. polarVector asCartesianVector. RrVector length: 1 angle: Float halfPi}.
	{polarVector asCartesianVector. polarVector. RrVector length: 1 angle: Float halfPi}.
	{cartesianVector. cartesianVector. RrVector x: 2 y: 1}.
	{cartesianVector. cartesianVector asPolarVector. RrVector x: 2 y: 1}.
	{cartesianVector asPolarVector. cartesianVector. RrVector x: 2 y: 1}.
	}
]
