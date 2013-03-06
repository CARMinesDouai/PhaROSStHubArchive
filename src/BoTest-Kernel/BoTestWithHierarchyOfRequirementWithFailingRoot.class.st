Class {
	#name : #BoTestWithHierarchyOfRequirementWithFailingRoot,
	#superclass : #BoTestCase,
	#category : #'BoTest-Kernel-ExamplesForTest'
}

{ #category : #test }
BoTestWithHierarchyOfRequirementWithFailingRoot >> test1RequiresTest2WithFailingRequirement [
	self requires: #test2RequiresFailingTest
]

{ #category : #test }
BoTestWithHierarchyOfRequirementWithFailingRoot >> test2RequiresFailingTest [
	self requires: #testFailsAllTheTime
]

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
