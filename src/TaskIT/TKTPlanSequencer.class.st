Class {
	#name : #TKTPlanSequencer,
	#superclass : #TKTRunnableVisitor,
	#instVars : [
		'units',
		'cursor'
	],
	#category : #'TaskIT-Tasks-Plan'
}

{ #category : #'as yet unclassified' }
TKTPlanSequencer class >> sequence: aPlanned [ 	
	| sequencer |
	sequencer := self new.
	aPlanned accept: sequencer.
	^ sequencer.
]

{ #category : #'as yet unclassified' }
TKTPlanSequencer >> acceptCollection: aPlannedCollection [

	| expandedPlannedCollection |
	expandedPlannedCollection := TKTPlannedCollection new.
	
	aPlannedCollection units collect: [ :u | TKTPlanSequencer sequence: u ] thenDo: [ : sequenced | expandedPlannedCollection & sequenced ].
	
	self acceptUnit: expandedPlannedCollection .
]

{ #category : #'as yet unclassified' }
TKTPlanSequencer >> acceptImplication: anImplication [
	self error:'Should implement relation' .
]

{ #category : #'as yet unclassified' }
TKTPlanSequencer >> acceptImplicationSequence: aTKTSequence [
	aTKTSequence object accept: self.
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
TKTPlanSequencer >> lastUnit [
	^ units last.
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
	^ units  paralellize allButFirst  inject: (units first reduce) into: [ :acc : next |  next reduce: acc  ].
]

{ #category : #'as yet unclassified' }
TKTPlanSequencer >> run: arrayOfArgs [
	^ units allButFirst paralellize inject: (units first reduce: arrayOfArgs) into: [ :acc : next |  next reduce: acc  ].
]

{ #category : #'as yet unclassified' }
TKTPlanSequencer >> size [ 
	^ units size.
]
