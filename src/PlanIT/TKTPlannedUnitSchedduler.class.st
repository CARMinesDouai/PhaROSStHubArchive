Class {
	#name : #TKTPlannedUnitSchedduler,
	#superclass : #TKTPlannedUnitRunner,
	#category : #PlanIT
}

{ #category : #'as yet unclassified' }
TKTPlannedUnitSchedduler >> reduce: aUnit [
	^ aUnit schedule reduce.
]

{ #category : #'as yet unclassified' }
TKTPlannedUnitSchedduler >> reduce: aUnit with: anArray [
	^ aUnit schedule reduce: anArray.
]
