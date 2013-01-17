Class {
	#name : #PNGTestCase,
	#superclass : #TestCase,
	#category : #'PureNG-Kernel-Test'
}

{ #category : #testing }
PNGTestCase class >> isAbstract [

	^self == PNGTestCase.
]

{ #category : #'human in the loop' }
PNGTestCase >> requestAction: aString [

	self halt: aString.
]
