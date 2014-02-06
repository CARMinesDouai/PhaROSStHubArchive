Class {
	#name : #ChatterTalker,
	#superclass : #Object,
	#instVars : [
		'channel'
	],
	#category : #'ChatterPackage-Nodelets'
}

{ #category : #'as yet unclassified' }
ChatterTalker class >> for: aPublisher [
	^ self new channel: aPublisher.
]

{ #category : #'as yet unclassified' }
ChatterTalker >> channel: aChannel [	
	channel := aChannel
]

{ #category : #'as yet unclassified' }
ChatterTalker >> consume: aReadStream [
	| token |
	([
		[ 
			channel send: [ : m | 
				token:=self getMessageFrom: aReadStream.
				self log: 'Sending data to all subscribers'.
				m data: token. 
			].
		] doWhileFalse: [ token = 'exit' ] .
	] asTaskAt: Processor systemBackgroundPriority) shootIt.
]

{ #category : #'as yet unclassified' }
ChatterTalker >> getMessageFrom: aReadStream [
	^ aReadStream upTo: Character lf.
	
]
