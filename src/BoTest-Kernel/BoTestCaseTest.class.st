Class {
	#name : #BoTestCaseTest,
	#superclass : #TestCase,
	#category : #'BoTest-Kernel-Test'
}

{ #category : #testing }
BoTestCaseTest >> assertForTestResult: aTestResult runCount: runCount passed: passedCount failed: failureCount errors: errorCount expectedFailures: expectedFailureCount [
	self
		assert: aTestResult runCount = runCount;
		assert: aTestResult expectedPassCount = passedCount;
		assert: aTestResult failureCount = failureCount;
		assert: aTestResult errorCount = errorCount;
		assert: aTestResult expectedDefectCount = expectedFailureCount
]

{ #category : #testing }
BoTestCaseTest >> testExpectedFailureIfRequirementsFails [
	| case result |
	case := BoRequirementExampleTest selector: #testRequiresFailingTest.
	result := case run.
	self assert: case isExpectedDefect.
	self deny: case shouldPass.
	self assert: (case expectedFailures  includes: case selector).
	self
		assertForTestResult: result
		runCount: 1 "The required test is not counted here"
		passed: 0
		failed: 0
		errors: 0
		expectedFailures: 1 "The run tests is expected failure since the required one failed"
]

{ #category : #testing }
BoTestCaseTest >> testExpectedFailureIfRequirementsIsExpectedFailure [
	| case result |
	case := BoRequirementExampleTest selector: #testRequiresExpectedFailure.
	result := case run.
	self assert: case isExpectedDefect.
	self deny: case shouldPass.
	self assert: (case expectedFailures  includes: case selector).
	self
		assertForTestResult: result
		runCount: 1 "The required test is not counted here"
		passed: 0
		failed: 0
		errors: 0
		expectedFailures: 1 "The run tests is expected failure since the required one failed"
]

{ #category : #testing }
BoTestCaseTest >> testPassAllTheTheTime [
	| case result |
	case := BoRequirementExampleTest selector: #testThatPassesAllTheTime.
	result := case run.
	self assert: case shouldPass.
	self
		assertForTestResult: result
		runCount: 1 
		passed: 1
		failed: 0
		errors: 0
		expectedFailures: 0
]

{ #category : #testing }
BoTestCaseTest >> testPassingTestWithPassingRequirement [
	| case result |
	case := BoRequirementExampleTest selector: #testRequiresPassingTest.
	result := case run.
	self assert: case shouldPass.
	self
		assertForTestResult: result
		runCount: 1 "The required test is not counted here"
		passed: 1 "Our test passes"
		failed: 0 
		errors: 0
		expectedFailures: 0
]
