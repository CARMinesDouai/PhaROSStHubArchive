Class {
	#name : #TKTPlannedInterDependantUnits,
	#superclass : #TKTPlannedUnit,
	#instVars : [
		'otherUnit'
	],
	#category : #'TaskIT-Tasks-Plan'
}

{ #category : #'as yet unclassified' }
TKTPlannedInterDependantUnits >> accept: aPlanVisitor [
	aPlanVisitor acceptInterDependantUnits: self.
	
]

{ #category : #'as yet unclassified' }
TKTPlannedInterDependantUnits >> first [
	^unit
]

{ #category : #'as yet unclassified' }
TKTPlannedInterDependantUnits >> second [ 
	^otherUnit 
]
