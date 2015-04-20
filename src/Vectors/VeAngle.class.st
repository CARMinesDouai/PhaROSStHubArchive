"
A VeAngle is a reified angle value. Its values is always between Pi and -Pi.

Instance Variables
	radians:		<Number>

radians
	- this is the angle value in radians

"
Class {
	#name : #VeAngle,
	#superclass : #Number,
	#instVars : [
		'radians'
	],
	#classVars : [
		'HalfPi',
		'Pi',
		'TwoPi'
	],
	#category : #Vectors
}

{ #category : #'instance creation' }
VeAngle class >> halfPi [
	^self radians: HalfPi
]

{ #category : #'instance creation' }
VeAngle class >> halfPiNegated [
	^self radians: HalfPi negated
]

{ #category : #initialization }
VeAngle class >> initialize [
	Pi := Float pi.
	HalfPi := Pi / 2.
	TwoPi := Pi * 2.
]

{ #category : #'instance creation' }
VeAngle class >> pi [
	^self radians: Pi
]

{ #category : #'instance creation' }
VeAngle class >> quarterPi [
	^self radians: Pi / 4
]

{ #category : #'instance creation' }
VeAngle class >> quarterPiNegated [
	^self radians: Pi / -4
]

{ #category : #'instance creation' }
VeAngle class >> radians: radians [
	^self new
		radians: radians;
		yourself
]

{ #category : #'instance creation' }
VeAngle class >> zero [
	^self radians: 0
]

{ #category : #arithmetic }
VeAngle >> * aNumber [
	"Answer the result of multiplying the receiver by aNumber."

	^self shouldBeImplemented
]

{ #category : #arithmetic }
VeAngle >> + aNumber [
	"Answer the sum of the receiver and aNumber."

	^self newWithRadians: self radians + aNumber
]

{ #category : #arithmetic }
VeAngle >> - aNumber [
	"Answer the difference between the receiver and aNumber."

	^self newWithRadians: self radians - aNumber
]

{ #category : #arithmetic }
VeAngle >> / aNumber [
	"Answer the result of dividing the receiver by aNumber."

	^self newWithRadians: self radians / aNumber
]

{ #category : #testing }
VeAngle >> < aMagnitude [
	"Answer whether the receiver is less than the argument."

	^self value < aMagnitude value
]

{ #category : #testing }
VeAngle >> = aNumber [
	"Compare the receiver with the argument and answer with true if the 
	receiver is equal to the argument. Otherwise answer false."

	^self value = (self round: aNumber value)
]

{ #category : #accessing }
VeAngle >> adaptRadians: aNumber [
	| abs sign |
	abs := aNumber abs.
	(abs < Pi) ifTrue: [^aNumber].
	abs = Pi ifTrue: [ ^Pi ].
	sign := aNumber sign.
	abs <=TwoPi ifTrue: [^sign negated * (TwoPi - abs)].
	^aNumber abs \\ TwoPi.
]

{ #category : #converting }
VeAngle >> adaptToFraction: receiver andSend: selector [
	"If I am involved in arithmetic with a Fraction, convert us and evaluate exprBlock."

	^receiver perform: selector with: self radians
]

{ #category : #converting }
VeAngle >> adaptToInteger: receiver andSend: selector [
	"If I am involved in arithmetic with a Integer, convert us and evaluate exprBlock."

	^self adaptToFraction: receiver andSend: selector

]

{ #category : #converting }
VeAngle >> asFloat [
	"Answer a floating-point number approximating the receiver."

	^self radians
]

{ #category : #hash }
VeAngle >> hash [
	"Hash must be redefined whenever = is redefined."

	^self value hash
]

{ #category : #accessing }
VeAngle >> newWithRadians: aNumber [
	^self species
		radians: aNumber value
]

{ #category : #'mathematical functions' }
VeAngle >> nthRoot: aPositiveInteger [
	"Answer the nth root of the receiver."

	self shouldBeImplemented
]

{ #category : #printing }
VeAngle >> printOn: aStream base: base [
	"This method should print a representation of the number for the given base,
	excluding the base prefix (and the letter r for radix)"

	self value printOn: aStream base: base.
	aStream nextPutAll: ' radians'
]

{ #category : #accessing }
VeAngle >> radians [
	^ radians
]

{ #category : #accessing }
VeAngle >> radians: aNumber [
	radians := self adaptRadians: aNumber
]

{ #category : #accessing }
VeAngle >> round: aNumber [
	^aNumber roundUpTo: self smallestMeaningfulRadiansValue
]

{ #category : #accessing }
VeAngle >> smallestMeaningfulRadiansValue [
	^0.001
]

{ #category : #'mathematical functions' }
VeAngle >> sqrt [
	"Answer the square root of the receiver."

	self shouldBeImplemented
]

{ #category : #printing }
VeAngle >> storeOn: aStream base: base [
	"This method should print a representation of the number for the given base,
	including the base prefix (with letter r for radix)"

	self shouldBeImplemented
]

{ #category : #accessing }
VeAngle >> value [
	^self round: self radians
]
