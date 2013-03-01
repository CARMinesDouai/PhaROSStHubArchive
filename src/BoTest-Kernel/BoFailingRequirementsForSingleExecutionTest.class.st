Class {
	#name : #BoFailingRequirementsForSingleExecutionTest,
	#superclass : #BoTestCase,
	#category : #'BoTest-Kernel-Test'
}

{ #category : #accessing }
BoFailingRequirementsForSingleExecutionTest class >> resources [ 
	^super resources, {BoCounterResourceForTest}
]

{ #category : #testing }
BoFailingRequirementsForSingleExecutionTest >> testFailsAllTheTime [
	<expectedFailure>
	BoCounterResourceForTest current increment.
	self fail
]

{ #category : #testing }
BoFailingRequirementsForSingleExecutionTest >> testWhichFailingRequirementsAreExecutedOnlyOnce [
	self require: #testFailsAllTheTime.
	self assert: BoCounterResourceForTest current count = 1
]
