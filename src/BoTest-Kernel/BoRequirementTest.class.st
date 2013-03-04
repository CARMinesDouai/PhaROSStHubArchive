Class {
	#name : #BoRequirementTest,
	#superclass : #TestCase,
	#category : #'BoTest-Kernel-Test'
}

{ #category : #testing }
BoRequirementTest >> assertForTestResult: aResult runCount: aRunCount passed: aPassedCount failed: aFailureCount errors: anErrorCount expectedFailures: anExpectedFailureCount requirementFailures: expectedRequirementFailuresCount [

	self
		assert: aResult runCount = aRunCount;
		assert: aResult expectedPassCount = aPassedCount;
		assert: aResult failureCount = aFailureCount;
		assert: aResult errorCount = anErrorCount;
		assert: aResult expectedDefectCount = anExpectedFailureCount;
		assert: aResult requirementFailuresCount = expectedRequirementFailuresCount
]

{ #category : #testing }
BoRequirementTest >> testPassAllTheTheTime [
	| case result |
	case := BoTestWithRequirements selector: #testThatPassesAllTheTime.
	result := case run.
	self assert: case shouldPass.
	self
		assertForTestResult: result
		runCount: 1 
		passed: 1
		failed: 0
		errors: 0
		expectedFailures: 0
		requirementFailures: 0
]

{ #category : #testing }
BoRequirementTest >> testPassingTestWithPassingRequirement [
	| case result |
	case := BoTestWithRequirements selector: #testRequiresPassingTest. 
	result := case run.
	self assert: case shouldPass.
	self
		assertForTestResult: result
		runCount: 1 "The required test is not counted here"
		passed: 1 "Our test passes"
		failed: 0 
		errors: 0
		expectedFailures: 0
		requirementFailures: 0
]

{ #category : #testing }
BoRequirementTest >> testRequirementFailureIfRequirementsFails [
	| case result |
	case := BoTestWithRequirements selector: #testRequiresFailingTest.
	result := case run.
	self assert: case hasFailingRequirement.
	self
		assertForTestResult: result
		runCount: 1 "The required test is not counted here"
		passed: 0
		failed: 0
		errors: 0
		expectedFailures: 0
		requirementFailures: 1 
]

{ #category : #testing }
BoRequirementTest >> testRequirementFailureIfRequirementsIsError [
	| case result |
	case := BoTestWithRequirements selector: #testRequiresErrorTest.
	result := case run.
	self assert: case hasFailingRequirement.
	self
		assertForTestResult: result
		runCount: 1 "The required test is not counted here"
		passed: 0
		failed: 0
		errors: 0
		expectedFailures: 0
		requirementFailures: 1 
]

{ #category : #testing }
BoRequirementTest >> testRequirementFailureIfRequirementsIsExpectedFailure [
	| case result |
	case := BoTestWithRequirements selector: #testRequiresExpectedFailure.
	result := case run.
	self assert: case hasFailingRequirement.
	self
		assertForTestResult: result
		runCount: 1 "The required test is not counted here"
		passed: 0
		failed: 0
		errors: 0
		expectedFailures: 0
		requirementFailures: 1 
]

{ #category : #testing }
BoRequirementTest >> testRequirementFailureIfRequirementsSignalsWarning [
	| case result |
	case := BoTestWithRequirements selector: #testRequiresWarningTest.
	result := case run.
	self assert: case hasFailingRequirement.
	self
		assertForTestResult: result
		runCount: 1 "The required test is not counted here"
		passed: 0
		failed: 0
		errors: 0
		expectedFailures: 0
		requirementFailures: 1 
]
