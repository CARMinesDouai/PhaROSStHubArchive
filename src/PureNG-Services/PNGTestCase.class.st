Class {
	#name : #PNGTestCase,
	#superclass : #TestCase,
	#classVars : [
		'ShouldRequestAction'
	],
	#category : #'PureNG-Kernel-Test'
}

{ #category : #accessing }
PNGTestCase class >> disableRequestAction [
	ShouldRequestAction := false
]

{ #category : #accessing }
PNGTestCase class >> enableRequestAction [
	ShouldRequestAction := true
]

{ #category : #testing }
PNGTestCase class >> isAbstract [

	^self == PNGTestCase.
]

{ #category : #'human in the loop' }
PNGTestCase >> requestAction: aString [
	
	self shouldRequestAction ifTrue: [self halt: aString ]
]

{ #category : #'human in the loop' }
PNGTestCase >> shouldRequestAction [
	^ShouldRequestAction ifNil: [ self class disableRequestAction ]
]
