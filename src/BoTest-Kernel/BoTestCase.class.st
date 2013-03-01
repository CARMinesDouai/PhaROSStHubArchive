Class {
	#name : #BoTestCase,
	#superclass : #TestCase,
	#instVars : [
		'hasFailingRequirement',
		'result'
	],
	#category : #'BoTest-Kernel'
}

{ #category : #'building suites' }
BoTestCase class >> suiteClass [
	^BoTestSuite
]

{ #category : #testing }
BoTestCase >> = aBoTestCase [
	^self class = aBoTestCase class  and: [self selector = aBoTestCase selector]
]

{ #category : #'initialize-release' }
BoTestCase >> cleanUpInstanceVariables [
	self instVarsToCleanUp do: [:ivName|
		self instVarNamed: ivName put: nil
	]
]

{ #category : #accessing }
BoTestCase >> expectedFailures [
	self isExpectedDefect ifFalse: [^ super expectedFailures].
	^ super expectedFailures copyWith: self selector 
]

{ #category : #accessing }
BoTestCase >> hash [
	^self class hash bitXor: self selector hash
]

{ #category : #'initialize-release' }
BoTestCase >> instVarsToCleanUp [
	^self class allInstVarNames copyWithoutAll: self instVarsToKeep 
]

{ #category : #'initialize-release' }
BoTestCase >> instVarsToKeep [ 
	^#('testSelector' 'isExpectedDefect')
]

{ #category : #accessing }
BoTestCase >> isExpectedDefect [
	^ hasFailingRequirement ifNil: [false]
]

{ #category : #accessing }
BoTestCase >> isExpectedDefect: anObject [
	hasFailingRequirement := anObject
]

{ #category : #testing }
BoTestCase >> isPassed: selector [
	^self isPassed: selector in: self class
]

{ #category : #testing }
BoTestCase >> isPassed: selector in: testCaseClass [ 
	(self result isRun: selector in: testCaseClass) ifFalse: [
		[self run: selector in: testCaseClass]
			on:  TestResult failure , Warning, TestResult error
		do: [ :ex | ].
	].
	^self result isPassed: selector in: testCaseClass

]

{ #category : #requirements }
BoTestCase >> requires: aSymbol [
	(self isPassed: aSymbol) ifTrue: [^self].
	^self tagAsRequirementFailure
]

{ #category : #accessing }
BoTestCase >> result [
	^ result ifNil:  [result := self testResultClass new]
]

{ #category : #performing }
BoTestCase >> run [
	| result |
	result := self testResultClass new.
	[self run: result]
		ensure: [self testResourceClass resetResources: self resources].
	^result
]

{ #category : #performing }
BoTestCase >> run: aBoTestResult [
	result := aBoTestResult.
	super run: aBoTestResult
]

{ #category : #performing }
BoTestCase >> run:  selector in: testClass [
	| testCase |
	testCase := testClass selector: selector.
	[testCase setUp.
	testCase performTest] ensure: [
		testCase tearDown.
		testCase cleanUpInstanceVariables]
]

{ #category : #tagging }
BoTestCase >> tagAsRequirementFailure [
	self result addRequirementFailure: self
]

{ #category : #accessing }
BoTestCase >> testResourceClass [
	^TestResource 
]

{ #category : #accessing }
BoTestCase >> testResultClass [
	^BoTestResult 
]
