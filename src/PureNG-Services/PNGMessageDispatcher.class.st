Class {
	#name : #PNGMessageDispatcher,
	#superclass : #PNGActiveObject,
	#instVars : [
		'messageQueue',
		'notificationQueue'
	],
	#category : #'PureNG-Kernel'
}

{ #category : #'as yet unclassified' }
PNGMessageDispatcher class >> createProcessDispatchMessagesFrom: bridgeQueue to: messageQueue and: notificationQueue [

	^ ActiveObject do: [ 
		[true] whileTrue: [
			|response|
			response := PNGEncodedMessage createResponseOrNotificationForData: bridgeQueue next readStream.
	
			response isNotification 
				ifTrue: [ notificationQueue nextPut:  response ] 
				ifFalse: [ messageQueue nextPut: response ]
		]
	]

]

{ #category : #accessing }
PNGMessageDispatcher >> bridgeQueue [
	^self robot bridge responseQueue 
]

{ #category : #'initialize-release' }
PNGMessageDispatcher >> initialize [
	super initialize.
	messageQueue := SharedQueue new.
	notificationQueue := SharedQueue new
]

{ #category : #accessing }
PNGMessageDispatcher >> messageQueue [
	^ messageQueue
]

{ #category : #accessing }
PNGMessageDispatcher >> messageQueue: anObject [
	messageQueue := anObject
]

{ #category : #accessing }
PNGMessageDispatcher >> nextAnswer [
	^messageQueue next
]

{ #category : #accessing }
PNGMessageDispatcher >> notificationQueue [
	^ notificationQueue
]

{ #category : #accessing }
PNGMessageDispatcher >> notificationQueue: anObject [
	notificationQueue := anObject
]

{ #category : #activity }
PNGMessageDispatcher >> start [
	super start.	
	
	self
		activeObject:
			(self class createProcessDispatchMessagesFrom: self bridgeQueue to: messageQueue and: notificationQueue).
	
	self activeObject
		priority: Processor highIOPriority;
		start
]
