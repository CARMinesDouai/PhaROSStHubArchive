Class {
	#name : #PNGTestCase,
	#superclass : #TestCase,
	#instVars : [
		'robot'
	],
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
	self shouldRequestAction ifTrue: [^self halt: aString].
	Transcript 
		cr; 
		show: 'Ignored action request: '; 
		show: aString 
]

{ #category : #testing }
PNGTestCase >> setUp [
	super setUp.
	robot := PNGRobulabHandcodedFactory kompai1
]

{ #category : #'human in the loop' }
PNGTestCase >> shouldRequestAction [
	^ShouldRequestAction ifNil: [ self class disableRequestAction ]
]

{ #category : #testing }
PNGTestCase >> tearDown [ 
	super tearDown.
	robot finalize
]
