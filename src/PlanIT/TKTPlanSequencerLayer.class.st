Class {
	#name : #TKTPlanSequencerLayer,
	#superclass : #TKTPlanSequencer,
	#instVars : [
		'previousSequencer',
		'runner'
	],
	#category : #PlanIT
}

{ #category : #'as yet unclassified' }
TKTPlanSequencerLayer >> initialize [ 
	super initialize.
	runner := self class runner.
]

{ #category : #'as yet unclassified' }
TKTPlanSequencerLayer >> previousSequencer [
	^ previousSequencer
]

{ #category : #'as yet unclassified' }
TKTPlanSequencerLayer >> previousSequencer: aSequencer [
	previousSequencer := aSequencer 
]

{ #category : #'as yet unclassified' }
TKTPlanSequencerLayer >> resultObject [
	^ previousSequencer resultObject
]

{ #category : #'as yet unclassified' }
TKTPlanSequencerLayer >> runner: aRunner [
	runner := aRunner
]
