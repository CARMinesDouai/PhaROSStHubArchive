Class {
	#name : #TKTPlannedUnitParalellizer,
	#superclass : #TKTPlannedUnitRunner,
	#category : #'TaskIT-Tasks-Plan'
}

{ #category : #'as yet unclassified' }
TKTPlannedUnitParalellizer >> reduce [
	plannedUnit task doIt.
]

{ #category : #'as yet unclassified' }
TKTPlannedUnitParalellizer >> reduceWithArguments: anArray [
	plannedUnit task doItWithArguments: anArray.
]
