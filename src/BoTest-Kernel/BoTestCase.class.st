Class {
	#name : #BoTestCase,
	#superclass : #TestCase,
	#instVars : [
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

{ #category : #testing }
BoTestCase >> hasFailingRequirement [
	^ self result hasFailingRequirement: self
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
	^#('testSelector' 'result')
]

{ #category : #testing }
BoTestCase >> isSatisfied: selector [
	^self isSatisified: selector in: self class
]

{ #category : #testing }
BoTestCase >> isSatisified: selector in: testCaseClass [ 

	(self result isRun: selector in: testCaseClass) ifFalse: [self run: selector in: testCaseClass].
	^self result isPassed: selector in: testCaseClass
]

{ #category : #requirements }
BoTestCase >> requires: aSymbol [
	(self isSatisfied: aSymbol) ifTrue: [^self].
	self result addTestWithFailingRequirement: self. 
	BoRequirementFailureException signal: self selector
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
BoTestCase >> run: selector in: testClass [ 
	| testCase |
	testCase := testClass selector: selector.
	[[testCase setUp.
	testCase performTest.
	self result addPassingRequirement: testCase]
		on: TestResult failure , Warning , TestResult error
		do: [:ex | self result addFailingRequirement: testCase]]
		ensure: [testCase tearDown. 
			testCase cleanUpInstanceVariables]
]

{ #category : #accessing }
BoTestCase >> testResourceClass [
	^TestResource 
]

{ #category : #accessing }
BoTestCase >> testResultClass [
	^BoTestResult 
]
