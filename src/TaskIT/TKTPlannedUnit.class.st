Class {
	#name : #TKTPlannedUnit,
	#superclass : #Object,
	#instVars : [
		'parent',
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
TKTPlannedUnit >> & aPlannableUnit [ 
	| planned target |
	target := parent .
	planned := self  asPlannedCollection.
	planned & aPlannableUnit.
	
	target ifNotNil: [
		target replace: self by: planned.
	].
	^ planned.
]

{ #category : #operator }
TKTPlannedUnit >> => aPlannableUnit [ 
	| planned |
	planned := aPlannableUnit asPlanned.
	planned parent: self.
	self lastInTheSequence addSequenceable: planned.
	^ self.
]

{ #category : #operator }
TKTPlannedUnit >> accept: aPlanVisitor [
	aPlanVisitor acceptUnit: self. 
	relations do: [  : r| r accept: aPlanVisitor ].
]

{ #category : #operator }
TKTPlannedUnit >> addSequenceable: aPlanned [
	relations detect: #isSequenceable ifNone: [ 
		^ relations add: (TKTDependance of: aPlanned  )
	].
	self error: 'You should send => to add sequenceables. This unit has already a "next job to d" '. 
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
TKTPlannedUnit >> asPlannedCollection [
	^ TKTPlannedCollection new addPlanned: self ; yourself.
]

{ #category : #operator }
TKTPlannedUnit >> initialize [
	super initialize.
	relations := OrderedCollection new.
]

{ #category : #operator }
TKTPlannedUnit >> isSimple [
	^ true.
]

{ #category : #operator }
TKTPlannedUnit >> lastInTheSequence [
	^ self nextOrNil ifNotNil: [ : next | next lastInTheSequence ] ifNil: [ self ].
]

{ #category : #operator }
TKTPlannedUnit >> nextOrNil [
	^ (relations detect: #isSequenceable ifNone: [ nil ]) ifNotNil: #object .
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

{ #category : #operator }
TKTPlannedUnit >> replace: aPlanned by: otherPlanned [
	(relations detect: [  : r | r object = aPlanned ] ifNone:[ self error: 'There is not task to replace!' ]) object: otherPlanned.
]

{ #category : #accessing }
TKTPlannedUnit >> task [
	^ unit
]

{ #category : #operator }
TKTPlannedUnit >> unit: aUnitToPlan [
	unit := aUnitToPlan.
]
