Class {
	#name : #VeVectorTest,
	#superclass : #ParameterizedTestCase,
	#category : #Vectors
}

{ #category : #testing }
VeVectorTest >> assert: vect1 plus: vect2 equals: expectedResult [
	<testParametersSelector: #twoVectorsAndExpectedAddition>
	
	self assert: vect1 + vect2 equals: expectedResult
	
	
]

{ #category : #testing }
VeVectorTest >> assertCartesian: vect1 convertsToPolar: vect2 [ 
	<testParametersSelector: #cartesianAndExpectedPolar>
	
	self assert: vect1 asPolarVector equals: vect2 
]

{ #category : #testing }
VeVectorTest >> cartesianAndExpectedPolar [
	^{
	{RrVector x: 1 y: 1. RrVector length: 2 sqrt angle: VeAngle quarterPi}.
	{RrVector x: 1 y: -1. RrVector length: 2 sqrt angle: VeAngle quarterPiNegated}.
	{RrVector x: -1 y: 1. RrVector length: 2 sqrt angle: 3 * VeAngle quarterPi}.
	{RrVector x: -1 y: -1. RrVector length: 2 sqrt angle: 3 * VeAngle quarterPiNegated}.
	{RrVector x: 0 y: 1. RrVector length: 1 angle: VeAngle halfPi}.
	{RrVector x: 0 y: -1. RrVector length: 1 angle: VeAngle halfPiNegated}.
	{RrVector x: 0 y: 0. RrVector length: 0 angle: 0}.
	}
]

{ #category : #testing }
VeVectorTest >> twoVectorsAndExpectedAddition [
	| polarVector cartesianVector |
	polarVector := RrVector length: 0.5 angle: VeAngle halfPi.
	cartesianVector := RrVector x: 1 y: 0.5.
	^{
	{RrVector length: 0 angle: VeAngle pi. RrVector zero. RrVector zero}.
	{RrVector length: -1 angle:0. RrVector zero. RrVector length: 1 angle: VeAngle pi}.
	{RrVector length: 1 angle: VeAngle pi. RrVector length: 1 angle: 0. RrVector zero}.
	{polarVector. polarVector. RrVector length: 1 angle: VeAngle halfPi}.
	{polarVector. polarVector asCartesianVector. RrVector length: 1 angle: VeAngle halfPi}.
	{polarVector asCartesianVector. polarVector. RrVector length: 1 angle: VeAngle halfPi}.
	{cartesianVector. cartesianVector. RrVector x: 2 y: 1}.
	{cartesianVector. cartesianVector asPolarVector. RrVector x: 2 y: 1}.
	{cartesianVector asPolarVector. cartesianVector. RrVector x: 2 y: 1}.
	}
]
