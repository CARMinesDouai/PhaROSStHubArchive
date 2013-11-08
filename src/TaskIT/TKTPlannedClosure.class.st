Class {
	#name : #TKTPlannedClosure,
	#superclass : #TKTPlannedUnit,
	#instVars : [
		'arguments'
	],
	#category : #'TaskIT-Tasks-Plan'
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
	^ unit  valueWithEnoughArguments: anArray. 
]

{ #category : #accessing }
TKTPlannedClosure >> unit: aUnitToPlan [
	super unit: aUnitToPlan.
	arguments := nil.
]
