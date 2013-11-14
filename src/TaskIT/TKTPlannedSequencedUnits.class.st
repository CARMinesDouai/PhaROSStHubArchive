Class {
	#name : #TKTPlannedSequencedUnits,
	#superclass : #TKTPlannedCollection,
	#category : #'TaskIT-Tasks-Plan'
}

{ #category : #'as yet unclassified' }
TKTPlannedSequencedUnits >> => aPlannableUnit [ 
	self addPlanned:  aPlannableUnit asPlanned.
	^ self.
]

{ #category : #'as yet unclassified' }
TKTPlannedSequencedUnits >> accept: aPlanVisitor [
	aPlanVisitor acceptSequencedUnits: self.
	
]
