"
A Socket represents a network connection point. Current sockets are designed to support the TCP/IP and UDP protocols

Subclasses of socket provide support for network protocols such as POP, NNTP, HTTP, and FTP. Sockets also allow you to implement your own custom services and may be used to support Remote Procedure Call or Remote Method Invocation some day.

JMM June 2nd 2000 Macintosh UDP support was added if you run open transport.

"
Class {
	#name : #Socket,
	#superclass : #Object,
	#instVars : [
		'semaphore',
		'socketHandle',
		'readSemaphore',
		'writeSemaphore',
		'primitiveOnlySupportsOneSemaphore'
	],
	#classVars : [
		'InvalidSocket',
		'ThisEndClosed',
		'WaitingForConnection',
		'UDPSocketType',
		'Registry',
		'Unconnected',
		'Connected',
		'OtherEndClosed',
		'TCPSocketType',
		'RegistryThreshold',
		'DeadServer'
	],
	#category : #'Network-Kernel'
}

{ #category : #'instance creation' }
Socket class >> acceptFrom: aSocket [
	^[ super new acceptFrom: aSocket ]
		repeatWithGCIf: [ :sock | sock isValid not ]
]

{ #category : #'instance creation' }
Socket class >> createIfFail: failBlock [
	"Attempt to create a new socket. If successful, return the new socket. Otherwise, return the result of evaluating the given block. Socket creation can fail if the network isn't available or if there are not sufficient resources available to create another socket."
	"Note: The default creates a TCP socket"
	^self tcpCreateIfFail: failBlock
]

{ #category : #utilities }
Socket class >> deadServer [

	^ DeadServer
]

{ #category : #utilities }
Socket class >> deadServer: aStringOrNil [
	"Keep the machine name of the most recently encoutered non-responding machine.  Next time the user can move it to the last in a list of servers to try."

	DeadServer _ aStringOrNil
]

{ #category : #utilities }
Socket class >> deadlineSecs: secs [
	"Return a deadline time the given number of seconds from now."

	^ Time millisecondClockValue + (secs * 1000) truncated

]

{ #category : #'class initialization' }
Socket class >> initialize [
	"Socket initialize"

	"Socket Types"
	TCPSocketType _ 0.
	UDPSocketType _ 1.

	"Socket Status Values"
	InvalidSocket _ -1.
	Unconnected _ 0.
	WaitingForConnection _ 1.
	Connected _ 2.
	OtherEndClosed _ 3.
	ThisEndClosed _ 4.

	RegistryThreshold _ 100. "# of sockets"
]

{ #category : #'network initialization' }
Socket class >> initializeNetwork [
	"Initialize the network drivers and the NetNameResolver. Do nothing if the network is already initialized."
	"Note: The network must be re-initialized every time Squeak starts up, so applications that persist across snapshots should be prepared to re-initialize the network as needed. Such applications should call 'Socket initializeNetwork' before every network transaction. "

	NetNameResolver initializeNetwork
]

{ #category : #utilities }
Socket class >> nameForWellKnownTCPPort: portNum [
	"Answer the name for the given well-known TCP port number. Answer a string containing the port number if it isn't well-known."

	| portList entry |
	portList _ #(
		(7 'echo') (9 'discard') (13 'time') (19 'characterGenerator')
		(21 'ftp') (23 'telnet') (25 'smtp')
		(80 'http') (110 'pop3') (119 'nntp')).
	entry _ portList detect: [:pair | pair first = portNum] ifNone: [^ 'port-', portNum printString].
	^ entry last

]

{ #category : #'instance creation' }
Socket class >> new [
	"Return a new, unconnected Socket. Note that since socket creation may fail, it is safer to use the method createIfFail: to handle such failures gracefully; this method is primarily for backward compatibility and may be disallowed in a future release."
	"Note: The default creates a TCP socket - this is also backward compatibility."
	^self newTCP
]

{ #category : #'instance creation' }
Socket class >> newTCP [
	"Create a socket and initialise it for TCP"
	self initializeNetwork.
	^[ super new initialize: TCPSocketType ]
		repeatWithGCIf: [ :socket | socket isValid not ]
]

{ #category : #'instance creation' }
Socket class >> newUDP [
	"Create a socket and initialise it for UDP"
	self initializeNetwork.
	^[ super new initialize: UDPSocketType ]
		repeatWithGCIf: [ :socket | socket isValid not ]
]

{ #category : #utilities }
Socket class >> ping: hostName [
	"Ping the given host. Useful for checking network connectivity. The host must be running a TCP echo server."
	"Socket ping: 'squeak.cs.uiuc.edu'"

	| tcpPort sock serverAddr startTime echoTime |
	tcpPort _ 7.  "7 = echo port, 13 = time port, 19 = character generator port"

	serverAddr _ NetNameResolver addressForName: hostName timeout: 10.
	serverAddr = nil ifTrue: [
		^ self inform: 'Could not find an address for ', hostName].

	sock _ Socket new.
	sock connectNonBlockingTo: serverAddr port: tcpPort.
	[sock waitForConnectionFor: 10]
		on: ConnectionTimedOut
		do: [:ex |
			(self confirm: 'Continue to wait for connection to ', hostName, '?')
				ifTrue: [ex retry]
				ifFalse: [
					sock destroy.
					^ self]].

	sock sendData: 'echo!'.
	startTime _ Time millisecondClockValue.
	[sock waitForDataFor: 15]
		on: ConnectionTimedOut
		do: [:ex | (self confirm: 'Packet sent but no echo yet; keep waiting?')
			ifTrue: [ex retry]].
	echoTime _ Time millisecondClockValue - startTime.

	sock destroy.
	self inform: hostName, ' responded in ', echoTime printString, ' milliseconds'.

]

{ #category : #utilities }
Socket class >> pingPorts: portList on: hostName timeOutSecs: timeOutSecs [
	"Attempt to connect to each of the given sockets on the given host. Wait at most timeOutSecs for the connections to be established. Answer an array of strings indicating the available ports."
	"Socket pingPorts: #(7 13 19 21 23 25 80 110 119) on: 'squeak.cs.uiuc.edu' timeOutSecs: 15"

	| serverAddr sockets sock deadline done unconnectedCount connectedCount waitingCount result |
	serverAddr _ NetNameResolver addressForName: hostName timeout: 10.
	serverAddr = nil ifTrue: [
		self inform: 'Could not find an address for ', hostName.
		^ #()].

	sockets _ portList collect: [:portNum |
		sock _ Socket new.
		sock connectTo: serverAddr port: portNum].

	deadline _ self deadlineSecs: timeOutSecs.
	done _ false.
	[done] whileFalse: [
		unconnectedCount _ 0.
		connectedCount _ 0.
		waitingCount _ 0.
		sockets do: [:s |
			s isUnconnectedOrInvalid
				ifTrue: [unconnectedCount _ unconnectedCount + 1]
				ifFalse: [
					s isConnected ifTrue: [connectedCount _ connectedCount + 1].
					s isWaitingForConnection ifTrue: [waitingCount _ waitingCount + 1]]].
		waitingCount = 0 ifTrue: [done _ true].
		connectedCount = sockets size ifTrue: [done _ true].
		Time millisecondClockValue > deadline ifTrue: [done _ true]].

	result _ (sockets select: [:s | s isConnected])
		collect: [:s | self nameForWellKnownTCPPort: s remotePort].
	sockets do: [:s | s destroy].
	^ result

]

{ #category : #utilities }
Socket class >> pingPortsOn: hostName [
	"Attempt to connect to a set of well-known sockets on the given host, and answer the names of the available ports."
	"Socket pingPortsOn: 'www.disney.com'"

	^ Socket
		pingPorts: #(7 13 19 21 23 25 80 110 119)
		on: hostName
		timeOutSecs: 20

]

{ #category : #'network initialization' }
Socket class >> primInitializeNetwork: resolverSemaIndex [
	"Initialize the network drivers on platforms that need it, such as the Macintosh, and return nil if network initialization failed or the reciever if it succeeds. Since mobile computers may not always be connected to a network, this method should NOT be called automatically at startup time; rather, it should be called when first starting a networking application. It is a noop if the network driver has already been initialized. If non-zero, resolverSemaIndex is the index of a VM semaphore to be associated with the network name resolver. This semaphore will be signalled when the resolver status changes, such as when a name lookup query is completed."
	"Note: some platforms (e.g., Mac) only allow only one name lookup query at a time, so a manager process should be used to serialize resolver lookup requests."

	<primitive: 'primitiveInitializeNetwork' module: 'SocketPlugin'>
	^ nil  "return nil if primitive fails"

]

{ #category : #registry }
Socket class >> register: anObject [
	WeakArray isFinalizationSupported ifFalse:[^anObject].
	self registry add: anObject
]

{ #category : #registry }
Socket class >> registry [
	WeakArray isFinalizationSupported ifFalse:[^nil].
	^Registry isNil
		ifTrue:[Registry := WeakRegistry new]
		ifFalse:[Registry].
]

{ #category : #registry }
Socket class >> registryThreshold [
	"Return the registry threshold above which socket creation may fail due to too many already open sockets. If the threshold is reached, a full GC will be issued if the creation of a socket fails."
	^RegistryThreshold
]

{ #category : #registry }
Socket class >> registryThreshold: aNumber [
	"Return the registry threshold above which socket creation may fail due to too many already open sockets. If the threshold is reached, a full GC will be issued if the creation of a socket fails."
	RegistryThreshold _ aNumber
]

{ #category : #utilities }
Socket class >> standardDeadline [
	"Return a default deadline time some seconds into the future."

	^ self deadlineSecs: self standardTimeout

]

{ #category : #utilities }
Socket class >> standardTimeout [

	^45

]

{ #category : #'instance creation' }
Socket class >> tcpCreateIfFail: failBlock [
	"Attempt to create a new socket. If successful, return the new socket. Otherwise, return the result of evaluating the given block. Socket creation can fail if the network isn't available or if there are not sufficient resources available to create another socket."

	| sock |
	self initializeNetwork.
	sock _ super new initialize: TCPSocketType.
	sock isValid ifFalse: [^ failBlock value].
	^ sock

]

{ #category : #'instance creation' }
Socket class >> udpCreateIfFail: failBlock [
	"Attempt to create a new socket. If successful, return the new socket. Otherwise, return the result of evaluating the given block. Socket creation can fail if the network isn't available or if there are not sufficient resources available to create another socket."

	| sock |
	self initializeNetwork.
	sock _ super new initialize: UDPSocketType.
	sock isValid ifFalse: [^ failBlock value].
	^ sock

]

{ #category : #registry }
Socket class >> unregister: anObject [
	WeakArray isFinalizationSupported ifFalse:[^anObject].
	self registry remove: anObject ifAbsent:[]
]

{ #category : #utilities }
Socket class >> wildcardAddress [
	"Answer a don't-care address for use with UDP sockets."

	^ByteArray new: 4		"0.0.0.0"
]

{ #category : #utilities }
Socket class >> wildcardPort [
	"Answer a don't-care port for use with UDP sockets.  (The system will allocate an
	unused port number to the socket.)"

	^0
]

{ #category : #'connection open/close' }
Socket >> accept [
	"Accept a connection from the receiver socket.
	Return a new socket that is connected to the client"
	^Socket acceptFrom: self.
]

{ #category : #'initialize-destroy' }
Socket >> acceptFrom: aSocket [
	"Initialize a new socket handle from an accept call"
	| semaIndex readSemaIndex writeSemaIndex |

	primitiveOnlySupportsOneSemaphore _ false.
	semaphore _ Semaphore new.
	readSemaphore _ Semaphore new.
	writeSemaphore _ Semaphore new.
	semaIndex _ Smalltalk registerExternalObject: semaphore.
	readSemaIndex _ Smalltalk registerExternalObject: readSemaphore.
	writeSemaIndex _ Smalltalk registerExternalObject: writeSemaphore.
	socketHandle _ self primAcceptFrom: aSocket socketHandle
						receiveBufferSize: 8000
						sendBufSize: 8000
						semaIndex: semaIndex
						readSemaIndex: readSemaIndex
						writeSemaIndex: writeSemaIndex.
	socketHandle = nil ifTrue: [  "socket creation failed"
		Smalltalk unregisterExternalObject: semaphore.
		Smalltalk unregisterExternalObject: readSemaphore.
		Smalltalk unregisterExternalObject: writeSemaphore.
		readSemaphore _ writeSemaphore _ semaphore _ nil
	] ifFalse:[self register].

]

{ #category : #accessing }
Socket >> address [
	"Shortcut"
	^self localAddress
]

{ #category : #'connection open/close' }
Socket >> close [
	"Close this connection gracefully. For TCP, this sends a close request, but the stream remains open until the other side also closes it."

	self primSocketCloseConnection: socketHandle.  "close this end"

]

{ #category : #'connection open/close' }
Socket >> closeAndDestroy [
	"First, try to close this connection gracefully. If the close attempt fails or times out, abort the connection. In either case, destroy the socket. Do nothing if the socket has already been destroyed (i.e., if its socketHandle is nil)."

	self closeAndDestroy: 20.


]

{ #category : #'connection open/close' }
Socket >> closeAndDestroy: timeoutSeconds [
	"First, try to close this connection gracefully. If the close attempt fails or times out, abort the connection. In either case, destroy the socket. Do nothing if the socket has already been destroyed (i.e., if its socketHandle is nil)."

	socketHandle = nil
		ifFalse: [
			self isConnected ifTrue: [
				self close.  "close this end"
				(self waitForDisconnectionFor: timeoutSeconds)
					ifFalse: [
						"if the other end doesn't close soon, just abort the connection"
						self primSocketAbortConnection: socketHandle]].
			self destroy].

]

{ #category : #'connection open/close' }
Socket >> connectNonBlockingTo: hostAddress port: port [
	"Initiate a connection to the given port at the given host address. This operation will return immediately; follow it with waitForConnectionUntil: to wait until the connection is established."

	| status |
	self initializeNetwork.
	status _ self primSocketConnectionStatus: socketHandle.
	(status == Unconnected)
		ifFalse: [InvalidSocketStatusException signal: 'Socket status must Unconnected before opening a new connection'].

	self primSocket: socketHandle connectTo: hostAddress port: port.

]

{ #category : #'connection open/close' }
Socket >> connectTo: hostAddress port: port [
	"Initiate a connection to the given port at the given host address.
	Waits until the connection is established or time outs."

	self connectTo: hostAddress port: port waitForConnectionFor: Socket standardTimeout
]

{ #category : #'connection open/close' }
Socket >> connectTo: hostAddress port: port ifTimedOut: aBlock [
	"mp 12/13/2005 13:31"
	"Initiate a connection to the given port at the given host 
	address. Waits until the connection is established or time outs."
	
	self 
		connectTo: hostAddress 
		port: port 
		waitForConnectionFor: self class standardTimeout
		ifTimedOut: aBlock
]

{ #category : #'connection open/close' }
Socket >> connectTo: hostAddress port: port waitForConnectionFor: timeout [ 
	"mp 12/13/2005 13:31"
	"Initiate a connection to the given port at the given host 
	address. Waits until the connection is established or time outs."
	
	self 
		connectTo: hostAddress 
		port: port 
		waitForConnectionFor: timeout
		ifTimedOut: [ConnectionTimedOut signal: 'Cannot connect to '
					, (NetNameResolver stringFromAddress: hostAddress) , ':' , port asString]
]

{ #category : #'connection open/close' }
Socket >> connectTo: hostAddress port: port waitForConnectionFor: timeout ifTimedOut: aBlock [
	"mp 12/13/2005 13:30"
	"Initiate a connection to the given port at the given host 
	address. Waits until the connection is established or time outs."
	
	self connectNonBlockingTo: hostAddress port: port.
	self waitForConnectionFor: timeout ifTimedOut: aBlock
]

{ #category : #'connection open/close' }
Socket >> connectToHostNamed: hostName port: portNumber [
	| serverIP |
	serverIP _ NetNameResolver addressForName: hostName timeout: 20.
	^self connectTo: serverIP port: portNumber

]

{ #category : #queries }
Socket >> dataAvailable [
	"Return true if this socket has unread received data."

	socketHandle == nil ifTrue: [^ false].
	^ self primSocketReceiveDataAvailable: socketHandle

]

{ #category : #'initialize-destroy' }
Socket >> destroy [
	"Destroy this socket. Its connection, if any, is aborted and its resources are freed. Do nothing if the socket has already been destroyed (i.e., if its socketHandle is nil)."

	socketHandle = nil ifFalse: 
		[self isValid ifTrue: [self primSocketDestroy: socketHandle].
		Smalltalk unregisterExternalObject: semaphore.
		Smalltalk unregisterExternalObject: readSemaphore.
		Smalltalk unregisterExternalObject: writeSemaphore.
		socketHandle _ nil.
		readSemaphore _ writeSemaphore _ semaphore _ nil.
		self unregister].

]

{ #category : #receiving }
Socket >> discardReceivedData [
	"Discard any data received up until now, and return the number of bytes discarded."

	| buf totalBytesDiscarded |
	buf _ String new: 10000.
	totalBytesDiscarded _ 0.
	[self isConnected and: [self dataAvailable]] whileTrue: [
		totalBytesDiscarded _
			totalBytesDiscarded + (self receiveDataInto: buf)].
	^ totalBytesDiscarded

]

{ #category : #'connection open/close' }
Socket >> disconnect [
	"Break this connection, no matter what state it is in. Data that has been sent but not received will be lost."

	self primSocketAbortConnection: socketHandle.

]

{ #category : #finalization }
Socket >> finalize [
	self primSocketDestroyGently: socketHandle.
	Smalltalk unregisterExternalObject: semaphore.
	Smalltalk unregisterExternalObject: readSemaphore.
	Smalltalk unregisterExternalObject: writeSemaphore.

]

{ #category : #other }
Socket >> getOption: aName [ 
	"Get options on this socket, see Unix man pages for values for 
	sockets, IP, TCP, UDP. IE SO_KEEPALIVE
	returns an array, element one is an status number (0 ok, -1 read only option)
	element two is the resulting of the requested option"

	(socketHandle == nil or: [self isValid not])
		ifTrue: [InvalidSocketStatusException signal: 'Socket status must valid before getting an option'].
	^self primSocket: socketHandle getOption: aName

"| foo options |
Socket initializeNetwork.
foo _ Socket newTCP.
foo connectTo: (NetNameResolver addressFromString: '192.168.1.1') port: 80.
foo waitForConnectionUntil: (Socket standardDeadline).

options _ {
'SO_DEBUG'. 'SO_REUSEADDR'. 'SO_REUSEPORT'. 'SO_DONTROUTE'.
'SO_BROADCAST'. 'SO_SNDBUF'. 'SO_RCVBUF'. 'SO_KEEPALIVE'.
'SO_OOBINLINE'. 'SO_PRIORITY'. 'SO_LINGER'. 'SO_RCVLOWAT'.
'SO_SNDLOWAT'. 'IP_TTL'. 'IP_HDRINCL'. 'IP_RCVOPTS'.
'IP_RCVDSTADDR'. 'IP_MULTICAST_IF'. 'IP_MULTICAST_TTL'.
'IP_MULTICAST_LOOP'. 'UDP_CHECKSUM'. 'TCP_MAXSEG'.
'TCP_NODELAY'. 'TCP_ABORT_THRESHOLD'. 'TCP_CONN_NOTIFY_THRESHOLD'. 
'TCP_CONN_ABORT_THRESHOLD'. 'TCP_NOTIFY_THRESHOLD'.
'TCP_URGENT_PTR_TYPE'}.

1 to: options size do: [:i | | fum |
	fum _foo getOption: (options at: i).
	Transcript show: (options at: i),fum printString;cr].

foo _ Socket newUDP.
foo setPeer: (NetNameResolver addressFromString: '192.168.1.9') port: 7.
foo waitForConnectionUntil: (Socket standardDeadline).

1 to: options size do: [:i | | fum |
	fum _foo getOption: (options at: i).
	Transcript show: (options at: i),fum printString;cr].
"
]

{ #category : #'initialize-destroy' }
Socket >> initialize: socketType [
	"Initialize a new socket handle. If socket creation fails, socketHandle will be set to nil."
	| semaIndex readSemaIndex writeSemaIndex |

	primitiveOnlySupportsOneSemaphore _ false.
	semaphore _ Semaphore new.
	readSemaphore _ Semaphore new.
	writeSemaphore _ Semaphore new.
	semaIndex _ Smalltalk registerExternalObject: semaphore.
	readSemaIndex _ Smalltalk registerExternalObject: readSemaphore.
	writeSemaIndex _ Smalltalk registerExternalObject: writeSemaphore.
	socketHandle _
		self primSocketCreateNetwork: 0
			type: socketType
			receiveBufferSize: 8000
			sendBufSize: 8000
			semaIndex: semaIndex
			readSemaIndex: readSemaIndex
			writeSemaIndex: writeSemaIndex.

	socketHandle = nil ifTrue: [  "socket creation failed"
		Smalltalk unregisterExternalObject: semaphore.
		Smalltalk unregisterExternalObject: readSemaphore.
		Smalltalk unregisterExternalObject: writeSemaphore.
		readSemaphore _ writeSemaphore _ semaphore _ nil
	] ifFalse:[self register].

]

{ #category : #'initialize-destroy' }
Socket >> initializeNetwork [
	self class initializeNetwork
]

{ #category : #queries }
Socket >> isConnected [
	"Return true if this socket is connected."

	socketHandle == nil ifTrue: [^ false].
	^ (self primSocketConnectionStatus: socketHandle) == Connected

]

{ #category : #queries }
Socket >> isOtherEndClosed [
	"Return true if this socket had the other end closed."

	socketHandle == nil ifTrue: [^ false].
	^ (self primSocketConnectionStatus: socketHandle) == OtherEndClosed

]

{ #category : #queries }
Socket >> isThisEndClosed [
	"Return true if this socket had the this end closed."

	socketHandle == nil ifTrue: [^ false].
	^ (self primSocketConnectionStatus: socketHandle) == ThisEndClosed

]

{ #category : #queries }
Socket >> isUnconnected [
	"Return true if this socket's state is Unconnected."

	socketHandle == nil ifTrue: [^ false].
	^ (self primSocketConnectionStatus: socketHandle) == Unconnected

]

{ #category : #queries }
Socket >> isUnconnectedOrInvalid [
	"Return true if this socket is completely disconnected or is invalid."

	| status |
	socketHandle == nil ifTrue: [^ true].
	status _ self primSocketConnectionStatus: socketHandle.
	^ (status = Unconnected) | (status = InvalidSocket)

]

{ #category : #queries }
Socket >> isValid [
	"Return true if this socket contains a valid, non-nil socket handle."

	| status |
	socketHandle == nil ifTrue: [^ false].
	status _ self primSocketConnectionStatus: socketHandle.
	^ status ~= InvalidSocket

]

{ #category : #queries }
Socket >> isWaitingForConnection [
	"Return true if this socket is waiting for a connection."

	socketHandle == nil ifTrue: [^ false].
	^ (self primSocketConnectionStatus: socketHandle) == WaitingForConnection

]

{ #category : #'connection open/close' }
Socket >> listenOn: port [
	"Listen for a connection on the given port. This operation will return immediately; follow it with waitForConnectionUntil: to wait until a connection is established."

	| status |
	status _ self primSocketConnectionStatus: socketHandle.
	(status == Unconnected)
		ifFalse: [InvalidSocketStatusException signal: 'Socket status must Unconnected before listening for a new connection'].

	self primSocket: socketHandle listenOn: port.

]

{ #category : #'connection open/close' }
Socket >> listenOn: portNumber backlogSize: backlog [
	"Listen for a connection on the given port.
	If this method succeeds, #accept may be used to establish a new connection"
	| status |
	status _ self primSocketConnectionStatus: socketHandle.
	(status == Unconnected)
		ifFalse: [InvalidSocketStatusException signal: 'Socket status must Unconnected before listening for a new connection'].
	self primSocket: socketHandle listenOn: portNumber backlogSize: backlog.

]

{ #category : #'connection open/close' }
Socket >> listenOn: portNumber backlogSize: backlog interface: ifAddr [
	"Listen for a connection on the given port.
	If this method succeeds, #accept may be used to establish a new connection"
	| status |
	status _ self primSocketConnectionStatus: socketHandle.
	(status == Unconnected)
		ifFalse: [InvalidSocketStatusException signal: 'Socket status must Unconnected before listening for a new connection'].
	self primSocket: socketHandle listenOn: portNumber backlogSize: backlog interface: ifAddr.

]

{ #category : #accessing }
Socket >> localAddress [
	self isWaitingForConnection
		ifFalse: [[self waitForConnectionFor: Socket standardTimeout]
				on: ConnectionTimedOut
				do: [:ex | ^ ByteArray new: 4]].
	^ self primSocketLocalAddress: socketHandle
]

{ #category : #accessing }
Socket >> localPort [
	self isWaitingForConnection
		ifFalse: [[self waitForConnectionFor: Socket standardTimeout]
				on: ConnectionTimedOut
				do: [:ex | ^ 0]].
	^ self primSocketLocalPort: socketHandle
]

{ #category : #accessing }
Socket >> peerName [
	"Return the name of the host I'm connected to, or nil if its name isn't known to the domain name server or the request times out."
	"Note: Slow. Calls the domain name server, taking up to 20 seconds to time out. Even when sucessful, delays of up to 13 seconds have been observed during periods of high network load." 

	^ NetNameResolver
		nameForAddress: self remoteAddress
		timeout: 20

]

{ #category : #accessing }
Socket >> port [
	"Shortcut"
	^self localPort
]

{ #category : #primitives }
Socket >> primAcceptFrom: aHandle receiveBufferSize: rcvBufSize sendBufSize: sndBufSize semaIndex: semaIndex [
	"Create and return a new socket handle based on accepting the connection from the given listening socket"
	<primitive: 'primitiveSocketAccept' module: 'SocketPlugin'>
	^self primitiveFailed
]

{ #category : #primitives }
Socket >> primAcceptFrom: aHandle receiveBufferSize: rcvBufSize sendBufSize: sndBufSize semaIndex: semaIndex readSemaIndex: aReadSema writeSemaIndex: aWriteSema [
	"Create and return a new socket handle based on accepting the connection from the given listening socket"
	<primitive: 'primitiveSocketAccept3Semaphores' module: 'SocketPlugin'>
	primitiveOnlySupportsOneSemaphore _ true.
	^self primAcceptFrom: aHandle receiveBufferSize: rcvBufSize sendBufSize: sndBufSize semaIndex: semaIndex 
]

{ #category : #primitives }
Socket >> primSocket: socketID connectTo: hostAddress port: port [
	"Attempt to establish a connection to the given port of the given host. This is an asynchronous call; query the socket status to discover if and when the connection is actually completed."

	<primitive: 'primitiveSocketConnectToPort' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #primitives }
Socket >> primSocket: socketID getOption: aString [ 
	"Get some option information on this socket. Refer to the UNIX 
	man pages for valid SO, TCP, IP, UDP options. In case of doubt
	refer to the source code.
	TCP_NODELAY, SO_KEEPALIVE are valid options for example
	returns an array containing the error code and the option value"

	<primitive: 'primitiveSocketGetOptions' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #primitives }
Socket >> primSocket: socketID listenOn: port [
	"Listen for a connection on the given port. This is an asynchronous call; query the socket status to discover if and when the connection is actually completed."

	<primitive: 'primitiveSocketListenWithOrWithoutBacklog' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #primitives }
Socket >> primSocket: aHandle listenOn: portNumber backlogSize: backlog [
	"Primitive. Set up the socket to listen on the given port.
	Will be used in conjunction with #accept only."
	<primitive: 'primitiveSocketListenWithOrWithoutBacklog' module: 'SocketPlugin'>
	self destroy. "Accept not supported so clean up"
]

{ #category : #primitives }
Socket >> primSocket: aHandle listenOn: portNumber backlogSize: backlog interface: ifAddr [
	"Primitive. Set up the socket to listen on the given port.
	Will be used in conjunction with #accept only."
	<primitive: 'primitiveSocketListenOnPortBacklogInterface' module: 'SocketPlugin'>
	self destroy. "Accept not supported so clean up"
]

{ #category : #primitives }
Socket >> primSocket: socketID receiveDataInto: aStringOrByteArray startingAt: startIndex count: count [
	"Receive data from the given socket into the given array starting at the given index. Return the number of bytes read or zero if no data is available."

	<primitive: 'primitiveSocketReceiveDataBufCount' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #primitives }
Socket >> primSocket: socketID receiveUDPDataInto: aStringOrByteArray startingAt: startIndex count: count [
	"Receive data from the given socket into the given array starting at the given index. 
	Return an Array containing the amount read, the host address byte array, the host port, and the more flag"

	<primitive: 'primitiveSocketReceiveUDPDataBufCount' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #primitives }
Socket >> primSocket: socketID sendData: aStringOrByteArray startIndex: startIndex count: count [
	"Send data to the remote host through the given socket starting with the given byte index of the given byte array. The data sent is 'pushed' immediately. Return the number of bytes of data actually sent; any remaining data should be re-submitted for sending after the current send operation has completed."
	"Note: In general, it many take several sendData calls to transmit a large data array since the data is sent in send-buffer-sized chunks. The size of the send buffer is determined when the socket is created."

	<primitive: 'primitiveSocketSendDataBufCount' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #primitives }
Socket >> primSocket: socketID sendUDPData: aStringOrByteArray toHost: hostAddress  port: portNumber startIndex: startIndex count: count [
	"Send data to the remote host through the given socket starting with the given byte index of the given byte array. The data sent is 'pushed' immediately. Return the number of bytes of data actually sent; any remaining data should be re-submitted for sending after the current send operation has completed."
	"Note: In general, it many take several sendData calls to transmit a large data array since the data is sent in send-buffer-sized chunks. The size of the send buffer is determined when the socket is created."

	<primitive:  'primitiveSocketSendUDPDataBufCount' module: 'SocketPlugin'>
	self primitiveFailed


]

{ #category : #primitives }
Socket >> primSocket: socketID setOption: aString value: aStringValue [
	"Set some option information on this socket. Refer to the UNIX 
	man pages for valid SO, TCP, IP, UDP options. In case of doubt
	refer to the source code.
	TCP_NODELAY, SO_KEEPALIVE are valid options for example
	returns an array containing the error code and the negotiated value"

	<primitive: 'primitiveSocketSetOptions' module: 'SocketPlugin'>
	^nil
]

{ #category : #primitives }
Socket >> primSocket: socketID setPort: port [
	"Set the local port associated with a UDP socket.
	Note: this primitive is overloaded.  The primitive will not fail on a TCP socket, but
	the effects will not be what was desired.  Best solution would be to split Socket into
	two subclasses, TCPSocket and UDPSocket."

	<primitive: 'primitiveSocketListenWithOrWithoutBacklog' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #primitives }
Socket >> primSocketAbortConnection: socketID [
	"Terminate the connection on the given port immediately without going through the normal close sequence. This is an asynchronous call; query the socket status to discover if and when the connection is actually terminated."

	<primitive: 'primitiveSocketAbortConnection' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #primitives }
Socket >> primSocketCloseConnection: socketID [
	"Close the connection on the given port. The remote end is informed that this end has closed and will do no further sends. This is an asynchronous call; query the socket status to discover if and when the connection is actually closed."

	<primitive: 'primitiveSocketCloseConnection' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #primitives }
Socket >> primSocketConnectionStatus: socketID [
	"Return an integer reflecting the connection status of this socket. For a list of possible values, see the comment in the 'initialize' method of this class. If the primitive fails, return a status indicating that the socket handle is no longer valid, perhaps because the Squeak image was saved and restored since the socket was created. (Sockets do not survive snapshots.)"

	<primitive: 'primitiveSocketConnectionStatus' module: 'SocketPlugin'>
	^ InvalidSocket

]

{ #category : #primitives }
Socket >> primSocketCreateNetwork: netType type: socketType receiveBufferSize: rcvBufSize sendBufSize: sendBufSize semaIndex: semaIndex [
	"Return a new socket handle for a socket of the given type and buffer sizes. Return nil if socket creation fails.
	The netType parameter is platform dependent and can be used to encode both the protocol type (IP, Xerox XNS, etc.) and/or the physical network interface to use if this host is connected to multiple networks. A zero netType means to use IP protocols and the primary (or only) network interface.
	The socketType parameter specifies:
		0	reliable stream socket (TCP if the protocol is IP)
		1	unreliable datagram socket (UDP if the protocol is IP)
	The buffer size parameters allow performance to be tuned to the application. For example, a larger receive buffer should be used when the application expects to be receiving large amounts of data, especially from a host that is far away. These values are considered requests only; the underlying implementation will ensure that the buffer sizes actually used are within allowable bounds. Note that memory may be limited, so an application that keeps many sockets open should use smaller buffer sizes. Note the macintosh implementation ignores this buffer size. Also see setOption to get/set socket buffer sizes which allows you to set/get the current buffer sizes for reading and writing.
 	If semaIndex is > 0, it is taken to be the index of a Semaphore in the external objects array to be associated with this socket. This semaphore will be signalled when the socket status changes, such as when data arrives or a send completes. All processes waiting on the semaphore will be awoken for each such event; each process must then query the socket state to figure out if the conditions they are waiting for have been met. For example, a process waiting to send some data can see if the last send has completed."

	<primitive: 'primitiveSocketCreate' module: 'SocketPlugin'>
	^ nil  "socket creation failed"

]

{ #category : #primitives }
Socket >> primSocketCreateNetwork: netType type: socketType receiveBufferSize: rcvBufSize sendBufSize: sendBufSize semaIndex: semaIndex readSemaIndex: aReadSema writeSemaIndex: aWriteSema [
	"See comment in primSocketCreateNetwork: with one semaIndex. However you should know that some implementations
	ignore the buffer size and this interface supports three semaphores,  one for open/close/listen and the other two for
	reading and writing"

	<primitive: 'primitiveSocketCreate3Semaphores' module: 'SocketPlugin'>
	primitiveOnlySupportsOneSemaphore _ true.
	^ self primSocketCreateNetwork: netType
			type: socketType
			receiveBufferSize: rcvBufSize
			sendBufSize: sendBufSize
			semaIndex: semaIndex
]

{ #category : #primitives }
Socket >> primSocketDestroy: socketID [
	"Release the resources associated with this socket. If a connection is open, it is aborted."

	<primitive: 'primitiveSocketDestroy' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #primitives }
Socket >> primSocketDestroyGently: socketID [
	"Release the resources associated with this socket. If a connection is open, it is aborted.
	Do not fail if the receiver is already closed."

	<primitive: 'primitiveSocketDestroy' module: 'SocketPlugin'>

]

{ #category : #primitives }
Socket >> primSocketError: socketID [
	"Return an integer encoding the most recent error on this socket. Zero means no error."

	<primitive: 'primitiveSocketError' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #primitives }
Socket >> primSocketLocalAddress: socketID [
	"Return the local host address for this socket."

	<primitive: 'primitiveSocketLocalAddress' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #primitives }
Socket >> primSocketLocalPort: socketID [
	"Return the local port for this socket, or zero if no port has yet been assigned."

	<primitive: 'primitiveSocketLocalPort' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #primitives }
Socket >> primSocketReceiveDataAvailable: socketID [
	"Return true if data may be available for reading from the current socket."

	<primitive: 'primitiveSocketReceiveDataAvailable' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #primitives }
Socket >> primSocketRemoteAddress: socketID [
	"Return the remote host address for this socket, or zero if no connection has been made."

	<primitive: 'primitiveSocketRemoteAddress' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #primitives }
Socket >> primSocketRemotePort: socketID [
	"Return the remote port for this socket, or zero if no connection has been made."

	<primitive: 'primitiveSocketRemotePort' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #primitives }
Socket >> primSocketSendDone: socketID [
	"Return true if there is no send in progress on the current socket."

	<primitive: 'primitiveSocketSendDone' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #accessing }
Socket >> primitiveOnlySupportsOneSemaphore [
	^primitiveOnlySupportsOneSemaphore
]

{ #category : #printing }
Socket >> printOn: aStream [

	super printOn: aStream.
	aStream nextPutAll: '[', self statusString, ']'.

]

{ #category : #accessing }
Socket >> readSemaphore [
	primitiveOnlySupportsOneSemaphore ifTrue: [^semaphore].
	^readSemaphore
]

{ #category : #receiving }
Socket >> receiveAvailableData [
	"Receive all available data (if any). Do not wait."
 
	| buffer bytesRead |
	buffer _ String new: 2000.
	bytesRead _ self receiveAvailableDataInto: buffer.
	^buffer copyFrom: 1 to: bytesRead
]

{ #category : #receiving }
Socket >> receiveAvailableDataInto: buffer [
	"Receive all available data into the given buffer and return the number of bytes received.
	Note the given buffer may be only partially filled by the received data.
	Do not wait for data."

	^self receiveAvailableDataInto: buffer startingAt: 1
]

{ #category : #receiving }
Socket >> receiveAvailableDataInto: buffer startingAt: startIndex [
	"Receive all available data into the given buffer and return the number of bytes received.
	Note the given buffer may be only partially filled by the received data.
	Do not wait for data."

	| bufferPos bytesRead |
	bufferPos := startIndex.
	bytesRead := 0.
	[self dataAvailable
		and: [bufferPos-1 < buffer size]] 
		whileTrue: [
			bytesRead := self receiveSomeDataInto: buffer startingAt: bufferPos.
			bufferPos := bufferPos + bytesRead].
	^bufferPos - startIndex
]

{ #category : #receiving }
Socket >> receiveData [
	"Receive data into the given buffer and return the number of bytes received. 
	Note the given buffer may be only partially filled by the received data.
	Waits for data once.
	Either returns data or signals a time out or connection close."

	| buffer bytesRead |
	buffer _ String new: 2000.
	bytesRead _ self receiveDataInto: buffer.
	^buffer copyFrom: 1 to: bytesRead
]

{ #category : #receiving }
Socket >> receiveDataInto: aStringOrByteArray [
	"Receive data into the given buffer and return the number of bytes received. 
	Note the given buffer may be only partially filled by the received data.
	Waits for data once.
	Either returns data or signals a time out or connection close."

	^self receiveDataInto: aStringOrByteArray startingAt: 1
]

{ #category : #datagrams }
Socket >> receiveDataInto: aStringOrByteArray fromHost: hostAddress port: portNumber [
	| datagram |
	"Receive a UDP packet from the given hostAddress/portNumber, storing the data in the given buffer, and return the number of bytes received. Note the given buffer may be only partially filled by the received data."

	primitiveOnlySupportsOneSemaphore ifTrue:
		[self setPeer: hostAddress port: portNumber.
		^self receiveDataInto: aStringOrByteArray].
	[true] whileTrue: 
		[datagram _ self receiveUDPDataInto: aStringOrByteArray.
		((datagram at: 2) = hostAddress and: [(datagram at: 3) = portNumber]) 
			ifTrue: [^datagram at: 1]
			ifFalse: [^0]]
]

{ #category : #receiving }
Socket >> receiveDataInto: aStringOrByteArray startingAt: aNumber [
	"Receive data into the given buffer and return the number of bytes received. 
	Note the given buffer may be only partially filled by the received data.
	Waits for data once.  The answer may be zero (indicating that no data was 
	available before the socket closed)."

	| bytesRead closed |
	bytesRead := 0.
	closed := false.
	[closed not and: [bytesRead == 0]]
		whileTrue: [
			self waitForDataIfClosed: [closed := true].
			bytesRead := self primSocket: socketHandle
				receiveDataInto: aStringOrByteArray
				startingAt: aNumber
				count: aStringOrByteArray size-aNumber+1].
	^bytesRead

]

{ #category : #receiving }
Socket >> receiveDataTimeout: timeout [
	"Receive data into the given buffer and return the number of bytes received. 
	Note the given buffer may be only partially filled by the received data.
	Waits for data once."

	| buffer bytesRead |
	buffer _ String new: 2000.
	bytesRead _ self receiveDataTimeout: timeout into: buffer.
	^buffer copyFrom: 1 to: bytesRead
]

{ #category : #receiving }
Socket >> receiveDataTimeout: timeout into: aStringOrByteArray [ 
	"Receive data into the given buffer and return the number of bytes received. 
	Note the given buffer may be only partially filled by the received data.
	Waits for data once."

	^self receiveDataTimeout: timeout into: aStringOrByteArray startingAt: 1
]

{ #category : #receiving }
Socket >> receiveDataTimeout: timeout into: aStringOrByteArray startingAt: aNumber [
	"Receive data into the given buffer and return the number of bytes received. 
	Note the given buffer may be only partially filled by the received data.
	Wait for data once for the specified nr of seconds.  The answer may be 
	zero (indicating that there was no data available within the given timeout)."

	self waitForDataFor: timeout ifClosed: [] ifTimedOut: [].
	^self primSocket: socketHandle
		receiveDataInto: aStringOrByteArray
		startingAt: aNumber
		count: aStringOrByteArray size-aNumber+1

]

{ #category : #receiving }
Socket >> receiveDataWithTimeout [
	"Receive data into the given buffer and return the number of bytes received. 
	Note the given buffer may be only partially filled by the received data.
	Waits for data once.
	Either returns data or signals a time out or connection close."

	| buffer bytesRead |
	buffer _ String new: 2000.
	bytesRead _ self receiveDataWithTimeoutInto: buffer.
	^buffer copyFrom: 1 to: bytesRead
]

{ #category : #receiving }
Socket >> receiveDataWithTimeoutInto: aStringOrByteArray [
	"Receive data into the given buffer and return the number of bytes received. 
	Note the given buffer may be only partially filled by the received data.
	Waits for data once.
	Either returns data or signals a time out or connection close."

	^self receiveDataWithTimeoutInto: aStringOrByteArray startingAt: 1
]

{ #category : #receiving }
Socket >> receiveDataWithTimeoutInto: aStringOrByteArray startingAt: aNumber [
	"Receive data into the given buffer and return the number of bytes received. 
	Note the given buffer may be only partially filled by the received data.
	Waits for data once."

	^self receiveDataTimeout: Socket standardTimeout into: aStringOrByteArray startingAt: aNumber 

]

{ #category : #receiving }
Socket >> receiveSomeData [
	"Receive currently available data (if any). Do not wait."
 
	| buffer bytesRead |
	buffer _ String new: 2000.
	bytesRead _ self receiveSomeDataInto: buffer.
	^buffer copyFrom: 1 to: bytesRead
]

{ #category : #receiving }
Socket >> receiveSomeDataInto: aStringOrByteArray [
	"Receive data into the given buffer and return the number of bytes received. Note the given buffer may be only partially filled by the received data."

	^self receiveSomeDataInto: aStringOrByteArray startingAt: 1
]

{ #category : #receiving }
Socket >> receiveSomeDataInto: aStringOrByteArray startingAt: aNumber [
	"Receive data into the given buffer and return the number of bytes received. Note the given buffer may be only partially filled by the received data."

	^ self primSocket: socketHandle
		receiveDataInto: aStringOrByteArray
		startingAt: aNumber
		count: aStringOrByteArray size-aNumber+1

]

{ #category : #datagrams }
Socket >> receiveUDPDataInto: aStringOrByteArray [
	"Receive UDP data into the given buffer and return the number of bytes received. Note the given buffer may be only partially filled by the received data. What is returned is an array, the first element is the bytes read, the second the sending bytearray address, the third the senders port, the fourth, true if more of the datagram awaits reading"

	^ self primSocket: socketHandle
		receiveUDPDataInto: aStringOrByteArray
		startingAt: 1
		count: aStringOrByteArray size

]

{ #category : #registry }
Socket >> register [
	^self class register: self
]

{ #category : #accessing }
Socket >> remoteAddress [

	^ self primSocketRemoteAddress: socketHandle

]

{ #category : #accessing }
Socket >> remotePort [

	^ self primSocketRemotePort: socketHandle

]

{ #category : #accessing }
Socket >> semaphore [
	^semaphore
]

{ #category : #sending }
Socket >> sendData: aStringOrByteArray [
	"Send all of the data in the given array, even if it requires multiple calls to send it all. Return the number of bytes sent."

	"An experimental version use on slow lines: Longer timeout and smaller writes to try to avoid spurious timeouts."

	| bytesSent bytesToSend count |
	bytesToSend := aStringOrByteArray size.
	bytesSent := 0.
	[bytesSent < bytesToSend] whileTrue: [
		(self waitForSendDoneFor: 60)
			ifFalse: [ConnectionTimedOut signal: 'send data timeout; data not sent'].
		count := self primSocket: socketHandle
			sendData: aStringOrByteArray
			startIndex: bytesSent + 1
			count: (bytesToSend - bytesSent min: 5000).
		bytesSent := bytesSent + count].

	^ bytesSent
]

{ #category : #sending }
Socket >> sendData: buffer count: n [
	"Send the amount of data from the given buffer"
	| sent |
	sent _ 0.
	[sent < n] whileTrue:[
		sent _ sent + (self sendSomeData: buffer startIndex: sent+1 count: (n-sent))].
]

{ #category : #datagrams }
Socket >> sendData: aStringOrByteArray toHost: hostAddress port: portNumber [
	"Send a UDP packet containing the given data to the specified host/port."

	primitiveOnlySupportsOneSemaphore ifTrue:
		[self setPeer: hostAddress port: portNumber.
		^self sendData: aStringOrByteArray].
	^self sendUDPData: aStringOrByteArray toHost: hostAddress port: portNumber
]

{ #category : #queries }
Socket >> sendDone [
	"Return true if the most recent send operation on this socket has completed."

	socketHandle == nil ifTrue: [^ false].
	^ self primSocketSendDone: socketHandle

]

{ #category : #sending }
Socket >> sendSomeData: aStringOrByteArray [
	"Send as much of the given data as possible and answer the number of bytes actually sent."
	"Note: This operation may have to be repeated multiple times to send a large amount of data."

	^ self
		sendSomeData: aStringOrByteArray
		startIndex: 1
		count: aStringOrByteArray size
]

{ #category : #sending }
Socket >> sendSomeData: aStringOrByteArray startIndex: startIndex [
	"Send as much of the given data as possible starting at the given index. Answer the number of bytes actually sent."
	"Note: This operation may have to be repeated multiple times to send a large amount of data."

	^ self
		sendSomeData: aStringOrByteArray
		startIndex: startIndex
		count: (aStringOrByteArray size - startIndex + 1)
]

{ #category : #sending }
Socket >> sendSomeData: aStringOrByteArray startIndex: startIndex count: count [
	"Send up to count bytes of the given data starting at the given index. Answer the number of bytes actually sent."
	"Note: This operation may have to be repeated multiple times to send a large amount of data."

	| bytesSent |
	(self waitForSendDoneFor: 20)
		ifTrue: [
			bytesSent _ self primSocket: socketHandle
				sendData: aStringOrByteArray
				startIndex: startIndex
				count: count]
		ifFalse: [ConnectionTimedOut signal: 'send data timeout; data not sent'].
	^ bytesSent

]

{ #category : #sending }
Socket >> sendStreamContents: stream [
	"Send the data in the stream. Close the stream.
	Usefull for directly sending contents of a file without reading into memory first."

	self sendStreamContents: stream checkBlock: [true]
]

{ #category : #sending }
Socket >> sendStreamContents: stream checkBlock: checkBlock [
	"Send the data in the stream. Close the stream after you are done. After each block of data evaluate checkBlock and abort if it returns false.
	Usefull for directly sending contents of a file without reading into memory first."

	| chunkSize buffer |
	chunkSize _ 5000.
	buffer _ ByteArray new: chunkSize.
	stream binary.
	[[stream atEnd and: [checkBlock value]]
		whileFalse: [
			buffer _ stream next: chunkSize into: buffer.
			self sendData: buffer]]
		ensure: [stream close]
]

{ #category : #datagrams }
Socket >> sendUDPData: aStringOrByteArray toHost: hostAddress port: portNumber [
	"Send a UDP packet containing the given data to the specified host/port."
	| bytesToSend bytesSent count |

	bytesToSend _ aStringOrByteArray size.
	bytesSent _ 0.
	[bytesSent < bytesToSend] whileTrue: [
		(self waitForSendDoneFor: 20)
			ifFalse: [ConnectionTimedOut signal: 'send data timeout; data not sent'].
		count _ self primSocket: socketHandle
			sendUDPData: aStringOrByteArray
			toHost: hostAddress
			port: portNumber
			startIndex: bytesSent + 1
			count: bytesToSend - bytesSent.
		bytesSent _ bytesSent + count].

	^ bytesSent

]

{ #category : #other }
Socket >> setOption: aName value: aValue [ 
	| value |
	"setup options on this socket, see Unix man pages for values for 
	sockets, IP, TCP, UDP. IE SO_KEEPALIVE
	returns an array, element one is the error number
	element two is the resulting of the negotiated value.
	See getOption for list of keys"

	(socketHandle == nil or: [self isValid not])
		ifTrue: [InvalidSocketStatusException signal: 'Socket status must valid before setting an option'].
	value _ aValue asString.
	aValue == true ifTrue: [value _ '1'].
	aValue == false ifTrue: [value _ '0'].
	^ self primSocket: socketHandle setOption: aName value: value
]

{ #category : #datagrams }
Socket >> setPeer: hostAddress port: port [
	"Set the default send/recv address."

	self primSocket: socketHandle connectTo: hostAddress port: port.

]

{ #category : #datagrams }
Socket >> setPort: port [
	"Associate a local port number with a UDP socket.  Not applicable to TCP sockets."

	self primSocket: socketHandle setPort: port.

]

{ #category : #queries }
Socket >> socketError [
	^self primSocketError: socketHandle
]

{ #category : #accessing }
Socket >> socketHandle [
	^socketHandle
]

{ #category : #queries }
Socket >> statusString [
	"Return a string describing the status of this socket."

	| status |
	socketHandle == nil ifTrue: [^ 'destroyed'].
	status _ self primSocketConnectionStatus: socketHandle.
	status = InvalidSocket ifTrue: [^ 'invalidSocketHandle'].
	status = Unconnected ifTrue: [^ 'unconnected'].
	status = WaitingForConnection ifTrue: [^ 'waitingForConnection'].
	status = Connected ifTrue: [^ 'connected'].
	status = OtherEndClosed ifTrue: [^ 'otherEndClosedButNotThisEnd'].
	status = ThisEndClosed ifTrue: [^ 'thisEndClosedButNotOtherEnd'].
	^ 'unknown socket status'

]

{ #category : #registry }
Socket >> unregister [
	^self class unregister: self
]

{ #category : #waiting }
Socket >> waitForAcceptFor: timeout [
	"Wait and accept an incoming connection"
	self waitForConnectionFor: timeout.
	^self accept
]

{ #category : #waiting }
Socket >> waitForAcceptFor: timeout ifTimedOut: timeoutBlock [
	"Wait and accept an incoming connection"
	self waitForConnectionFor: timeout ifTimedOut: [^timeoutBlock value].
	^self accept
]

{ #category : #waiting }
Socket >> waitForConnectionFor: timeout [
	"Wait up until the given deadline for a connection to be established. Return true if it is established by the deadline, false if not."

	^self 
		waitForConnectionFor: timeout 
		ifTimedOut: [ConnectionTimedOut signal: 'Failed to connect in ', timeout asString, ' seconds']

]

{ #category : #waiting }
Socket >> waitForConnectionFor: timeout ifTimedOut: timeoutBlock [
	"Wait up until the given deadline for a connection to be established. Return true if it is established by the deadline, false if not."

	| status deadline |
	deadline := Socket deadlineSecs: timeout.
	status _ self primSocketConnectionStatus: socketHandle.
	[(status = WaitingForConnection) and: [Time millisecondClockValue < deadline]]
		whileTrue: [
			semaphore waitTimeoutMSecs: (deadline - Time millisecondClockValue).
			status _ self primSocketConnectionStatus: socketHandle].

	status = Connected ifFalse: [^timeoutBlock value]

]

{ #category : #waiting }
Socket >> waitForData [
	"Wait for data to arrive.  This method will block until
	data is available or the socket is closed.  If the socket is closed
	a ConnectionClosed exception will be signaled."

	^self waitForDataIfClosed:
		[ConnectionClosed signal: 'Connection close while waiting for data.']
]

{ #category : #waiting }
Socket >> waitForDataFor: timeout [
	"Wait for the given nr of seconds for data to arrive.
	Signal a time out or connection close exception if either happens before data becomes available."

	^self
		waitForDataFor: timeout
		ifClosed: [ConnectionClosed signal: 'Connection closed while waiting for data.']
		ifTimedOut: [ConnectionTimedOut signal: 'Data receive timed out.']

]

{ #category : #waiting }
Socket >> waitForDataFor: timeout ifClosed: closedBlock ifTimedOut: timedOutBlock [
	"Wait for the given nr of seconds for data to arrive."

	| deadline |
	deadline := Socket deadlineSecs: timeout.

	[Time millisecondClockValue < deadline]
		whileTrue: [
			(self primSocketReceiveDataAvailable: socketHandle)
				ifTrue: [^self].
			self isConnected
				ifFalse: [^closedBlock value].
			self readSemaphore waitTimeoutMSecs: (deadline - Time millisecondClockValue)].

	(self primSocketReceiveDataAvailable: socketHandle)
		ifFalse: [
			self isConnected
				ifTrue: [^timedOutBlock value]
				ifFalse: [^closedBlock value]]
]

{ #category : #waiting }
Socket >> waitForDataIfClosed: closedBlock [
	"Wait indefinitely for data to arrive.  This method will block until
	data is available or the socket is closed."

	[true]
		whileTrue: [
			(self primSocketReceiveDataAvailable: socketHandle)
				ifTrue: [^self].
			self isConnected
				ifFalse: [^closedBlock value].
			self readSemaphore wait].

]

{ #category : #waiting }
Socket >> waitForDisconnectionFor: timeout [
	"Wait up until the given deadline for the the connection to be broken. Return true if it is broken by the deadline, false if not."
	"Note: The client should know the the connect is really going to be closed (e.g., because he has called 'close' to send a close request to the other end) before calling this method.
JMM 00/5/17 note that other end can close which will terminate wait"

	| extraBytes status deadline |
	extraBytes _ 0.
	status _ self primSocketConnectionStatus: socketHandle.
	deadline := Socket deadlineSecs: timeout.
	[((status = Connected) or: [(status = ThisEndClosed)]) and:
	 [Time millisecondClockValue < deadline]] whileTrue: [
		self dataAvailable
			ifTrue: [extraBytes _ extraBytes + self discardReceivedData].
		semaphore waitTimeoutMSecs: (deadline - Time millisecondClockValue).
		status _ self primSocketConnectionStatus: socketHandle].

	^ status ~= Connected

]

{ #category : #waiting }
Socket >> waitForSendDoneFor: timeout [
	"Wait up until the given deadline for the current send operation to complete. Return true if it completes by the deadline, false if not."

	| sendDone deadline |
	deadline := Socket deadlineSecs: timeout.
	[self isConnected & (sendDone _ self primSocketSendDone: socketHandle) not
			"Connection end and final data can happen fast, so test in this order"
		and: [Time millisecondClockValue < deadline]] whileTrue: [
			self writeSemaphore waitTimeoutMSecs: (deadline - Time millisecondClockValue)].

	^ sendDone
]

{ #category : #accessing }
Socket >> writeSemaphore [
	primitiveOnlySupportsOneSemaphore ifTrue: [^semaphore].
	^writeSemaphore
]
