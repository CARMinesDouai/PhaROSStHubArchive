"
A PhaROSPublisher is an obeject that allows to send a message to a channel, that belongs to a topic.
"
Class {
	#name : #PhaROSPublisher,
	#superclass : #PhaROSConfigurableErrorManagement,
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
PhaROSPublisher >> channel [ 
	^channel 
]

{ #category : #'as yet unclassified' }
PhaROSPublisher >> channel: aChannel [ 
	channel := aChannel 
]

{ #category : #'as yet unclassified' }
PhaROSPublisher >> send: aMessageBlock [
	^ self execute: [
		channel sendAMessage: aMessageBlock. 
	].
]
