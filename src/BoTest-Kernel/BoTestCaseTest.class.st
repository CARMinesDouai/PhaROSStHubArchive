Class {
	#name : #BoTestCaseTest,
	#superclass : #TestCase,
	#category : #'BoTest-Kernel-Test'
}

{ #category : #testing }
BoTestCaseTest >> assertForTestResult: aResult runCount: aRunCount passed: aPassedCount failed: aFailureCount errors: anErrorCount expectedFailures: anExpectedFailureCount requirementFailures: expectedRequirementFailuresCount [

	self
		assert: aResult runCount = aRunCount;
		assert: aResult expectedPassCount = aPassedCount;
		assert: aResult failureCount = aFailureCount;
		assert: aResult errorCount = anErrorCount;
		assert: aResult expectedDefectCount = anExpectedFailureCount;
		assert: aResult requirementFailuresCount = expectedRequirementFailuresCount
]
