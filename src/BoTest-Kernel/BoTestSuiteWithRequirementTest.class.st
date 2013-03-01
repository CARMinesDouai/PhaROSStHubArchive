Class {
	#name : #BoTestSuiteWithRequirementTest,
	#superclass : #SUnitTest,
	#category : #'BoTest-Kernel-Test'
}

{ #category : #testing }
BoTestSuiteWithRequirementTest >> testSuiteOfTestsWithPassingRequirement [
	| suite result |
	suite := BoPassingRequirementsForSingleExecutionTest suite.
	result := suite run.
	self
		assertForTestResult: result
		runCount: 2 "The required test is counted only once"
		passed: 2 
		failed: 0 
		errors: 0
		expectedFailures: 0
]
