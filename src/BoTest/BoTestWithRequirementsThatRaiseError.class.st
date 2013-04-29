Class {
	#name : #BoTestWithRequirementsThatRaiseError,
	#superclass : #BoTestCase,
	#category : #'BoTest-Kernel-ExamplesForTest'
}

{ #category : #testing }
BoTestWithRequirementsThatRaiseError >> testErrorAllTheTime [
	BoCounterForTest current increment.
	self error: 'Boum!'
]

{ #category : #testing }
BoTestWithRequirementsThatRaiseError >> testRequiresErrorTest [
	self requires: #testErrorAllTheTime
]

{ #category : #testing }
BoTestWithRequirementsThatRaiseError >> testRequiresErrorTest2 [
	self requires: #testErrorAllTheTime
]
