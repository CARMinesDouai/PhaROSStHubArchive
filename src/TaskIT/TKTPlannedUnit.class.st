Class {
	#name : #TKTPlannedUnit,
	#superclass : #Object,
	#instVars : [
		'relations',
		'unit'
	],
	#category : #'TaskIT-Tasks-Plan'
}

{ #category : #'as yet unclassified' }
TKTPlannedUnit class >> of: aUnitToPlan [
	^ self new unit: aUnitToPlan ; yourself
]

{ #category : #operator }
TKTPlannedUnit >> => aPlannableUnit [ 
	| planned |
	planned := aPlannableUnit asPlanned.
	relations add: (TKTSequence of: planned with: self ).
	^ planned.
]

{ #category : #operator }
TKTPlannedUnit >> accept: aPlanVisitor [
	aPlanVisitor acceptUnit: self. 
	relations do: [  : r| r accept: aPlanVisitor ].
]

{ #category : #reflection }
TKTPlannedUnit >> arguments [
	self subclassResponsibility 
	
]

{ #category : #operator }
TKTPlannedUnit >> initialize [
	super initialize.
	relations := Set new.
]

{ #category : #operator }
TKTPlannedUnit >> isSimple [
	^ true.
]

{ #category : #reflection }
TKTPlannedUnit >> reduce [
	self subclassResponsibility.
]

{ #category : #accessing }
TKTPlannedUnit >> task [
	^ unit
]

{ #category : #operator }
TKTPlannedUnit >> unit: aUnitToPlan [
	unit := aUnitToPlan.
]
