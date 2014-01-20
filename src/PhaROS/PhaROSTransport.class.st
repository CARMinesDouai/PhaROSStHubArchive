Class {
	#name : #PhaROSTransport,
	#superclass : #Object,
	#instVars : [
		'master',
		'node',
		'comm',
		'blacklist'
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
PhaROSTransport >> blacklist: anUrl [

	blacklist at: anUrl ifPresent: [ : val | blacklist at:anUrl put: val +1 ] ifAbsent:[ blacklist at: anUrl put: 1].
]

{ #category : #publishing }
PhaROSTransport >> comm [
	^ comm
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

{ #category : #publishing }
PhaROSTransport >> initialize [ 
	blacklist := Dictionary new.
]

{ #category : #publishing }
PhaROSTransport >> isBlackListed: anUrl [
	^ blacklist at: anUrl ifPresent: [ : val | val > 3 ] ifAbsent: [ false ].
]

{ #category : #accessing }
PhaROSTransport >> isPublisherOf:  aTopic [
[
 	^ (master lookupTopic: aTopic) isAPublisher: node. 
] on:Error do: [ ^ false ].	
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

{ #category : #parameters }
PhaROSTransport >> parameter: aName [ 
	^ master parameter: aName.
]

{ #category : #parameters }
PhaROSTransport >> parameter: aName initialized: aValue [
	^ (master parameter: aName asString initialized: aValue for: node name subscribingTo: comm url) transport: self; yourself .
]

{ #category : #publishing }
PhaROSTransport >> processServiceRequest: aServiceID for: aCallerID with: aSocketStream beingPersistent: isPersistent forProbe: isProbe [
	| service handshakeMessage request response packetOfBytes |
	
	isPersistent ifTrue: [ 
		aSocketStream  close. 
		self error: 'Persistent connection is not already developed'.	
	 ].
	
	service := master lookupServiceExposer: aServiceID.
	
	
	handshakeMessage := PhaROSHSMessageHeader newServiceWith:  [ :msg |
		msg callerId: service owner name.
		msg service: service name.
		msg md5Sum: service md5Sum.
		msg type: service type typeName.
		msg requestType: service requestType typeName.
		msg responseType: service responseType typeName.
	].

	packetOfBytes := PhaROSHSMessageEncoder encode:handshakeMessage.

	isProbe ifFalse: [ 
		request := service requestType newPacket.
		
		service requestType isZeroSized ifFalse: [
			request loadStream: aSocketStream.
		].
	
		response :=  service responseType newPacket.
		service process: request value with: response value.
		packetOfBytes	:= packetOfBytes,{1}, response dump.
	 ].
	
	[aSocketStream nextPutAll: packetOfBytes.
	aSocketStream flush.
	aSocketStream close. ] doIt.
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
	| socket  message connectionMessage stream |
	
	
	socket := self comm resolveSocketTo: aTopic of: anURL for: node.
		
	
	message := PhaROSHSMessageHeader newSubscriberWith:[
		:msg |
		msg callerId: node name	;
				topic: aTopic name;
				md5Sum: aTopic md5Sum;
				type: aTopic type.
				
	].
	
	message sendTo: socket .
	
	
	stream := SocketStream on: socket.
	stream binary. 
	connectionMessage := PhaROSHSMessageHeader newSubscriberMessageFrom:stream.
	
	
	^ PhaROSExternalPublisherNode new xmlurl:anURL;  socket: socket; stream: stream; topic: aTopic; yourself.
]

{ #category : #publishing }
PhaROSTransport >> resolvePublishersFor: aTopic [
	| urls channel |
	
	
	urls := (master registerSubscriber: node name to: aTopic name with: aTopic type andCallerUri: self comm url) asSet.
	
	channel := aTopic subscribingChannelFor: node.
	
	^ urls collect: [ :url |
		(self isBlackListed: url ) ifFalse: [
		channel publishers detect: [ : p | p xmlurl = url ] ifNone: [ 
			| publisherNode |
			
			[
				publisherNode := self publisherNode: url to: aTopic .
				publisherNode channel: channel.
				channel subscribe:  publisherNode.
				publisherNode setup.
			] on: Error do: [: e | 
				self log: ' Error connecting to ', url.
				self log: e messageText.
				self blacklist: url.
				publisherNode := nil.
			]
		]
	]
	] thenSelect: #notNil.
	
]

{ #category : #services }
PhaROSTransport >> service: aServiceName [
	^ master lookupService: aServiceName with: node name.
]

{ #category : #'as yet unclassified' }
PhaROSTransport >> service: aServiceName typedAs: aTypeID [
	| srv |
	
	srv := PhaROSServiceExposer new: aServiceName typedAs: aTypeID. 
	srv owner: node.
	master registerService: srv at: self comm rosrpc for: self comm url with: node name.
	
	
	^ srv.
]

{ #category : #publishing }
PhaROSTransport >> subscribe: aNodeName with: aSocket to: aTopicID [ 
	| topic extNode handshakeMessage channel |
	
	
	topic := master lookupTopic: aTopicID.
	channel := (topic  publishingChannelFor: node).
	
	handshakeMessage := PhaROSHSMessageHeader newPublisherWith: [ :msg |
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

{ #category : #parameters }
PhaROSTransport >> sync: aParameter [
	^ master syncParameter: aParameter for: comm name.
]
