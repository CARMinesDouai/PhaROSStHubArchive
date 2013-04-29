Class {
	#name : #PBTestCase,
	#superclass : #BoTestCase,
	#instVars : [
		'robot'
	],
	#classVars : [
		'ShouldRequestAction'
	],
	#category : #'PureNGTest-Kernel'
}

{ #category : #accessing }
PBTestCase class >> disableRequestAction [
	ShouldRequestAction := false
]

{ #category : #accessing }
PBTestCase class >> enableRequestAction [
	ShouldRequestAction := true
]

{ #category : #testing }
PBTestCase class >> isAbstract [

	^self == PNGTestCase.
]

{ #category : #'human in the loop' }
PBTestCase >> requestAction: aString [ 
	self requestAction: aString orDo: [ ]
]

{ #category : #'human in the loop' }
PBTestCase >> requestAction: aString orDo: aBlock [
	self shouldRequestAction ifTrue: [^self halt: aString].
	Transcript 
		cr; 
		show: 'Ignored action request: '; 
		show: aString.
	aBlock value
]

{ #category : #testing }
PBTestCase >> setUp [
	super setUp.
	robot := PNGRobulabHandcodedFactory kompai2
]

{ #category : #'human in the loop' }
PBTestCase >> shouldRequestAction [
	^ShouldRequestAction ifNil: [ self class disableRequestAction ]
]

{ #category : #testing }
PBTestCase >> tearDown [ 
	super tearDown.
	robot finalize
]
