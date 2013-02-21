Class {
	#name : #BoTestCase,
	#superclass : #TestCase,
	#instVars : [
		'isExpectedDefect'
	],
	#category : #'BoTest-Kernel'
}

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
	self isExpectedDefect: true
]
