Class {
	#name : #TKTPlanSequencer,
	#superclass : #TKTPlanVisitor,
	#instVars : [
		'units',
		'cursor'
	],
	#category : #'TaskIT-Tasks-Plan'
}

{ #category : #'as yet unclassified' }
TKTPlanSequencer >> acceptImplication: anImplication [
	self error:'Should implement relation' .
]

{ #category : #'as yet unclassified' }
TKTPlanSequencer >> acceptImplicationSequence: aTKTSequence [
	aTKTSequence antecedent accept: self.
]

{ #category : #'as yet unclassified' }
TKTPlanSequencer >> acceptUnit: aPlannedUnit [
	units add:aPlannedUnit.
]

{ #category : #'as yet unclassified' }
TKTPlanSequencer >> initialize [
	super initialize.
	units := OrderedCollection new. 
	cursor := 1.
]

{ #category : #'as yet unclassified' }
TKTPlanSequencer >> next [
	| unit |
	
	unit := units at: cursor.
	cursor := cursor +1.
	^ unit.
]

{ #category : #'as yet unclassified' }
TKTPlanSequencer >> reset [
	cursor := 1.
]

{ #category : #'as yet unclassified' }
TKTPlanSequencer >> run [
	^ units allButFirst paralellize inject: units first reduce asResult into: [ :acc : next | next reduce: acc  ].
]
