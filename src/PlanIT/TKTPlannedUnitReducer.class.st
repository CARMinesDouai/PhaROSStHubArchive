Class {
	#name : #TKTPlannedUnitReducer,
	#superclass : #TKTPlannedUnitRunner,
	#category : #PlanIT
}

{ #category : #'as yet unclassified' }
TKTPlannedUnitReducer >> reduce: aUnit [
	^ aUnit  reduce.
]

{ #category : #'as yet unclassified' }
TKTPlannedUnitReducer >> reduce: aUnit with: anArray [
	^ aUnit  reduce: anArray.
]
