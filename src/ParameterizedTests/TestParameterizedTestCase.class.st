Class {
	#name : #TestParameterizedTestCase,
	#superclass : #TestCase,
	#instVars : [
		'testCaseClass',
		'factory'
	],
	#category : #ParameterizedTests
}

{ #category : #testing }
TestParameterizedTestCase >> copyToTestCaseClassAllMethods: selectors [
	selectors do: [ :selector|
		testCaseClass compile: (self class sourceCodeAt: selector)]
]

{ #category : #'injected methods' }
TestParameterizedTestCase >> invalidParameterValues [
	^{{1. 2. 3}.
	{10. 25. 30}.
	{100. 200. 0}}
]

{ #category : #'injected methods' }
TestParameterizedTestCase >> malFormedParametersArray [
	^{{1. 2. 3}.
	{10. 20. 30}.
	{100. 200} }
]

{ #category : #'injected methods' }
TestParameterizedTestCase >> passAllTheTimeWith: arg1 with: arg2 with: arg3 [ 
	<testParametersSelector: #malFormedParametersArray>

]

{ #category : #testing }
TestParameterizedTestCase >> setUp [ 	
	super setUp.
	factory := ClassFactoryForTestCase new.
	testCaseClass := factory newSubclassOf: ParameterizedTestCase instanceVariableNames: ''  classVariableNames: ''
]

{ #category : #'injected methods' }
TestParameterizedTestCase >> sumOf: arg1 and: arg2 shouldBe: arg3 [ 
	<testParametersSelector: #invalidParameterValues>
	self assert: arg1 + arg2 equals: arg3
]

{ #category : #testing }
TestParameterizedTestCase >> tearDown [ 	
	super tearDown.
	factory cleanUp
]

{ #category : #testing }
TestParameterizedTestCase >> testShouldFailWithInvalidNumberOfParameters [
	| testResult |
	self copyToTestCaseClassAllMethods: #(#passAllTheTimeWith:with:with:  #malFormedParametersArray).
	testResult := testCaseClass buildSuite run.
	self assert: testResult runCount = 3. "There should be one test case for each group of parameters"
	self assert: testResult expectedPassCount = 2.
	self assert: testResult skippedCount = 0.
	self assert: testResult expectedDefectCount = 0.
	self assert: testResult unexpectedFailureCount = 0.
	self assert: testResult unexpectedErrorCount = 1.
	self assert: testResult unexpectedPassCount = 0
]

{ #category : #testing }
TestParameterizedTestCase >> testShouldFailWithInvalidParametersValues [
	| testResult |
	self copyToTestCaseClassAllMethods: #(#sumOf:and:shouldBe:  #invalidParameterValues).
	testResult := testCaseClass buildSuite run.
	self assert: testResult runCount = 3. "There should be one test case for each group of parameters"
	self assert: testResult expectedPassCount = 1.
	self assert: testResult skippedCount = 0.
	self assert: testResult expectedDefectCount = 0.
	self assert: testResult unexpectedFailureCount = 2.
	self assert: testResult unexpectedErrorCount = 0.
	self assert: testResult unexpectedPassCount = 0
]
