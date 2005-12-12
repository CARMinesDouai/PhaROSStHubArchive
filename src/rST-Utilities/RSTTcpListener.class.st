"
I listen for TCP connections on a given port number.  

Instance variables:

	portNumber - the number of the port on which to listen for incoming connections

	handler - an object that is sent the #value: message whenever an incoming connection is established; the argument to this message is a connected socket

	socketsToDestroy - a list of sockets that need to be destroyed (usually a listening socket that is no longer needed)

Usage:

In the following example, a TcpListener is established on port 8123.  After evaluating the following example, if you open a transcript window and point a web browser to port 8123 of this machine (ie. http://localhost:8123/), you should see several http requests appear in the transcript.

	| count listener |
	count _ 0.
	listener _ TcpListener
		on: 8123
		handler: 
			[ :socket |
			count _ count + 1.
			Transcript show: socket getData.
			socket closeAndDestroy].
	listener forkAndListenWhile: [count < 5].

For an additional example of using TcpListener, see HttpService.

"
Class {
	#name : #RSTTcpListener,
	#superclass : #Object,
	#instVars : [
		'portNumber',
		'handler',
		'socketsToDestroy'
	],
	#category : #'rST-Core'
}

{ #category : #preferences }
RSTTcpListener class >> acceptTimeout [

	^#'TcpListener-acceptTimeout' binding ifNil: [10]
]

{ #category : #preferences }
RSTTcpListener class >> acceptTimeout: seconds [

	^#'TcpListener-acceptTimeout' binding: seconds
]

{ #category : #preferences }
RSTTcpListener class >> backlogSize [

	^#'TcpListener-backlogSize' binding ifNil: [10]
]

{ #category : #preferences }
RSTTcpListener class >> backlogSize: anInteger [

	^#'TcpListener-backlogSize' binding: anInteger
]

{ #category : #preferences }
RSTTcpListener class >> listenerDestroyDelay [

	^#'TcpListener-listenerDestroyDelay' binding ifNil: [10]
]

{ #category : #preferences }
RSTTcpListener class >> listenerDestroyDelay: milliseconds [

	^#'TcpListener-listenerDestroyDelay' binding: milliseconds
]

{ #category : #'instance creation' }
RSTTcpListener class >> on: portNumber handler: aValuable [

	^self new
		initializeOnPort: portNumber
		handler: aValuable

]

{ #category : #accessing }
RSTTcpListener >> acceptTimeout [
	^self class acceptTimeout
]

{ #category : #accessing }
RSTTcpListener >> backlogSize [

	^self class backlogSize
]

{ #category : #'initialize-release' }
RSTTcpListener >> destroySockets [
	socketsToDestroy ~~ nil ifTrue: 
		[socketsToDestroy do: [ :ea | ea destroy]].
	socketsToDestroy := OrderedCollection new
]

{ #category : #private }
RSTTcpListener >> forkAndListenWhile: aBlock [

	[self listenWhile: aBlock] fork

]

{ #category : #'initialize-release' }
RSTTcpListener >> initializeOnPort: aNumber handler: aValuableObject [

	portNumber _ aNumber.
	handler _ aValuableObject.
	socketsToDestroy _ OrderedCollection new
]

{ #category : #private }
RSTTcpListener >> listen [
	"This is the listening loop.  It runs forever accepting
	inbound sockect connections."

	self listenWhile: [true]
]

{ #category : #private }
RSTTcpListener >> listenWhile: aBlock [
	"This is the listening loop.  It runs while aBlock evaluates
	to true.  When the loop terminates or when the process running
	the loop is terminated, any listening sockets will be destroyed."

	self socketClass initializeNetwork.
	[self pvtListenLoop: aBlock] ensure: [self destroySockets]

]

{ #category : #accessing }
RSTTcpListener >> listenerDestroyDelay [

	^self class listenerDestroyDelay
]

{ #category : #private }
RSTTcpListener >> newListener: backlogSize [
	"Create a new socket that listens on our port.  The backlog is how many simultaneous 
	connections to accept at the same time"

	[^self pvtNewListener: backlogSize] on: Error do: [].

	"Try one more time after initializing the network"
	Socket initializeNetwork.
	^self pvtNewListener: backlogSize.
]

{ #category : #accessing }
RSTTcpListener >> portNumber [

	^portNumber
]

{ #category : #printing }
RSTTcpListener >> printOn: aStream [

	aStream nextPutAll: (self class name asString, ' port: ', self portNumber asString).

]

{ #category : #private }
RSTTcpListener >> pvtListenLoop: aBlock [
	| socket listener |

	listener := self newListener: self backlogSize.

	"If the listener is not valid then the we cannot use the
	BSD style accept() mechanism."
	listener isValid ifFalse: [^self pvtOldListenLoop: aBlock].

	aBlock whileTrue: 
		[Process terminationOkDuring: 
			[[socket := listener waitForAcceptFor: self acceptTimeout ifTimedOut: [nil]]
				ifCurtailed: [listener destroy]].
		socket ifNotNil:
			[socket isConnected
				ifTrue: [handler value: socket]
				ifFalse: [socket destroy].
			socket := nil].
		listener isValid ifFalse: 
			[(Delay forMilliseconds: self listenerDestroyDelay) wait.
			listener destroy.
			listener := self newListener: self backlogSize]]
]

{ #category : #private }
RSTTcpListener >> pvtNewListener: backlogSize [
	"Create a new socket that listens on our port.  The backlog is how many simultaneous 
	connections to accept at the same time"

	| listener |
	listener := self socketClass newTCP.
	self socketsToDestroy add: listener.
	listener listenOn: portNumber backlogSize: backlogSize.
	^listener
]

{ #category : #private }
RSTTcpListener >> pvtOldListenLoop: aBlock [
	"see comment on ConnectionQueue>>oldStyleListenLoop"
	| socket |
	socket _ nil.
	aBlock whileTrue:
		[socket ifNil:
			["try to create a new socket for listening"
			socket _ Socket createIfFail: [nil]].
		socket 
			ifNil: [Process terminationOkDuring: [(Delay forMilliseconds: 100) wait]]
			ifNotNil:
				[socket isUnconnected ifTrue: 
					[socket listenOn: portNumber.
					self socketsToDestroy add: socket].
				Process terminationOkDuring: 
					[[socket waitForConnectionUntil: (Socket deadlineSecs: 10)]
						ensure: [socket destroy]].
				socket isConnected
					ifTrue: 
						["connection established"
						handler value: socket.
						socket _ nil]
					ifFalse:
						[socket isWaitingForConnection
							ifFalse: [socket destroy. socket _ nil]]]]
]

{ #category : #accessing }
RSTTcpListener >> socketClass [

	^Socket
]

{ #category : #accessing }
RSTTcpListener >> socketsToDestroy [

	^socketsToDestroy ifNil: 
		[socketsToDestroy := OrderedCollection new].

]
