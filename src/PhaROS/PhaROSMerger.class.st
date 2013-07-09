Class {
	#name : #PhaROSMerger,
	#superclass : #Object,
	#instVars : [
		'outgoing',
		'transformation',
		'messages',
		'this',
		'that',
		'minSync',
		'maxSync',
		'condition'
	],
	#category : #'PhaROS-Packages-Merger'
}

{ #category : #'as yet unclassified' }
PhaROSMerger >> checkStamps: stamps [
	| minDif maxDif ret |
	
	minDif :=  (DateAndTime now - stamps min ) asMilliSeconds.
	maxDif :=  (DateAndTime now - stamps max ) asMilliSeconds.
	
	ret := minSync ifNil: [true] ifNotNil:[( minDif - minSync) < self threshold and: [ (maxDif - maxSync ) < self threshold ]].
	
	minSync := minDif.
	maxSync := maxDif.
	
	^ret.
]

{ #category : #'as yet unclassified' }
PhaROSMerger >> finalize [
	outgoing := nil.
	transformation := nil.
	messages := nil. 
]

{ #category : #'as yet unclassified' }
PhaROSMerger >> initialize [ 
	messages := Dictionary new.

]

{ #category : #'as yet unclassified' }
PhaROSMerger >> merge [
	messages size = 2 ifFalse: [ 
		Transcript show: 'waiting for have data from two topics to start merging'
	] ifTrue:[
		(self checkStamps:  (messages values collect: [ : ms  | ms at: 2 ]) ) ifTrue: [
			
			(condition cull: ((messages at: that ) at: 1) cull:((messages at:this) at:1)) ifTrue: [
				outgoing send: [ :msg |
					transformation cull: msg cull: ((messages at: that ) at: 1) cull:((messages at:this) at:1)
				].
			]	.
		] ifFalse: [Transcript show: 'data out of syncro or too old'; cr.]
	].
]

{ #category : #'as yet unclassified' }
PhaROSMerger >> merge: aConnectedTopicFlux with: anOtherConnectedTopicFlux using: aTransformation redirectingTo: aTopicPublisher [
	^ self merge: aConnectedTopicFlux with: anOtherConnectedTopicFlux using: aTransformation when: [true] redirectingTo: aTopicPublisher
]

{ #category : #'as yet unclassified' }
PhaROSMerger >> merge: aConnectedTopicFlux with: anOtherConnectedTopicFlux using: aTransformation when: aCondition redirectingTo: aTopicPublisher [
	this := aConnectedTopicFlux.
	that := anOtherConnectedTopicFlux.
	
	aConnectedTopicFlux for: (self mergerCallback: aConnectedTopicFlux).
	anOtherConnectedTopicFlux for: (self mergerCallback: anOtherConnectedTopicFlux).
	condition := aCondition.
	transformation := aTransformation.
	outgoing := aTopicPublisher.
]

{ #category : #'as yet unclassified' }
PhaROSMerger >> mergerCallback: aTopicConnectionBuilder [
	^ [ : msg : chn : stamp | 
		self register: msg at: stamp for: aTopicConnectionBuilder.
	].
]

{ #category : #'as yet unclassified' }
PhaROSMerger >> register: msg at: stamp for: aTopicConnectionBuilder [
	messages at: aTopicConnectionBuilder put: {msg . stamp asDateAndTime} .
	self merge.
]

{ #category : #'as yet unclassified' }
PhaROSMerger >> threshold [
	^ 500. "milliseconds"
]
