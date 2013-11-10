Class {
	#name : #TKTPlannedRunnableVisitor,
	#superclass : #TKTPlannedUnit,
	#category : #'TaskIT-Tasks-Plan'
}

{ #category : #'as yet unclassified' }
TKTPlannedRunnableVisitor >> reduce [
	^unit run
]

{ #category : #'as yet unclassified' }
TKTPlannedRunnableVisitor >> reduce: anArray [
 | args |
	args := anArray isString ifTrue: [ {anArray} ] ifFalse: [ anArray asArray ]. 
	^unit run: args.
]
