Class {
	#name : #BoRequirementArePerformedOnlyOnceTest,
	#superclass : #BoTestCaseTest,
	#category : #'BoTest-Kernel-Test'
}

{ #category : #testing }
BoRequirementArePerformedOnlyOnceTest >> assertRequirementsExecutedOnlyOnceIn: testCaseClass [
	| suite |
	suite := testCaseClass suite.
	suite run.
	"We assume that the counter is only incremented in a single test that is required by others"
	self assert: 	BoCounterForTest current count = 1
]

{ #category : #testing }
BoRequirementArePerformedOnlyOnceTest >> setUp [
	super setUp.
	BoCounterForTest reset.
]

{ #category : #testing }
BoRequirementArePerformedOnlyOnceTest >> testSuiteWithErrorInRequirement [
	self assertRequirementsExecutedOnlyOnceIn: BoTestWithRequirementsThatRaiseError
]

{ #category : #testing }
BoRequirementArePerformedOnlyOnceTest >> testSuiteWithExpectedFailureInRequirement [
	self assertRequirementsExecutedOnlyOnceIn: BoTestWithRequirementsThatAreExpectedFailure
]

{ #category : #testing }
BoRequirementArePerformedOnlyOnceTest >> testSuiteWithFailureInRequirement [
	self assertRequirementsExecutedOnlyOnceIn:  BoTestWithRequirementsThatFail
]

{ #category : #testing }
BoRequirementArePerformedOnlyOnceTest >> testSuiteWithPassingRequirement [
	self assertRequirementsExecutedOnlyOnceIn:  BoTestWithRequirementsThatPass
]

{ #category : #testing }
BoRequirementArePerformedOnlyOnceTest >> testSuiteWithRequirementHierarchy [
	self assertRequirementsExecutedOnlyOnceIn: BoTestWithHierarchyOfRequirementWithFailingRoot
]
