Class {
	#name : #BoundTcpListener,
	#superclass : #TcpListener,
	#instVars : [
		'address'
	],
	#category : #'rSTAdd-ons'
}

{ #category : #'as yet unclassified' }
BoundTcpListener class >> on: anAddress port: aPort handler: aValuable [

	^self new initializeOn: anAddress port: aPort handler: aValuable 


]

{ #category : #accessing }
BoundTcpListener >> address [
	^ address
]

{ #category : #accessing }
BoundTcpListener >> address: anObject [
	address := anObject
]

{ #category : #private }
BoundTcpListener >> initialize [

	super initialize.
	
	socketsToDestroy := OrderedCollection new
]

{ #category : #private }
BoundTcpListener >> initializeOn: anAddress port: aPort handler: aValuableObject [

	self initialize.

	address := anAddress.
	portNumber := aPort.
	handler := aValuableObject.

]

{ #category : #private }
BoundTcpListener >> pvtNewListener: backlogSize [
	"Create a new socket that listens bounded to the
	receiver's address and port.  
	The backlog is how many simultaneous 
	connections to accept at the same time"

	| listener |
	listener := self socketClass newTCP.
	self socketsToDestroy add: listener.
	listener 
		listenOn: portNumber 
		backlogSize: backlogSize
		interface: address.
	^listener
]

{ #category : #private }
BoundTcpListener >> pvtOldListenLoop: aBlock [
	"see comment on ConnectionQueue>>oldStyleListenLoop"
	| socket |
	socket := nil.
	aBlock whileTrue:
		[socket ifNil:
			["try to create a new socket for listening"
			socket := Socket createIfFail: [nil]].
		socket 
			ifNil: [Process terminationOkDuring: [(Delay forMilliseconds: 100) wait]]
			ifNotNil:
				[socket isUnconnected ifTrue: 
					[socket 
						listenOn: portNumber 
						backlogSize: self backlogSize 
						interface: address.
					self socketsToDestroy add: socket].
				Process terminationOkDuring: 
					[[socket waitForConnectionUntil: (Socket deadlineSecs: 10)]
						ensure: [socket destroy]].
				socket isConnected
					ifTrue: 
						["connection established"
						handler value: socket.
						socket := nil]
					ifFalse:
						[socket isWaitingForConnection
							ifFalse: [socket destroy. socket := nil]]]]
]
