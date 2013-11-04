Class {
	#name : #TKTPlannedUnitSchedduler,
	#superclass : #TKTPlannedUnitRunner,
	#category : #'TaskIT-Tasks-Plan'
}

{ #category : #'as yet unclassified' }
TKTPlannedUnitSchedduler >> reduce [
	^ plannedUnit task taskIt.
]

{ #category : #'as yet unclassified' }
TKTPlannedUnitSchedduler >> reduceWithArguments: anArray [
	^ plannedUnit task taskItWithArguments: anArray.

]
