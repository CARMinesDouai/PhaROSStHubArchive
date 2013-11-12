Class {
	#name : #TestParameterizedTestCase,
	#superclass : #TestCase,
	#instVars : [
		'testCaseClass',
		'factory'
	],
	#category : #ParameterizedTests
}

{ #category : #'injected methods' }
TestParameterizedTestCase >> buggySumOf: arg1 and: arg2 shouldBe: arg3 [ 
	<testParametersSelector: #sumParameterValues>
	self assert: arg1 - arg2 equals: arg3
]

{ #category : #testing }
TestParameterizedTestCase >> copyAndRenameToTestCaseClassAllMethods: selectorsDict [
	|method|
	selectorsDict keysAndValuesDo: [ :originalSelector :newSelector|
		testCaseClass compile: (self class sourceCodeAt: originalSelector).
		method := testCaseClass compiledMethodAt: originalSelector.
		testCaseClass removeSelector: originalSelector.
		testCaseClass addSelectorSilently: newSelector withMethod: method]
]

{ #category : #testing }
TestParameterizedTestCase >> copyToTestCaseClassAllMethods: selectors [
	selectors do: [ :selector|
		testCaseClass compile: (self class sourceCodeAt: selector)]
]

{ #category : #'injected methods' }
TestParameterizedTestCase >> failingTestWithNoParameters [
	self assert: false
]

{ #category : #'injected methods' }
TestParameterizedTestCase >> invalidParameterValues [
	^{{1. 2. 3}.
	{10. 25. 30}.
	{100. 200. 0}}
]

{ #category : #'injected methods' }
TestParameterizedTestCase >> invalidParametersSumOf: arg1 and: arg2 shouldBe: arg3 [ 
	<testParametersSelector: #invalidParameterValues>
	self assert: arg1 + arg2 equals: arg3
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

{ #category : #'injected methods' }
TestParameterizedTestCase >> passingTestWithNoParameters [
	self assert: true
]

{ #category : #testing }
TestParameterizedTestCase >> setUp [ 	
	super setUp.
	factory := ClassFactoryForTestCase new.
	testCaseClass := factory newSubclassOf: ParameterizedTestCase instanceVariableNames: ''  classVariableNames: ''
]

{ #category : #'injected methods' }
TestParameterizedTestCase >> sumOf: arg1 and: arg2 shouldBe: arg3 [ 
	<testParametersSelector: #sumParameterValues>
	self assert: arg1 + arg2 equals: arg3
]

{ #category : #'injected methods' }
TestParameterizedTestCase >> sumParameterValues [
	^{{1. 2. 3}.
	{10. 20. 30}.
	{100. 200. 300}}
]

{ #category : #testing }
TestParameterizedTestCase >> tearDown [ 	
	super tearDown.
	factory cleanUp
]

{ #category : #testing }
TestParameterizedTestCase >> testShouldCleanUpPreserveParameters [
	| testCase initialParameters |
	self copyToTestCaseClassAllMethods: #(#sumOf:and:shouldBe:  #sumParameterValues).
	testCase := testCaseClass buildSuite tests anyOne.
	initialParameters := testCase parameters.
	testCase runCase.
	self assert: testCase parameters equals: initialParameters
]

{ #category : #testing }
TestParameterizedTestCase >> testShouldDebugCreateACopyWithParameters [
	self copyToTestCaseClassAllMethods: #(#sumOf:and:shouldBe:  #sumParameterValues).
	self shouldnt: [testCaseClass buildSuite debug] raise: Error
	
]

{ #category : #testing }
TestParameterizedTestCase >> testShouldFailWithBuggyTest [
	| testResult |
	self copyToTestCaseClassAllMethods: #(#buggySumOf:and:shouldBe:  #sumParameterValues).
	testResult := testCaseClass buildSuite run.
	self assert: testResult runCount = 3. "There should be one test case for each group of parameters"
	self assert: testResult expectedPassCount = 0.
	self assert: testResult skippedCount = 0.
	self assert: testResult expectedDefectCount = 0.
	self assert: testResult unexpectedFailureCount = 3.
	self assert: testResult unexpectedErrorCount = 0.
	self assert: testResult unexpectedPassCount = 0
]

{ #category : #testing }
TestParameterizedTestCase >> testShouldFailWithFalingPlainOldTestThatHasNoParameters [
	| testResult |
	self copyAndRenameToTestCaseClassAllMethods: {#failingTestWithNoParameters -> #testShouldFail} asDictionary.
	testResult := testCaseClass buildSuite run.
	self assert: testResult runCount = 1. 
	self assert: testResult expectedPassCount = 0.
	self assert: testResult skippedCount = 0.
	self assert: testResult expectedDefectCount = 0.
	self assert: testResult unexpectedFailureCount = 1.
	self assert: testResult unexpectedErrorCount = 0.
	self assert: testResult unexpectedPassCount = 0
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
	self copyToTestCaseClassAllMethods: #(#invalidParametersSumOf:and:shouldBe:  #invalidParameterValues).
	testResult := testCaseClass buildSuite run.
	self assert: testResult runCount = 3. "There should be one test case for each group of parameters"
	self assert: testResult expectedPassCount = 1.
	self assert: testResult skippedCount = 0.
	self assert: testResult expectedDefectCount = 0.
	self assert: testResult unexpectedFailureCount = 2.
	self assert: testResult unexpectedErrorCount = 0.
	self assert: testResult unexpectedPassCount = 0
]

{ #category : #testing }
TestParameterizedTestCase >> testShouldPassWithValidPlainOldTestThatHasNoParameters [
	| testResult |
	self copyAndRenameToTestCaseClassAllMethods: {#passingTestWithNoParameters -> #testShouldPass} asDictionary.
	testResult := testCaseClass buildSuite run.
	self assert: testResult runCount = 1. 
	self assert: testResult expectedPassCount = 1.
	self assert: testResult skippedCount = 0.
	self assert: testResult expectedDefectCount = 0.
	self assert: testResult unexpectedFailureCount = 0.
	self assert: testResult unexpectedErrorCount = 0.
	self assert: testResult unexpectedPassCount = 0
]

{ #category : #testing }
TestParameterizedTestCase >> testShouldPassWithValidTestAndValidParametersValues [
	| testResult |
	self copyToTestCaseClassAllMethods: #(#sumOf:and:shouldBe:  #sumParameterValues).
	testResult := testCaseClass buildSuite run.
	self assert: testResult runCount = 3. "There should be one test case for each group of parameters"
	self assert: testResult expectedPassCount = 3.
	self assert: testResult skippedCount = 0.
	self assert: testResult expectedDefectCount = 0.
	self assert: testResult unexpectedFailureCount = 0.
	self assert: testResult unexpectedErrorCount = 0.
	self assert: testResult unexpectedPassCount = 0
]

{ #category : #testing }
TestParameterizedTestCase >> testrunSelectorShouldPassWithValidTestAndValidParametersValues [
	| testResult |
	self copyToTestCaseClassAllMethods: #(#sumOf:and:shouldBe:  #sumParameterValues).
	testResult := testCaseClass run: #sumOf:and:shouldBe:.
	self assert: testResult runCount = 3. "There should be one test case for each group of parameters"
	self assert: testResult expectedPassCount = 3.
	self assert: testResult skippedCount = 0.
	self assert: testResult expectedDefectCount = 0.
	self assert: testResult unexpectedFailureCount = 0.
	self assert: testResult unexpectedErrorCount = 0.
	self assert: testResult unexpectedPassCount = 0
]
