Class {
	#name : #BoTestWithRequirements,
	#superclass : #BoTestCase,
	#category : #'BoTest-Kernel-Test'
}

{ #category : #testing }
BoTestWithRequirements >> errorAllTheTime [
	self error: 'Boum!'
]

{ #category : #testing }
BoTestWithRequirements >> failsAllTheTime [
	self fail
]

{ #category : #testing }
BoTestWithRequirements >> testExpectedFailure [
	<expectedFailure> 
	self fail
]

{ #category : #testing }
BoTestWithRequirements >> testRequiresErrorTest [
	self requires: #errorAllTheTime
]

{ #category : #testing }
BoTestWithRequirements >> testRequiresExpectedFailure [
	self requires: #testExpectedFailure

]

{ #category : #testing }
BoTestWithRequirements >> testRequiresFailingTest [
	self requires: #failsAllTheTime
]

{ #category : #testing }
BoTestWithRequirements >> testRequiresPassingTest [
	self requires: #testThatPassesAllTheTime.

	
]

{ #category : #testing }
BoTestWithRequirements >> testRequiresWarningTest [
	self requires: #warningAllTheTime
]

{ #category : #testing }
BoTestWithRequirements >> testThatPassesAllTheTime [
	self assert: true
]

{ #category : #testing }
BoTestWithRequirements >> warningAllTheTime [
	self notify: 'Alert!'
]
