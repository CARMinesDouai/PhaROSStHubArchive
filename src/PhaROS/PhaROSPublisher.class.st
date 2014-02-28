"
A PhaROSPublisher is an obeject that allows to send a message to a channel, that belongs to a topic.
"
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
