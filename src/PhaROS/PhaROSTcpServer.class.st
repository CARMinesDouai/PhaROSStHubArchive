"
This class manage a tcp server related with a node. Here there is just the Handshake and the initialization routine for a new socket.
"
Class {
	#name : #PhaROSTcpServer,
	#superclass : #Object,
	#instVars : [
		'owner',
		'server'
	],
	#classInstVars : [
		'RoStTcpServers'
	],
	#category : #'PhaROS-Network-Tcp'
}

{ #category : #constructors }
PhaROSTcpServer class >> initialize [ 
	RoStTcpServers := Dictionary new.

]

{ #category : #constructors }
PhaROSTcpServer class >> startOn: aPort named: aName for: aNode [
	

	^RoStTcpServers at: aPort ifAbsentPut: [
		| instance |
		
		instance := self new .
		instance owner: aNode.
		instance server: (PhaROSServer startOn: aPort delegate: [: socket | instance serve: socket ]).
	].

]

{ #category : #service }
PhaROSTcpServer class >> stop: aRoStTcpServer [ 
[
	RoStTcpServers removeKey: aRoStTcpServer portNumber ifAbsent:[].
	 ] on: Error do: []
]

{ #category : #server }
PhaROSTcpServer >> finalize [ 
	PhaROSTcpServer stop: self.
	server ifNotNil: [server  stop].
	server := nil.
]

{ #category : #accessing }
PhaROSTcpServer >> owner [
	^ owner
]

{ #category : #server }
PhaROSTcpServer >> owner: aNode [
	owner := aNode.
]

{ #category : #accessing }
PhaROSTcpServer >> portNumber [
	^ server port.
]

{ #category : #server }
PhaROSTcpServer >> serve: aSocket [
	| stream message |
	
	stream := SocketStream on: aSocket.
	stream binary.
	
	self flag:#makeUpToThisThing.
	message := PhaROSHSMessageDecoder decodeUnknownMessageHeader:  stream.
	
	PhaROSHeaderVerifier new verify: message. 
	self owner manageIncomingConnection: message becomeKnown with: aSocket.
	
	
]

{ #category : #server }
PhaROSTcpServer >> server:aServer [ 
 server := aServer 
]
