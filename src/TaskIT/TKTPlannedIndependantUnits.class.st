Class {
	#name : #TKTPlannedIndependantUnits,
	#superclass : #TKTPlannedCollection,
	#category : #'TaskIT-Tasks-Plan'
}

{ #category : #reducer }
TKTPlannedIndependantUnits >> & aPlannableUnit [ 
	self addPlanned:  aPlannableUnit asPlanned.
	^ self.
]

{ #category : #reducer }
TKTPlannedIndependantUnits >> accept: aPlanVisitor [
	aPlanVisitor acceptIndependantUnits: self.

]

{ #category : #reducer }
TKTPlannedIndependantUnits >> reduce [
	^ unit collect:[ : p |  p  paralellize reduce ].
]

{ #category : #reducer }
TKTPlannedIndependantUnits >> reduce: anArray [
 | args |
	args := anArray isString ifTrue: [ {anArray} ] ifFalse: [ anArray asArray ]. 
	^ unit collect:[ : p | p  paralellize reduce: args  ].
]
