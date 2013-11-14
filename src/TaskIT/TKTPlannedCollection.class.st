Class {
	#name : #TKTPlannedCollection,
	#superclass : #TKTPlannedUnit,
	#category : #'TaskIT-Tasks-Plan'
}

{ #category : #'as yet unclassified' }
TKTPlannedCollection class >> of: aPlanned [
	^ self new addPlanned: aPlanned; yourself.
]

{ #category : #reducer }
TKTPlannedCollection >> accept: aPlanVisitor [
	aPlanVisitor acceptCollection: self.
	
]

{ #category : #'as yet unclassified' }
TKTPlannedCollection >> addPlanned: aPlanned [ 
	unit add: aPlanned.
	aPlanned parent: self .
	^ aPlanned.
]

{ #category : #'as yet unclassified' }
TKTPlannedCollection >> initialize [ 	
	super initialize.
	unit := OrderedCollection new.
]

{ #category : #reducer }
TKTPlannedCollection >> replace: aPlanned by: otherPlanned [
	unit at: (unit indexOf: aPlanned) put: otherPlanned.

]

{ #category : #reducer }
TKTPlannedCollection >> units [
	^ unit
]
