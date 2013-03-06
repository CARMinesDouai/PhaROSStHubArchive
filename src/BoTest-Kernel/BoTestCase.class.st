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
	|case|
	case := testCaseClass selector: selector.
	(self result isRun: case) ifFalse: [self result runRequiredCase: case].
	^self result isPassed: case
]

{ #category : #requirements }
BoTestCase >> requires: aSymbol [
	(self isSatisfied: aSymbol) ifTrue: [^self].
	BoRequirementFailureException signal: self selector
]

{ #category : #accessing }
BoTestCase >> result [
	^result
]

{ #category : #accessing }
BoTestCase >> result: anObject [
	^ result := anObject
]

{ #category : #performing }
BoTestCase >> run [
	result := self testResultClass new.
	[self run: result]
		ensure: [self testResourceClass resetResources: self resources].
	^result
]

{ #category : #performing }
BoTestCase >> run: aBoTestResult [
	self result: aBoTestResult.
	super run: aBoTestResult
]

{ #category : #accessing }
BoTestCase >> testResourceClass [
	^TestResource 
]

{ #category : #accessing }
BoTestCase >> testResultClass [
	^BoTestResult 
]
