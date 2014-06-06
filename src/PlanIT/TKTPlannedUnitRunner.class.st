Class {
	#name : #TKTPlannedUnitRunner,
	#superclass : #Object,
	#category : #PlanIT
}

{ #category : #executing }
TKTPlannedUnitRunner >> reduce: aUnit [
	self subclassResponsibility .
]

{ #category : #executing }
TKTPlannedUnitRunner >> reduce: aUnit with: anArray [
	self subclassResponsibility .
]
