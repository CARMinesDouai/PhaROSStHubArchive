Class {
	#name : #BoTestWithRequirementsThatAreExpectedFailure,
	#superclass : #BoTestCase,
	#category : #'BoTest-Kernel-ExamplesForTest'
}

{ #category : #testing }
BoTestWithRequirementsThatAreExpectedFailure >> testExpectedFailure [
	<expectedFailure> 
	BoCounterForTest current increment.
	self fail
]

{ #category : #testing }
BoTestWithRequirementsThatAreExpectedFailure >> testRequiresExpectedFailure [
	self requires: #testExpectedFailure

]
