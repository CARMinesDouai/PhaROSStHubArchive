Class {
	#name : #BoTestWithRequirementsThatFail,
	#superclass : #BoTestCase,
	#category : #'BoTest-Kernel-ExamplesForTest'
}

{ #category : #testing }
BoTestWithRequirementsThatFail >> testFailsAllTheTime [
	BoCounterForTest current increment.
	self fail
]

{ #category : #testing }
BoTestWithRequirementsThatFail >> testRequiresFailingTest [
	self requires: #testFailsAllTheTime
]
