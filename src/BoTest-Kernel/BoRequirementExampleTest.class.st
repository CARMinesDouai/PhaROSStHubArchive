Class {
	#name : #BoRequirementExampleTest,
	#superclass : #BoTestCase,
	#category : #'BoTest-Kernel-Test'
}

{ #category : #testing }
BoRequirementExampleTest >> failsAllTheTime [
	self fail
]

{ #category : #testing }
BoRequirementExampleTest >> testExpectedFailure [
	<expectedFailure>
	self fail
]

{ #category : #testing }
BoRequirementExampleTest >> testRequiresExpectedFailure [
	self require: #testExpectedFailure
]

{ #category : #testing }
BoRequirementExampleTest >> testRequiresFailingTest [
	self require: #failsAllTheTime
]

{ #category : #testing }
BoRequirementExampleTest >> testRequiresPassingTest [
	self require: #testThatPassesAllTheTime.

	
]

{ #category : #testing }
BoRequirementExampleTest >> testThatPassesAllTheTime [
	self assert: true
]
