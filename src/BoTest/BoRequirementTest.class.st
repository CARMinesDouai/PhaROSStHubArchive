Class {
	#name : #BoRequirementTest,
	#superclass : #BoTestCaseTest,
	#category : #'BoTest-Kernel-Test'
}

{ #category : #testing }
BoRequirementTest >> testPassingTestWithPassingRequirement [
	| case result |
	case := BoTestWithRequirementsThatPass selector: #testRequiresPassingTest. 
	result := case run.
	self deny: case hasFailingRequirement.
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
BoRequirementTest >> testRequirementFailureIfRequirementsIsError [
	| case result |
	case := BoTestWithRequirementsThatRaiseError selector: #testRequiresErrorTest.
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
	case := BoTestWithRequirementsThatAreExpectedFailure selector: #testRequiresExpectedFailure.
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
BoRequirementTest >> testRequirementFailureIfRequirementsIsFailure [
	| case result |
	case := BoTestWithRequirementsThatFail  selector: #testRequiresFailingTest.
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
BoRequirementTest >> testRequirementFailureIfRequiresTestWithFailingRequirement [
	| case result |
	case := BoTestWithHierarchyOfRequirementWithFailingRoot selector: #testRequiresTestWithFailingRequirement.
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
BoRequirementTest >> testSuiteWithErrorInRequirement [
	| suite result |
	suite := BoTestWithRequirementsThatRaiseError suite.
	result := suite run.
	self
		assertForTestResult: result
		runCount: 3 "The required test is counted only once"
		passed: 0
		failed: 0
		errors: 1
		expectedFailures: 0
		requirementFailures: 2
]

{ #category : #testing }
BoRequirementTest >> testSuiteWithExpectedFailureInRequirement [
	| suite result |
	suite := BoTestWithRequirementsThatAreExpectedFailure suite.
	result := suite run.
	self
		assertForTestResult: result
		runCount: 3 "The required test is counted only once"
		passed: 0
		failed: 0
		errors: 0
		expectedFailures: 1
		requirementFailures: 2 
]

{ #category : #testing }
BoRequirementTest >> testSuiteWithFailureInRequirement [
	| suite result |
	suite := BoTestWithRequirementsThatFail suite.
	result := suite run.
	self
		assertForTestResult: result
		runCount: 3 "The required test is counted only once"
		passed: 0
		failed: 1
		errors: 0
		expectedFailures: 0
		requirementFailures: 2 
]

{ #category : #testing }
BoRequirementTest >> testSuiteWithPassingRequirement [
	| suite result |
	suite := BoTestWithRequirementsThatPass suite.
	result := suite run.
	self
		assertForTestResult: result
		runCount: 3 "The required test is counted only once"
		passed: 3
		failed: 0
		errors: 0
		expectedFailures: 0
		requirementFailures: 0
]
