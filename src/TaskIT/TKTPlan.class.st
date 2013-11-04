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
	startingTask := aPlannable asPlanned.
	^ startingTask.
]

{ #category : #accessing }
TKTPlan >> sequence [
	| sequencer |
	sequencer := TKTPlanSequencer new.
	startingTask accept: sequencer.
	^ sequencer.
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
