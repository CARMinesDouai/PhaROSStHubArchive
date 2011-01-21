Class {
	#name : #OCNSocketPluginLibrary,
	#superclass : #Object,
	#instVars : [
		'semaphore',
		'semaIndex'
	],
	#classVars : [
		'Connected',
		'InvalidSocket',
		'OtherEndClosed',
		'TCPSocketType',
		'ThisEndClosed',
		'UDPSocketType',
		'Unconnected',
		'WaitingForConnection'
	],
	#classInstVars : [
		'default'
	],
	#category : #'Ocean-Libraries'
}

{ #category : #'as yet unclassified' }
OCNSocketPluginLibrary class >> initialize [
	"self initialize"

	"Socket Types"
	TCPSocketType := 0.
	UDPSocketType := 1.

	"Socket Status Values"
	InvalidSocket := -1.
	Unconnected := 0.
	WaitingForConnection := 1.
	Connected := 2.
	OtherEndClosed := 3.
	ThisEndClosed := 4.
]

{ #category : #'instance creation' }
OCNSocketPluginLibrary class >> proxy [
	^self new
]

{ #category : #'TCP API' }
OCNSocketPluginLibrary >> bind: aSmallInteger toIpv4Address: anOCNIPV4SocketAddress [ 
	
]

{ #category : #'TCP API' }
OCNSocketPluginLibrary >> close: socketId [

	"Socket>>primSocketDestroy:"	
	<primitive: 'primitiveSocketDestroy' module: 'SocketPlugin'>

	OCNSocketOperationFailureError signal: 'Close failed'

]

{ #category : #'TCP API' }
OCNSocketPluginLibrary >> connect: socketId toServerWithIpv4Address: serverAddress [

	self primSocket: socketId connectTo: serverAddress ip port: serverAddress port.
	(self primSocketConnectionStatus: socketId) = Connected ifFalse: [
		OCNSocketOperationFailureError signal: 'Connection failure'	
	]
]

{ #category : #'TCP API' }
OCNSocketPluginLibrary >> createTcpSocketDescriptorId [
	
	| socketId |
	
	semaphore := Semaphore new.
"	readSemaphore := Semaphore new.
	writeSemaphore := Semaphore new.
"	
	semaIndex := Smalltalk registerExternalObject: semaphore.
"	readSemaIndex := Smalltalk registerExternalObject: readSemaphore.
	writeSemaIndex := Smalltalk registerExternalObject: writeSemaphore.
"	
	socketId := self primSocketCreateNetwork: 0
			type: 0 "SocketType"
			receiveBufferSize: 8000
			sendBufSize: 8000
			semaIndex: semaIndex.
	
	
	socketId ifNotNil: [ 
		(self primSocketConnectionStatus: socketId) = Unconnected ifTrue: [ ^socketId ] 
	].

	OCNSocketOperationFailureError signal: 'Socket creation failure'
]

{ #category : #accessing }
OCNSocketPluginLibrary >> defaultDataBufferSize [
	^2000
]

{ #category : #primitives }
OCNSocketPluginLibrary >> primSocket: socketID connectTo: hostAddress port: port [
	"Attempt to establish a connection to the given port of the given host. This is an asynchronous call; query the socket status to discover if and when the connection is actually completed."

	<primitive: 'primitiveSocketConnectToPort' module: 'SocketPlugin'>
	
]

{ #category : #primitives }
OCNSocketPluginLibrary >> primSocketConnectionStatus: socketID [
	"Return an integer reflecting the connection status of this socket. For a list of possible values, see the comment in the 'initialize' method of this class. If the primitive fails, return a status indicating that the socket handle is no longer valid, perhaps because the Squeak image was saved and restored since the socket was created. (Sockets do not survive snapshots.)"

	<primitive: 'primitiveSocketConnectionStatus' module: 'SocketPlugin'>
	^InvalidSocket 
]

{ #category : #primitives }
OCNSocketPluginLibrary >> primSocketCreateNetwork: netType type: socketType receiveBufferSize: rcvBufSize sendBufSize: sendBufSize semaIndex: semaphoreIndex [ 
	"Return a new socket handle for a socket of the given type and buffer sizes. Return nil if socket creation fails.
	The netType parameter is platform dependent and can be used to encode both the protocol type (IP, Xerox XNS, etc.) and/or the physical network interface to use if this host is connected to multiple networks. A zero netType means to use IP protocols and the primary (or only) network interface.
	The socketType parameter specifies:
		0	reliable stream socket (TCP if the protocol is IP)
		1	unreliable datagram socket (UDP if the protocol is IP)
	The buffer size parameters allow performance to be tuned to the application. For example, a larger receive buffer should be used when the application expects to be receiving large amounts of data, especially from a host that is far away. These values are considered requests only; the underlying implementation will ensure that the buffer sizes actually used are within allowable bounds. Note that memory may be limited, so an application that keeps many sockets open should use smaller buffer sizes. Note the macintosh implementation ignores this buffer size. Also see setOption to get/set socket buffer sizes which allows you to set/get the current buffer sizes for reading and writing.
 	If semaIndex is > 0, it is taken to be the index of a Semaphore in the external objects array to be associated with this socket. This semaphore will be signalled when the socket status changes, such as when data arrives or a send completes. All processes waiting on the semaphore will be awoken for each such event; each process must then query the socket state to figure out if the conditions they are waiting for have been met. For example, a process waiting to send some data can see if the last send has completed."

	<primitive: 'primitiveSocketCreate' module: 'SocketPlugin'>
	
]

{ #category : #primitives }
OCNSocketPluginLibrary >> primSocketCreateNetwork: netType type: socketType receiveBufferSize: rcvBufSize sendBufSize: sendBufSize semaIndex: semaphoreIndex readSemaIndex: aReadSemaphore writeSemaIndex: aWriteSema [
	"See comment in primSocketCreateNetwork: with one semaIndex. However you should know that some implementations
	ignore the buffer size and this interface supports three semaphores,  one for open/close/listen and the other two for
	reading and writing"

	<primitive: 'primitiveSocketCreate3Semaphores' module: 'SocketPlugin'>
	
]

{ #category : #'TCP API' }
OCNSocketPluginLibrary >> readFrom: socketId [
	self shouldBeImplemented 
]

{ #category : #'TCP API' }
OCNSocketPluginLibrary >> receiveFrom: socketId [
	self shouldBeImplemented 
]

{ #category : #'TCP API' }
OCNSocketPluginLibrary >> sendData: data to: socketId [
	self shouldBeImplemented 
]
