Class {
	#name : #TKTPlan,
	#superclass : #Object,
	#instVars : [
		'startingTask'
	],
	#category : #'TaskIT-Tasks-Plan'
}

{ #category : #operators }
TKTPlan >> => aPlannable [ 

	^ startingTask ifNil:[
		startingTask := aPlannable asPlanned.
		startingTask parent: self. 
		startingTask
	] ifNotNil: [ 
		startingTask => aPlannable.
	 ].
	
]

{ #category : #operators }
TKTPlan >> addParalellizable: aPlanned [
	startingTask addParalellizable: aPlanned
]

{ #category : #'as yet unclassified' }
TKTPlan >> also [
	^ self sequence lastUnit.
]

{ #category : #'as yet unclassified' }
TKTPlan >> replace: aPlanned by: otherPlanned [
	startingTask = aPlanned ifTrue:[
		startingTask := otherPlanned.	
	] ifFalse:[ self error: 'there is not related task!' ].
]

{ #category : #accessing }
TKTPlan >> sequence [
	^ TKTPlanSequencer sequence: startingTask
]

{ #category : #operators }
TKTPlan >> size [
	| counter |
	
	counter := TKTPlanUnitCounter new.
	startingTask accept: counter.
	^ counter units.
]

{ #category : #accessing }
TKTPlan >> startingTask [
	^ startingTask
]
