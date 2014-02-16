Class {
	#name : #TKTTaskOneShotThirdImageRunnerUnreferencedStickReferenceDeployedFutureTests,
	#superclass : #TKTTaskAbstractOneShotThirdImageRunner,
	#category : #'TaskITFork-Test'
}

{ #category : #'as yet unclassified' }
TKTTaskOneShotThirdImageRunnerUnreferencedStickReferenceDeployedFutureTests >> setUp [

	super setUp.
	future := (runner run: [ 2 ] asTask) asStickyReference.
	result := future value.
	future := nil. 
	5 timesRepeat: [ Smalltalk garbageCollect ].
]

{ #category : #'as yet unclassified' }
TKTTaskOneShotThirdImageRunnerUnreferencedStickReferenceDeployedFutureTests >> testFutureHasExpectedResult [
	self assert: result = 2.
]

{ #category : #'as yet unclassified' }
TKTTaskOneShotThirdImageRunnerUnreferencedStickReferenceDeployedFutureTests >> testFutureHasNotBeenCancelled [
	self deny: runner workingFuture  isCancelled.
]

{ #category : #'as yet unclassified' }
TKTTaskOneShotThirdImageRunnerUnreferencedStickReferenceDeployedFutureTests >> testFutureIsNotError [
	self deny: runner workingFuture isError.
]

{ #category : #'as yet unclassified' }
TKTTaskOneShotThirdImageRunnerUnreferencedStickReferenceDeployedFutureTests >> testProcessHasFinished [

	self assert: runner isTerminated 
]
