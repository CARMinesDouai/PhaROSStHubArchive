Class {
	#name : #BoTestCase,
	#superclass : #TestCase,
	#instVars : [
		'isExpectedDefect'
	],
	#classVars : [
		'expectedFails'
	],
	#category : #'BoTest-Kernel'
}

{ #category : #accessing }
BoTestCase class >> expectedFails [
	^ expectedFails
]

{ #category : #accessing }
BoTestCase class >> expectedFails: anObject [
	expectedFails := anObject
]

{ #category : #tagging }
BoTestCase >> addAsExpectedFailure [

	self class expectedFails ifNil:[ self class expectedFails: self expectedFailures asSet].
	self class expectedFails add: self selector.
]

{ #category : #accessing }
BoTestCase >> expectedFailures [

	^ super expectedFailures union: self class expectedFails 
]

{ #category : #testing }
BoTestCase >> isDefect: selector [
	^self isDefect: selector in: self class
]

{ #category : #testing }
BoTestCase >> isDefect: selector in: testCaseClass [ 
	^BoDefectsCache current includes: testCaseClass -> selector
]

{ #category : #accessing }
BoTestCase >> isExpectedDefect [
	^ isExpectedDefect ifNil: [false]
]

{ #category : #accessing }
BoTestCase >> isExpectedDefect: anObject [

	isExpectedDefect := anObject
]

{ #category : #performing }
BoTestCase >> performTest [
	[super performTest] 
		on:  TestResult failure , TestResult error
		do: [ :ex |
			self tagAsDefect: testSelector in: self class.
			ex pass]
]

{ #category : #requirements }
BoTestCase >> require: aSymbol [
	(self isDefect: aSymbol) ifTrue: [^self tagAsExpectedDefect].
	[self runTest: aSymbol]
		on:  TestResult failure , TestResult error
		do: [ :ex | 
			self tagAsExpectedDefect.
			ex pass ]
]

{ #category : #performing }
BoTestCase >> runTest: selector [ 
	(self class selector: selector) runCase
]

{ #category : #testing }
BoTestCase >> shouldPass [
	^super shouldPass and:  [self isExpectedDefect not] 
]

{ #category : #tagging }
BoTestCase >> tagAsDefect: selector in:  testCaseClass [
	BoDefectsCache current add: testCaseClass -> selector
]

{ #category : #tagging }
BoTestCase >> tagAsExpectedDefect [
	self isExpectedDefect: true.
	self addAsExpectedFailure.
	self fail.
]
