Class {
	#name : #BoRequirementFailureException,
	#superclass : #Error,
	#category : #'BoTest-Kernel'
}

{ #category : #'as yet unclassified' }
BoRequirementFailureException >> sunitAnnounce: aTestCase toResult: aTestResult [
	aTestResult addTestWithFailingRequirement: aTestCase.
	self sunitExitWith: false.
]
