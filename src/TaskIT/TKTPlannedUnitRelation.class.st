Class {
	#name : #TKTPlannedUnitRelation,
	#superclass : #Object,
	#instVars : [
		'object'
	],
	#category : #'TaskIT-Tasks-Plan'
}

{ #category : #'as yet unclassified' }
TKTPlannedUnitRelation >> accept: aPlanVisitor [
	aPlanVisitor acceptImplication: self.
]

{ #category : #'as yet unclassified' }
TKTPlannedUnitRelation >> isSequenceable [
	^false.
]

{ #category : #'as yet unclassified' }
TKTPlannedUnitRelation >> object [
	^ object
]

{ #category : #'as yet unclassified' }
TKTPlannedUnitRelation >> object: aPlannedUnit [
	object := aPlannedUnit
]
