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
	{VeVector x: 1 y: 1. VeVector length: 2 sqrt angle: VeAngle quarterPi}.
	{VeVector x: 1 y: -1. VeVector length: 2 sqrt angle: VeAngle quarterPiNegated}.
	{VeVector x: -1 y: 1. VeVector length: 2 sqrt angle: 3 * VeAngle quarterPi}.
	{VeVector x: -1 y: -1. VeVector length: 2 sqrt angle: 3 * VeAngle quarterPiNegated}.
	{VeVector x: 0 y: 1. VeVector length: 1 angle: VeAngle halfPi}.
	{VeVector x: 0 y: -1. VeVector length: 1 angle: VeAngle halfPiNegated}.
	{VeVector x: 0 y: 0. VeVector length: 0 angle: 0}.
	}
]

{ #category : #testing }
VeVectorTest >> twoVectorsAndExpectedAddition [
	| polarVector cartesianVector |
	polarVector := VeVector length: 0.5 angle: VeAngle halfPi.
	cartesianVector := VeVector x: 1 y: 0.5.
	^{
	{VeVector length: 0 angle: VeAngle pi. VeVector zero. VeVector zero}.
	{VeVector length: -1 angle:0. VeVector zero. VeVector length: 1 angle: VeAngle pi}.
	{VeVector length: 1 angle: VeAngle pi. VeVector length: 1 angle: 0. VeVector zero}.
	{polarVector. polarVector. VeVector length: 1 angle: VeAngle halfPi}.
	{polarVector. polarVector asCartesianVector. VeVector length: 1 angle: VeAngle halfPi}.
	{polarVector asCartesianVector. polarVector. VeVector length: 1 angle: VeAngle halfPi}.
	{cartesianVector. cartesianVector. VeVector x: 2 y: 1}.
	{cartesianVector. cartesianVector asPolarVector. VeVector x: 2 y: 1}.
	{cartesianVector asPolarVector. cartesianVector. VeVector x: 2 y: 1}.
	}
]
