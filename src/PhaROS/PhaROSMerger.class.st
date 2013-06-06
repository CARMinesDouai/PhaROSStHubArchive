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

	^ (((stamps max - stamps min) asMilliSeconds < self threshold) and: [ (DateAndTime now - stamps max ) < self threshold ] )
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
PhaROSMerger >> merge: aTopicConnectionBuilder with: anOtherTopicConnectionBuilder using: aTransformation redirectingTo: aTopicPublisher [
	aTopicConnectionBuilder for: (self mergerCallback:aTopicConnectionBuilder).
	anOtherTopicConnectionBuilder for: (self mergerCallback: anOtherTopicConnectionBuilder).
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
