Class {
	#name : #FKTTaskOneShotThirdImageRunnerUnreferencedStickReferenceDeployedFutureTests,
	#superclass : #FKTTaskAbstractOneShotThirdImageRunner,
	#category : #'ForkIT-Test'
}

{ #category : #'as yet unclassified' }
FKTTaskOneShotThirdImageRunnerUnreferencedStickReferenceDeployedFutureTests >> setUp [

	super setUp.
	future := (runner run: [ 2 ] asTKTJob) asStickyReference.
	result := future value.
	future := nil. 
	5 timesRepeat: [ Smalltalk garbageCollect ].
]

{ #category : #'as yet unclassified' }
FKTTaskOneShotThirdImageRunnerUnreferencedStickReferenceDeployedFutureTests >> testFutureHasExpectedResult [
	self assert: result = 2.
]

{ #category : #'as yet unclassified' }
FKTTaskOneShotThirdImageRunnerUnreferencedStickReferenceDeployedFutureTests >> testFutureHasNotBeenCancelled [
	self deny: runner workingFuture  isCancelled.
]

{ #category : #'as yet unclassified' }
FKTTaskOneShotThirdImageRunnerUnreferencedStickReferenceDeployedFutureTests >> testFutureIsNotError [
	self deny: runner workingFuture isError.
]

{ #category : #'as yet unclassified' }
FKTTaskOneShotThirdImageRunnerUnreferencedStickReferenceDeployedFutureTests >> testProcessHasFinished [

	self assert: runner isTerminated 
]
