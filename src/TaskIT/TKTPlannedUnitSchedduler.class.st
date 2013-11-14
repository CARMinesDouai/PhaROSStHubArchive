Class {
	#name : #TKTPlannedUnitSchedduler,
	#superclass : #TKTPlannedUnitRunner,
	#category : #'TaskIT-Tasks-Plan'
}

{ #category : #'as yet unclassified' }
TKTPlannedUnitSchedduler >> reduce: aUnit [
	^ aUnit scheddule reduce.
]

{ #category : #'as yet unclassified' }
TKTPlannedUnitSchedduler >> reduce: aUnit with: anArray [
	^ aUnit scheddule reduce: anArray.
]
