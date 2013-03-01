Class {
	#name : #BoRequirementTest,
	#superclass : #BoTestCase,
	#category : #'BoTest-Kernel-Test'
}

{ #category : #testing }
BoRequirementTest >> errorAllTheTime [
	self error: 'Boum!'
]

{ #category : #testing }
BoRequirementTest >> failsAllTheTime [
	self fail
]

{ #category : #testing }
BoRequirementTest >> testExpectedFailure [
	<expectedFailure> 
	self fail
]

{ #category : #testing }
BoRequirementTest >> testRequiresErrorTest [
	self requires: #errorAllTheTime
]

{ #category : #testing }
BoRequirementTest >> testRequiresExpectedFailure [
	self requires: #testExpectedFailure

]

{ #category : #testing }
BoRequirementTest >> testRequiresFailingTest [
	self requires: #failsAllTheTime
]

{ #category : #testing }
BoRequirementTest >> testRequiresPassingTest [
	self requires: #testThatPassesAllTheTime.

	
]

{ #category : #testing }
BoRequirementTest >> testRequiresWarningTest [
	self requires: #warningAllTheTime
]

{ #category : #testing }
BoRequirementTest >> testThatPassesAllTheTime [
	self assert: true
]

{ #category : #testing }
BoRequirementTest >> warningAllTheTime [
	self notify: 'Alert!'
]
