Class {
	#name : #PhaROSTransport,
	#superclass : #Object,
	#instVars : [
		'master',
		'node',
		'comm'
	],
	#category : #'PhaROS-Kernel-Nodes'
}

{ #category : #'as yet unclassified' }
PhaROSTransport class >> domain: anIP xml: aPort tcp: otherPort master: aMaster [
	| tp |
	tp := self new .
	tp communication: (PhaROSCommunicationLayer xmlAt: aPort tcpAt: otherPort of: anIP delegatingOn: tp) asStickyReference; master: aMaster . 
	^ tp
	
]

{ #category : #publishing }
PhaROSTransport >> comm [
	^ comm ref.
]

{ #category : #accessing }
PhaROSTransport >> communication:  aCommunicationLayer [
	comm := aCommunicationLayer
]

{ #category : #publishing }
PhaROSTransport >> createInputChannelForTopic: aTopic [
	| channel |
	
	channel := PhaROSInPutChannel new.
	channel owner: node.
	channel topic: aTopic.
	aTopic  registerChannel: channel.
	
	channel initialize: [ self resolvePublishersFor: aTopic ].
	
	
	^ channel.
]

{ #category : #publishing }
PhaROSTransport >> createOutputChannelForTopic: aTopic [
	| channel |
	
	channel := PhaROSOutPutChannel new.
	channel owner: node.
	channel topic: aTopic.
	channel xmlurl: self comm url.
	
	aTopic registerChannel: channel.
	master registerPublisher: node name to: aTopic name with: aTopic type andCallerUri: self comm url. 
	
	^ channel.
]

{ #category : #subscribing }
PhaROSTransport >> finalize [
	self comm finalize.
	comm := nil.
	node := nil.
	master := nil.
]

{ #category : #accessing }
PhaROSTransport >> isPublisherOf:  aTopic [
 	^ (master lookupTopic: aTopic) isAPublisher: node. 
	
]

{ #category : #publishing }
PhaROSTransport >> localPublisherNode: anURL to: aTopic [
	| link |
	
	link := PhaROSInternalNodeLink new xmlurl: anURL ; yourself .
	(aTopic outputchannel: anURL ) subscribe: link. 
	
	^ link.
]

{ #category : #accessing }
PhaROSTransport >> master: aMaster [
	master  := aMaster 
]

{ #category : #subscribing }
PhaROSTransport >> node: aNode [
	node := aNode 
]

{ #category : #publishing }
PhaROSTransport >> publisher: aTopicID typedAs: aTypeID [
	
	^ ((master lookupTopic: aTopicID  typedAs: aTypeID) publishingChannelFor: node throught: self) publisher. 
]

{ #category : #publishing }
PhaROSTransport >> publisherNode: anURL to: aTopic [
	
	^ (aTopic isLocalPublisher: anURL) ifTrue: [
			self localPublisherNode: anURL to: aTopic. 
		] ifFalse: [
			self remotePublisherNode: anURL to: aTopic. 
	   ].
]

{ #category : #publishing }
PhaROSTransport >> remotePublisherNode: anURL to: aTopic [
	| socket  message connectionMessage|
	
	socket := self comm resolveSocketTo: aTopic of: anURL for: node.
		
	message := PhaROSHSMessage newSubscriberWith:[
		:msg |
		msg callerId: node name	;
				topic: aTopic name;
				md5Sum: aTopic md5Sum;
				type: aTopic type.
				
	].
	message sendTo: socket .
	
	connectionMessage := PhaROSHSMessage newSubscriberMessageFrom: socket receiveDataWithTimeout.
	
	
	^ PhaROSExternalPublisherNode new xmlurl:anURL;  socket: socket; topic: aTopic; yourself.
]

{ #category : #publishing }
PhaROSTransport >> resolvePublishersFor: aTopic [
	| urls channel |
	
	
	urls := (master registerSubscriber: node name to: aTopic name with: aTopic type andCallerUri: self comm url) asSet.
	channel := aTopic subscribingChannelFor: node.
	
	^ urls collect: [ :url |
		channel publishers detect: [ : p | p xmlurl = url ] ifNone: [ 
			| publisherNode |
			[
				publisherNode := self publisherNode: url to: aTopic .
				publisherNode channel: channel.
				channel subscribe:  publisherNode.
				publisherNode setup.
			] on: Error do: [: e | 
				Transcript show: ' Error connecting to ', url; cr.
				publisherNode := nil.
			]
		]
	] thenSelect: #notNil.
	
]

{ #category : #publishing }
PhaROSTransport >> subscribe: aNodeName with: aSocket to: aTopicID [ 
	| topic extNode handshakeMessage channel |
	
	
	topic := master lookupTopic: aTopicID.
	channel := (topic  publishingChannelFor: node).
	
	handshakeMessage := PhaROSHSMessage newPublisherWith: [ :msg |
		msg callerId: channel owner name.
		msg md5Sum: topic md5Sum.
		msg type: topic type.
		msg latching: topic isLatched.
	].
	handshakeMessage sendTo: aSocket.
	
	
	extNode := PhaROSExternalSubscriberNode named: aNodeName subscriberOf: topic with: aSocket.
	channel subscribe: extNode.
	^ channel
]

{ #category : #subscribing }
PhaROSTransport >> subscriber: aTopicID typedAs: aTypeID [
	^ ((master lookupTopic: aTopicID  typedAs: aTypeID) subscribingChannelFor: node throught: self). 
]
