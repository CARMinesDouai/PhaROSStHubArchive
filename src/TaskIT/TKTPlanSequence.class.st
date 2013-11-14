Class {
	#name : #TKTPlanSequence,
	#superclass : #TKTPlanSequencerLayer,
	#instVars : [
		'partial'
	],
	#category : #'TaskIT-Tasks-Plan'
}

{ #category : #'as yet unclassified' }
TKTPlanSequence >> end [	
	" Ok, the meaning of this is. Once we have all the sequence that will be executed in sequence, we make a planned closure that execute all the tasks in the same runner - reduce asking. (the runner will define if it is in this thead, other thread or a worker.
	Because a yet lack of design, we cannot treat polimorphicly the results from a regular planned task with the planned tasks made by this sequencer, the tasks made by the sequencer have information about how to use the result if we want to useit as parameter in a new calling.
	 "
	
	previousSequencer sequence: [ 
		: previousResult | 
		| args |
		args := previousResult ifNil:[ {  } ] ifNotNil:[ previousResult asArguments].
		
		TKTPlanResult for: (runner reduce: [
			(partial allButFirst inject: (partial first reduce: args ) into: [ 
				: acc : planned | 
				| rslt |
				rslt := (acc isKindOf:TKTPlanResult) ifTrue: [
					planned reduce: {acc}
				] ifFalse: [ 
					planned reduce: { acc }
				].
				TKTPlanResult for: rslt.
			]) result.
		 ] asPlanned).
	 ] asPlanned.

	^super end. 
]

{ #category : #'as yet unclassified' }
TKTPlanSequence >> initialize [ 	
	super initialize .
	partial := OrderedCollection new.
]

{ #category : #'as yet unclassified' }
TKTPlanSequence >> sequence: aPlanned [

	partial add: aPlanned.
	

]
