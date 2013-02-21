Class {
	#name : #BoFailedRequiredTestPerformedOnlyOnce,
	#superclass : #BoTestCase,
	#category : #'BoTest-Kernel-Test'
}

{ #category : #testing }
BoFailedRequiredTestPerformedOnlyOnce >> testFailsAllTheTime [
	| resource |
	resource := BoCounterTestResource current .
	resource counter: resource counter + 1.
	self fail
]

{ #category : #testing }
BoFailedRequiredTestPerformedOnlyOnce >> testRequiresFailingTest [
	self require: #testFailsAllTheTime
]
