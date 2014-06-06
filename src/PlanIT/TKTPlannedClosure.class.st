Class {
	#name : #TKTPlannedClosure,
	#superclass : #TKTPlannedUnit,
	#instVars : [
		'arguments'
	],
	#category : #PlanIT
}

{ #category : #reflection }
TKTPlannedClosure >> arguments [
	^ arguments ifNil: [ 
		arguments := unit decompile arguments.
	 ].
	
]

{ #category : #reflection }
TKTPlannedClosure >> reduce [ 
	^ unit value.
]

{ #category : #reflection }
TKTPlannedClosure >> reduce: anArray [
 | args |
	args := anArray isString ifTrue: [ {anArray} ] ifFalse: [ 
		anArray asArguments .
	]. 
	^ unit  valueWithEnoughArguments: args . 
]

{ #category : #accessing }
TKTPlannedClosure >> unit: aUnitToPlan [
	super unit: aUnitToPlan.
	arguments := nil.
]
