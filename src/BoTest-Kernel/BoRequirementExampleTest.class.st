Class {
	#name : #BoRequirementExampleTest,
	#superclass : #BoTestCase,
	#category : #'BoTest-Kernel-Test'
}

{ #category : #testing }
BoRequirementExampleTest >> errorAllTheTime [
	self error: 'Boum!'
]

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
BoRequirementExampleTest >> testRequiresErrorTest [
	self require: #errorAllTheTime
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
BoRequirementExampleTest >> testRequiresWarningTest [
	self require: #warningAllTheTime
]

{ #category : #testing }
BoRequirementExampleTest >> testThatPassesAllTheTime [
	self assert: true
]

{ #category : #testing }
BoRequirementExampleTest >> warningAllTheTime [
	self notify: 'Alert!'
]
