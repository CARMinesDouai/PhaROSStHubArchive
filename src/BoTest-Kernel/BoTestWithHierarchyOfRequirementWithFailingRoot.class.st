Class {
	#name : #BoTestWithHierarchyOfRequirementWithFailingRoot,
	#superclass : #BoTestCase,
	#category : #'BoTest-Kernel-ExamplesForTest'
}

{ #category : #test }
BoTestWithHierarchyOfRequirementWithFailingRoot >> testFailsAllTheTime [
	BoCounterForTest current increment.
	self fail
]

{ #category : #test }
BoTestWithHierarchyOfRequirementWithFailingRoot >> testRequiresFailingTest [
	self requires: #testFailsAllTheTime
]

{ #category : #test }
BoTestWithHierarchyOfRequirementWithFailingRoot >> testRequiresTestWithFailingRequirement [
	self requires: #testRequiresFailingTest
]
