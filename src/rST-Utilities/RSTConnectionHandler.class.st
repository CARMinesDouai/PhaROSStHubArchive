"
An old class from KOM that isn't used anymore
Kom48 (Comanche beta 4.8)
bolot 4/2/2001 18:44

ConnectionHandler

Comment from kom46:
- also see ConnectionQueue
- does not keep the queue of open sockets
- launches the applications/modules immediately
  upon accepting a connection
"
Class {
	#name : #RSTConnectionHandler,
	#superclass : #Object,
	#instVars : [
		'portNumber',
		'socketClass',
		'process',
		'priority',
		'handlerBlock',
		'lastError',
		'socketsToDestroy'
	],
	#classVars : [
		'Registry'
	],
	#category : 'rST-Core'
}

{ #category : #'instance creation' }
RSTConnectionHandler class >> onPort: aNumber handler: aBlock priority: pNum [
	^self new
		initializeOnPort: aNumber
		handler: aBlock
		priority: pNum
]

{ #category : #registry }
RSTConnectionHandler class >> register: anObject [

	self registry add: anObject
]

{ #category : #registry }
RSTConnectionHandler class >> registry [

	Registry == nil ifTrue: [
		Registry := WeakRegistry new
	].
	^Registry
]

{ #category : #registry }
RSTConnectionHandler class >> unregister: anObject [

	self registry remove: anObject ifAbsent: [ ]
]

{ #category : #'initialize-release' }
RSTConnectionHandler >> destroySockets [
	"mp 10/13/2005 11:27"
	
	socketsToDestroy ifNotNil: [ 
		socketsToDestroy do: [:ea | ea closeAndDestroy]].
	socketsToDestroy := OrderedCollection new
]

{ #category : #'initialize-release' }
RSTConnectionHandler >> finalize [
	"mp 10/13/2005 11:28"
	"Like #stop, but without the #unregister"

	process ifNotNil: [process terminate].
	process := nil.
	self destroySockets.



]

{ #category : #'initialize-release' }
RSTConnectionHandler >> initializeOnPort: aNumber handler: aBlock priority: pNumber [
	portNumber _ aNumber.
	handlerBlock _ aBlock.
	priority _ pNumber.
	socketsToDestroy _ OrderedCollection new
]

{ #category : #'initialize-release' }
RSTConnectionHandler >> initializeProcessAtPriority: pNumber [
	process _ [ self pvtListenLoop ] newProcess.
	process priority: pNumber
]

{ #category : #queries }
RSTConnectionHandler >> isRunning [
	"mp 10/13/2005 11:29"
	
	^ process notNil
]

{ #category : #private }
RSTConnectionHandler >> newListener [
	| listener |

	self flag: #todo. "listener _ self socketClass newTCP."
	listener := OldSocket newTCP.

	"backlog is how many simultaneous connections to accept at the same time"
	listener listenOn: portNumber backlogSize: 10.
	^listener
]

{ #category : #accessing }
RSTConnectionHandler >> portNumber [
	^portNumber
]

{ #category : #printing }
RSTConnectionHandler >> printOn: aStream [
	aStream nextPutAll: (self class name asString, ' port: ', self portNumber asString).
	self isRunning ifTrue: [
		aStream nextPutAll: ' [running]'
	] ifFalse:[
		aStream nextPutAll: ' [stopped]'
	]
]

{ #category : #accessing }
RSTConnectionHandler >> priority [
	^priority
]

{ #category : #accessing }
RSTConnectionHandler >> process [
	process == nil ifTrue: [
		self initializeProcessAtPriority: self priority.
	].
	^process
]

{ #category : #private }
RSTConnectionHandler >> pvtListenLoop [
	[
		self pvtNewListenLoop
	] on: Error do: [ :ex |
		process _ nil.
		self destroySockets.
	]
]

{ #category : #private }
RSTConnectionHandler >> pvtNewListenLoop [
	| socket listener |

	listener := self newListener.
	self socketsToDestroy add: listener.	

	"If the listener is not valid then the we cannot use the
	BSD style accept() mechanism."
	listener isValid ifFalse: [^self pvtOldListenLoop].
	[ true ] whileTrue: [
		socket := listener waitForAcceptUntil: (OldSocket deadlineSecs: 10).
		(socket notNil and: [ socket isConnected ])
			ifTrue: [
				handlerBlock value: socket.
				socket := nil]
			ifFalse: [
				socket notNil ifTrue: [socket destroy].
				listener isValid
					ifFalse: [(Delay forMilliseconds: 100) wait.
						listener destroy.
						listener := self newListener].
			].
	]
]

{ #category : #private }
RSTConnectionHandler >> pvtOldListenLoop [
	"see comment on ConnectionQueue>>oldStyleListenLoop"
	| socket |
	socket := nil.

	[ true ] whileTrue: [
		(socket == nil) ifTrue: [
			"try to create a new socket for listening"
			socket := OldSocket createIfFail: [ nil ]].

		(socket == nil)
		ifTrue: [(Delay forMilliseconds: 100) wait]
		ifFalse: [
			socket isUnconnected ifTrue: [ socket listenOn: portNumber ].
			socket waitForConnectionUntil: (OldSocket deadlineSecs: 10).
			socket isConnected
				ifTrue: ["connection established"
					"mutex critical: [" handlerBlock value: socket "]".
					socket := nil]
				ifFalse: [
					socket isWaitingForConnection
						ifFalse: [socket destroy. socket := nil]].
		].
	]
]

{ #category : #registry }
RSTConnectionHandler >> register [

	^self class register: self
]

{ #category : #accessing }
RSTConnectionHandler >> socketsToDestroy [

	socketsToDestroy == nil ifTrue: [
		socketsToDestroy _ OrderedCollection new.
	].
	^socketsToDestroy
]

{ #category : #'starting and stopping' }
RSTConnectionHandler >> start [
	self stop.
	self process resume.
	self register
]

{ #category : #'starting and stopping' }
RSTConnectionHandler >> stop [
	self unregister.
	process ~~ nil ifTrue: [
		process terminate.
	].
	process _ nil.

	"We do the following in a timely manner instead of relying on
	finalization because we may want to turn right around and start
	listening again.  If an old socket is still around an listening, it may
	interfere with a new one's ability to hear."

	self destroySockets
]

{ #category : #registry }
RSTConnectionHandler >> unregister [

	^self class unregister: self
]
