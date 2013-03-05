Class {
	#name : #BoTestWithRequirementsThatPass,
	#superclass : #BoTestCase,
	#category : #'BoTest-Kernel-ExamplesForTest'
}

{ #category : #testing }
BoTestWithRequirementsThatPass >> testPassesAllTheTime [
	BoCounterForTest current increment.
	self assert: true
]

{ #category : #testing }
BoTestWithRequirementsThatPass >> testRequiresPassingTest [
	self requires: #testPassesAllTheTime

]
