Class {
	#name : #VeAngleTest,
	#superclass : #TestCase,
	#instVars : [
		'angle'
	],
	#category : #Vectors
}

{ #category : #testing }
VeAngleTest >> setUp [
	super setUp.
	angle := VeAngle zero
]

{ #category : #testing }
VeAngleTest >> testGoingAbovePi [
	angle radians: 2 * Float pi.
	self assert: angle equals: 0.
	angle radians: 3 * Float halfPi.
	self assert: angle equals: Float halfPi negated.
	
]

{ #category : #testing }
VeAngleTest >> testGoingBelowPiNegated [
	angle radians: 2 * Float pi negated.
	self assert: angle equals: 0.
	angle radians: 3 * Float halfPi negated.
	self assert: angle equals: Float halfPi.

]

{ #category : #testing }
VeAngleTest >> testLessThanPiNegated [
	| halfPi quarterPi |
	halfPi := Float halfPi.
	quarterPi := halfPi / 2.
	{3 * quarterPi. halfPi.  quarterPi} do: [ :radians|
		angle radians: radians.
		self assert: angle negated equals: radians negated.
	]

]

{ #category : #testing }
VeAngleTest >> testPiNegatedIsPi [
	angle radians: Float pi negated.
	self assert: angle equals: Float pi.

]
