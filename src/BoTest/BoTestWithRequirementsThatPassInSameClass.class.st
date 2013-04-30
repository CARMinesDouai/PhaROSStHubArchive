Class {
	#name : #BoTestWithRequirementsThatPassInSameClass,
	#superclass : #BoTestCase,
	#category : #'BoTest-Kernel-ExamplesForTest'
}

{ #category : #tests }
BoTestWithRequirementsThatPassInSameClass >> testRequiresPassingTest [
	self requires: BoTestWithRequirementsThatPass 
	

]
