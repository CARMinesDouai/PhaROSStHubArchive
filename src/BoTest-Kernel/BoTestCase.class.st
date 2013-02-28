Class {
	#name : #BoTestCase,
	#superclass : #TestCase,
	#instVars : [
		'isExpectedDefect'
	],
	#category : #'BoTest-Kernel'
}

{ #category : #accessing }
BoTestCase class >> resources [
	^{"BoDefectsCache"}
]

{ #category : #'initialize-release' }
BoTestCase >> cleanUpInstanceVariables [
	self instVarsToCleanUp do: [:ivName|
		self instVarNamed: ivName put: nil
	]
]

{ #category : #accessing }
BoTestCase >> defectCache [
	^BoDefectsCache current 
]

{ #category : #accessing }
BoTestCase >> expectedFailures [
	self isExpectedDefect ifFalse: [^ super expectedFailures].
	^ super expectedFailures copyWith: self selector 
]

{ #category : #'initialize-release' }
BoTestCase >> instVarsToCleanUp [
	^self class allInstVarNames copyWithoutAll: self instVarsToKeep 
]

{ #category : #'initialize-release' }
BoTestCase >> instVarsToKeep [ 
	^#('testSelector' 'isExpectedDefect')
]

{ #category : #testing }
BoTestCase >> isDefect: selector [
	^self isDefect: selector in: self class
]

{ #category : #testing }
BoTestCase >> isDefect: selector in: testCaseClass [ 
	(self defectCache includes: testCaseClass -> selector) ifTrue: [^true]. 
	[testCaseClass run: selector]
		on:  Error
		do: [ :ex | 
			^true].
	^false
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
	(self isDefect: aSymbol) ifFalse: [^self].
	^self tagAsExpectedDefect
]

{ #category : #tagging }
BoTestCase >> tagAsDefect: selector in:  testCaseClass [
	self defectCache add: testCaseClass -> selector
]

{ #category : #tagging }
BoTestCase >> tagAsExpectedDefect [
	self isExpectedDefect: true.
	self tagAsDefect: self selector in: self class.
	self fail
]
