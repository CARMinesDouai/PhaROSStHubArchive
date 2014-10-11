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

{ #category : #performing }
BoTestCase >> debug [
	|case|
	case := self class selector: testSelector.
	case result: self resultClass new.
	[case runCase]
		ensure: [TestResource resetResources: self resources]
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
	^(self result isPassed: case) and: [case isExpectedFailure not]
]

{ #category : #'tester actions' }
BoTestCase >> questionWithoutCancel: aMessage [
	^UIManager default questionWithoutCancel: aMessage
]

{ #category : #'tester actions' }
BoTestCase >> requestAction: aString [ 
	^UIManager default message: aString
]

{ #category : #'tester actions' }
BoTestCase >> requestAssert: aMessage [
	self assert: (self questionWithoutCancel: aMessage)
]

{ #category : #'tester actions' }
BoTestCase >> requestDeny: aMessage [
	self deny: (self  questionWithoutCancel: aMessage)
]

{ #category : #requirements }
BoTestCase >> requires: aSymbolOrATestCaseClass [
	aSymbolOrATestCaseClass isBehavior ifTrue: [  
		aSymbolOrATestCaseClass testSelectors do: [  :each |
				(self isSatisified: each in: aSymbolOrATestCaseClass) ifTrue: [^self].
				BoRequirementFailureException signal: self selector
	]]. 
	aSymbolOrATestCaseClass isSymbol ifTrue: [  
			(self isSatisfied: aSymbolOrATestCaseClass) ifTrue: [^self].
			BoRequirementFailureException signal: self selector		
	].
	BoRequirementFailureException signal: 'Unknown requirement: ', aSymbolOrATestCaseClass printString
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
BoTestCase >> resultClass [
	^BoTestResult 
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
