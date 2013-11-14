Class {
	#name : #TKTPlannedUnitRunner,
	#superclass : #Object,
	#category : #'TaskIT-Tasks-Plan'
}

{ #category : #executing }
TKTPlannedUnitRunner >> reduce: aUnit [
	self subclassResponsibility .
]

{ #category : #executing }
TKTPlannedUnitRunner >> reduce: aUnit with: anArray [
	self subclassResponsibility .
]
