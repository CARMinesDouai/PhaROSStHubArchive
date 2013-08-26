Class {
	#name : #PhaROSPublisher,
	#superclass : #Object,
	#instVars : [
		'channel'
	],
	#category : #'PhaROS-TopicHandlers'
}

{ #category : #'as yet unclassified' }
PhaROSPublisher class >> for: aChannel [
	^ self new channel: aChannel; yourself.
]

{ #category : #'as yet unclassified' }
PhaROSPublisher >> channel: aChannel [ 
	channel := aChannel 
]

{ #category : #'as yet unclassified' }
PhaROSPublisher >> send: aMessageBlock [
	^ channel sendAMessage: aMessageBlock. 
]
