Class {
	#name : #TKTPlannedCollection,
	#superclass : #TKTPlannedUnit,
	#category : #'TaskIT-Tasks-Plan'
}

{ #category : #reducer }
TKTPlannedCollection >> & aPlannableUnit [ 
	self addPlanned:  aPlannableUnit asPlanned.
	
]

{ #category : #reducer }
TKTPlannedCollection >> accept: aPlanVisitor [
	aPlanVisitor acceptCollection: self.
	relations do: [  : r| r accept: aPlanVisitor ].
]

{ #category : #'as yet unclassified' }
TKTPlannedCollection >> addPlanned: aPlanned [ 
	unit add: aPlanned.
	aPlanned parent: self .
	^ aPlanned.
]

{ #category : #reducer }
TKTPlannedCollection >> asPlannedCollection [
	^ self. 
]

{ #category : #'as yet unclassified' }
TKTPlannedCollection >> initialize [ 	
	super initialize.
	unit := OrderedCollection new.
]

{ #category : #reducer }
TKTPlannedCollection >> reduce [
	^ unit collect:[ : p |  p  paralellize reduce ].
]

{ #category : #reducer }
TKTPlannedCollection >> reduce: anArray [
 | args |
	args := anArray isString ifTrue: [ {anArray} ] ifFalse: [ anArray asArray ]. 
	^ unit collect:[ : p | p  paralellize reduce: args  ].
]

{ #category : #reducer }
TKTPlannedCollection >> units [
	^ unit
]
