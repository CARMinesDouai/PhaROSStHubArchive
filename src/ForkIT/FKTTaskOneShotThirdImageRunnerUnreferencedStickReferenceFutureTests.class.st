Class {
	#name : #FKTTaskOneShotThirdImageRunnerUnreferencedStickReferenceFutureTests,
	#superclass : #FKTTaskAbstractOneShotThirdImageRunner,
	#category : #'ForkIT-Test'
}

{ #category : #'as yet unclassified' }
FKTTaskOneShotThirdImageRunnerUnreferencedStickReferenceFutureTests >> setUp [

	super setUp.
	future := (runner run: [ (Delay forMilliseconds: 1000) wait ] asTKTJob) asStickyReference.
	future := nil.
	10 timesRepeat: [ Smalltalk garbageCollect ].
]

{ #category : #'as yet unclassified' }
FKTTaskOneShotThirdImageRunnerUnreferencedStickReferenceFutureTests >> testFutureHasBeenCancelled [
	self assert: runner workingFuture  isCancelled.
]

{ #category : #'as yet unclassified' }
FKTTaskOneShotThirdImageRunnerUnreferencedStickReferenceFutureTests >> testFutureIsNotError [
	self deny: runner workingFuture isError.
]

{ #category : #'as yet unclassified' }
FKTTaskOneShotThirdImageRunnerUnreferencedStickReferenceFutureTests >> testProcessHasFinished [
	3 seconds asDelay wait.
	self assert: runner isTerminated 
]
