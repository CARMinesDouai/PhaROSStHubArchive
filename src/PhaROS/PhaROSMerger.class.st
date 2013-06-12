Class {
	#name : #PhaROSMerger,
	#superclass : #Object,
	#instVars : [
		'outgoing',
		'transformation',
		'messages'
	],
	#category : #'PhaROS-Packages-Merger'
}

{ #category : #'as yet unclassified' }
PhaROSMerger >> checkStamps: stamps [

	^ (((stamps max - stamps min) asMilliSeconds < self threshold) and: [ (DateAndTime now - stamps max ) asMilliSeconds < self threshold ] )
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
	(self checkStamps:  (messages values collect: [ : ms  | ms at: 2 ]) ) ifTrue: [
		outgoing send: [ :msg |
			| storedMsgs |
			storedMsgs := (messages values collect: [ : ms  | ms at: 1 ]).
			transformation cull: msg cull: (storedMsgs at:1) cull:(storedMsgs at:2)
		]	
	] ifFalse: [Transcript show: 'data out of syncro or too old'; cr.]
]

{ #category : #'as yet unclassified' }
PhaROSMerger >> merge: aConnectedTopicFlux with: anOtherConnectedTopicFlux using: aTransformation redirectingTo: aTopicPublisher [
	aConnectedTopicFlux for: (self mergerCallback: aConnectedTopicFlux).
	anOtherConnectedTopicFlux for: (self mergerCallback: anOtherConnectedTopicFlux).
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
	messages at: aTopicConnectionBuilder put: {msg . stamp} .
	self merge.
]

{ #category : #'as yet unclassified' }
PhaROSMerger >> threshold [
	^ 500. "milliseconds"
]
