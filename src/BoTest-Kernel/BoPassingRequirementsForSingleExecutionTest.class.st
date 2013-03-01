Class {
	#name : #BoPassingRequirementsForSingleExecutionTest,
	#superclass : #BoTestCase,
	#category : #'BoTest-Kernel-Test'
}

{ #category : #accessing }
BoPassingRequirementsForSingleExecutionTest class >> resources [ 
	^super resources, {BoCounterResourceForTest}
]

{ #category : #testing }
BoPassingRequirementsForSingleExecutionTest >> testPassOnFirstExecution [
	BoCounterResourceForTest current increment.
	self assert: BoCounterResourceForTest current count = 1
]

{ #category : #testing }
BoPassingRequirementsForSingleExecutionTest >> testWhichPassingRequirementsAreExecutedOnlyOnce [
	self require: #testPassOnFirstExecution.
	self assert: BoCounterResourceForTest current count = 1
]
