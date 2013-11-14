Class {
	#name : #TKTPlannedUnit,
	#superclass : #Object,
	#instVars : [
		'parent',
		'unit'
	],
	#category : #'TaskIT-Tasks-Plan'
}

{ #category : #'as yet unclassified' }
TKTPlannedUnit class >> of: aUnitToPlan [
	^ self new unit: aUnitToPlan ; yourself
]

{ #category : #operator }
TKTPlannedUnit >> & aPlannableUnit [ 
	| planned target |
	target := parent .
	planned := TKTPlannedIndependantUnits of: self.
	planned & aPlannableUnit.
	
	target ifNotNil: [
		target replace: self by: planned.
	].
	^ planned.
]

{ #category : #operator }
TKTPlannedUnit >> => aPlannableUnit [ 
	| planned target |
	target := parent .
	planned := TKTPlannedSequencedUnits of: self  .
	planned => aPlannableUnit.
	
	target ifNotNil: [
		target replace: self by: planned.
	].
	^ planned.
	
]

{ #category : #operator }
TKTPlannedUnit >> accept: aPlanVisitor [
	aPlanVisitor acceptUnit: self. 
	
]

{ #category : #reflection }
TKTPlannedUnit >> arguments [
	self subclassResponsibility 
	
]

{ #category : #operator }
TKTPlannedUnit >> asPlanned [
	^ self 
]

{ #category : #operator }
TKTPlannedUnit >> isSimple [
	^ true.
]

{ #category : #operator }
TKTPlannedUnit >> parent: aPlanOrPlanned [
	^ parent := aPlanOrPlanned
]

{ #category : #operator }
TKTPlannedUnit >> printOn: aStream [
	'UNIT:' printOn: aStream.
	unit printOn: aStream.
]

{ #category : #reflection }
TKTPlannedUnit >> reduce [
	self subclassResponsibility.
]

{ #category : #accessing }
TKTPlannedUnit >> reduce: anArrayOfArgs [
	self subclassResponsibility 
	
]

{ #category : #accessing }
TKTPlannedUnit >> task [
	^ unit
]

{ #category : #operator }
TKTPlannedUnit >> unit: aUnitToPlan [
	unit := aUnitToPlan.
]
