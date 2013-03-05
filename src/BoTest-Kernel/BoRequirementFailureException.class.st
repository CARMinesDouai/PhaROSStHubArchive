Class {
	#name : #BoRequirementFailureException,
	#superclass : #Error,
	#category : #'BoTest-Kernel'
}

{ #category : #'as yet unclassified' }
BoRequirementFailureException >> sunitAnnounce: aTestCase toResult: aTestResult [
	aTestResult addRequirementFailure: aTestCase.
	self sunitExitWith: false.
]
