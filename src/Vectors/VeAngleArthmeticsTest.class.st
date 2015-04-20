Class {
	#name : #VeAngleArthmeticsTest,
	#superclass : #ParameterizedTestCase,
	#category : #Vectors
}

{ #category : #testing }
VeAngleArthmeticsTest >> angle1DivideByNumberEqualsAngle2 [
	^{ 
	{VeAngle zero. 1. VeAngle zero}.
	{VeAngle pi. 2. VeAngle halfPi}.
	{VeAngle halfPi. 2. VeAngle quarterPi}.
	{VeAngle halfPiNegated. 2. VeAngle quarterPiNegated}.
	{VeAngle halfPiNegated. VeAngle quarterPiNegated. 2}.
	}
]

{ #category : #testing }
VeAngleArthmeticsTest >> angle1MinusAngle2EqualsAngle3 [
	^{ 
	{VeAngle zero. VeAngle pi. VeAngle pi}.
	{VeAngle halfPi. VeAngle halfPi. 0}.
	{VeAngle halfPi. VeAngle halfPiNegated. VeAngle pi}.
	{VeAngle halfPi. VeAngle quarterPi. VeAngle quarterPi}.
	{VeAngle quarterPi. VeAngle halfPi. VeAngle quarterPiNegated}.
	}
]

{ #category : #testing }
VeAngleArthmeticsTest >> angle1PlusAngle2EqualsAngle3 [
	^{ 
	{VeAngle zero. VeAngle pi. VeAngle pi}.
	{VeAngle halfPi. VeAngle halfPi. VeAngle pi}.
	{VeAngle halfPi. VeAngle halfPiNegated. VeAngle zero}.
	{VeAngle halfPi. VeAngle quarterPi. 3 * VeAngle quarterPi}.
	}
]

{ #category : #testing }
VeAngleArthmeticsTest >> assert: angle1 divideBy: number equals: angle2 [
	<testParametersSelector: #angle1DivideByNumberEqualsAngle2>
	self assert: angle1 / number equals: angle2


]

{ #category : #testing }
VeAngleArthmeticsTest >> assert: angle1 minus: angle2 equals: angle3 [
	<testParametersSelector: #angle1MinusAngle2EqualsAngle3>
	self assert: angle1 - angle2 equals: angle3


]

{ #category : #testing }
VeAngleArthmeticsTest >> assert: angle1 plus: angle2 equals: angle3 [
	<testParametersSelector: #angle1PlusAngle2EqualsAngle3>
	self assert: angle1 + angle2 equals: angle3


]
