Class {
	#name : #TKTPlanIndependant,
	#superclass : #TKTPlanSequencerLayer,
	#instVars : [
		'partial'
	],
	#category : #PlanIT
}

{ #category : #'as yet unclassified' }
TKTPlanIndependant >> end [ 	
	
	previousSequencer sequence: [ 
		: previousResults |
		| args |
		args := previousResults ifNil:[ {  } ] ifNotNil:[ previousResults asArguments ].
		(TKTPlanResult for:(partial collect: [ :aPlanned | (runner reduce: aPlanned with: args). ])) 
					    setAsArguments; 
					    yourself.
	 ] asPlanned.
	
	
	^ super end.
]

{ #category : #'as yet unclassified' }
TKTPlanIndependant >> initialize [ 	
	super initialize.
	partial := OrderedCollection new.
]

{ #category : #'as yet unclassified' }
TKTPlanIndependant >> sequence: aPlanned [ 	
	
	partial add: aPlanned.
]
