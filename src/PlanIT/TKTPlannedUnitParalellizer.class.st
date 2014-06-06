Class {
	#name : #TKTPlannedUnitParalellizer,
	#superclass : #TKTPlannedUnitRunner,
	#category : #PlanIT
}

{ #category : #'as yet unclassified' }
TKTPlannedUnitParalellizer >> reduce: aUnit [
	^ aUnit paralellize reduce.
]

{ #category : #'as yet unclassified' }
TKTPlannedUnitParalellizer >> reduce: aUnit with: anArray [
	^ aUnit paralellize reduce: anArray.
]
