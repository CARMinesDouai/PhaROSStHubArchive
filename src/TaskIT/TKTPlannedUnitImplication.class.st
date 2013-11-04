Class {
	#name : #TKTPlannedUnitImplication,
	#superclass : #Object,
	#instVars : [
		'antecedent',
		'consequent'
	],
	#category : #'TaskIT-Tasks-Plan'
}

{ #category : #'as yet unclassified' }
TKTPlannedUnitImplication >> accept: aPlanVisitor [
	aPlanVisitor acceptImplication: self.
]

{ #category : #'as yet unclassified' }
TKTPlannedUnitImplication >> antecedent [
	^ antecedent
]

{ #category : #'as yet unclassified' }
TKTPlannedUnitImplication >> antecedent: aPlannedUnit [
	antecedent := aPlannedUnit
]

{ #category : #'as yet unclassified' }
TKTPlannedUnitImplication >> consequent [
	^ consequent
]

{ #category : #'as yet unclassified' }
TKTPlannedUnitImplication >> consequent: aPlannedUnit [
	consequent := aPlannedUnit.
]
