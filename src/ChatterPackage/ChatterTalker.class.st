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
	self paralellize looping readFrom: aReadStream.
]

{ #category : #'as yet unclassified' }
ChatterTalker >> readFrom: anInputStream [
	| token |
	channel send: [ : m | 
		token := anInputStream upTo: Character lf.
		self log: 'Sending data to all subscribers'.
		m data: token. 
	].
]
