Class {
	#name : #TKTPlannedUnitRunner,
	#superclass : #Object,
	#instVars : [
		'plannedUnit'
	],
	#category : #'TaskIT-Tasks-Plan'
}

{ #category : #accessing }
TKTPlannedUnitRunner >> plannedUnit: aPlannedUnit [
	plannedUnit := aPlannedUnit 
]

{ #category : #executing }
TKTPlannedUnitRunner >> reduce [
	self subclassResponsibility .
]

{ #category : #executing }
TKTPlannedUnitRunner >> reduceWithArguments: anArray [
	self subclassResponsibility .
]
