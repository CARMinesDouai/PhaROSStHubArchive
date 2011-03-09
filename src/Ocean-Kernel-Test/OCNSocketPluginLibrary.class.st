Class {
	#name : #OCNSocketPluginLibrary,
	#superclass : #Object,
	#instVars : [
		'semaphore',
		'semaIndex',
		'readSemaphore',
		'writeSemaphore',
		'readSemaIndex',
		'writeSemaIndex'
	],
	#classVars : [
		'Connected',
		'InvalidSocket',
		'OtherEndClosed',
		'ResolverSemaphore',
		'TCPSocketType',
		'ThisEndClosed',
		'UDPSocketType',
		'Unconnected',
		'WaitingForConnection'
	],
	#classInstVars : [
		'default'
	],
	#category : #'Ocean-Libraries-Plugin'
}

{ #category : #initialization }
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

{ #category : #'name resolving' }
OCNSocketPluginLibrary >> addressForName: nameToLookup addressFamily: addressFamily [

	 | addressSize  byteInfoSize byteInfo stringAddress addressTypeConstants |
	
	self ensureNetworkInitialized.
	
	[self primGetAddressInfoHost: nameToLookup  service: '' flags: 0 family: addressFamily type: 1 protocol: 1] on: Error do: [
		OCNNameLookupError signal: 'Can not resolve ', nameToLookup asString
	].
 	
	byteInfoSize := self primGetAddressInfoSize.
	byteInfo := ByteArray new: byteInfoSize.
	self primGetAddressInfoResult: byteInfo.

	self primGetNameInfo: byteInfo flags: 1.
	
	addressSize := self primGetNameInfoHostSize.
	stringAddress := String new: addressSize.
	self primGetNameInfoHostResult:  stringAddress.

	^ stringAddress	
	

]

{ #category : #'name resolving' }
OCNSocketPluginLibrary >> addressesForName: nameToLookup addressFamily: addressFamily [

	 | allAddresses  byteInfoSize |

	allAddresses := Set new.

	self ensureNetworkInitialized.
	[self primGetAddressInfoHost: nameToLookup  service: '' flags: 0 family: addressFamily type: 1 protocol: 1] on: Error do: [
		OCNNameLookupError signal: 'Can not resolve ', nameToLookup asString
	].
	
	[byteInfoSize := self primGetAddressInfoSize. 
		byteInfoSize > 0] whileTrue: [
		| addressSize  byteInfo stringAddress |
		
			byteInfo := ByteArray new: byteInfoSize.
			self primGetAddressInfoResult: byteInfo.  
			
			self primGetNameInfo: byteInfo flags: 1.
	
			addressSize := self primGetNameInfoHostSize.
			stringAddress := String new: addressSize.
			self primGetNameInfoHostResult:  stringAddress.

			allAddresses add: stringAddress.
			self primGetAddressInfoNext
	]. 
	
	^ allAddresses
]

{ #category : #'name resolving' }
OCNSocketPluginLibrary >> allAddressFamily [
	^0
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

{ #category : #converting }
OCNSocketPluginLibrary >> convertIpv4StringAddressToByteArray: stringAddress [
	^((stringAddress subStrings: '.')  collect: [ :string | string asInteger]) asByteArray
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

{ #category : #'UDP API' }
OCNSocketPluginLibrary >> createUdpSocketDescriptorId [
	
	| socketId  |
	
	semaphore := Semaphore new.
	readSemaphore := Semaphore new.
	writeSemaphore := Semaphore new.
	
	semaIndex := Smalltalk registerExternalObject: semaphore.
	readSemaIndex := Smalltalk registerExternalObject: readSemaphore.
	writeSemaIndex := Smalltalk registerExternalObject: writeSemaphore.
	
	socketId := self primSocketCreateNetwork: 0
			type: UDPSocketType
			receiveBufferSize: 8000
			sendBufSize: 8000
			semaIndex: semaIndex
			readSemaIndex: readSemaIndex
			writeSemaIndex: writeSemaIndex.
	
	
	socketId ifNotNil: [ 
		self halt: 'I do not understand this line'.
		(self primSocketConnectionStatus: socketId) = Unconnected ifTrue: [ ^socketId ] 
	].

	OCNSocketOperationFailureError signal: 'Socket creation failure'
]

{ #category : #accessing }
OCNSocketPluginLibrary >> defaultDataBufferSize [
	^2000
]

{ #category : #'initialize-release' }
OCNSocketPluginLibrary >> ensureNetworkInitialized [
	"Initialize the network drivers and record the semaphore to be used by the resolver. Do nothing if the network is already initialized. Evaluate the given block if network initialization fails."
	"NetNameResolver initializeNetwork"

	| semaphoreIndex |
	self primNameResolverStatus = self resolverUninitializedCode
		ifFalse: [^self].  "network is already initialized"

	ResolverSemaphore := Semaphore new.
	semaphoreIndex := Smalltalk registerExternalObject: ResolverSemaphore.

	"result is nil if network initialization failed, self if it succeeds"
	(self primInitializeNetwork: semaphoreIndex)
		ifNil: [OCNNetworkInitializationFailedError signal: 'failed network initialization']
]

{ #category : #'name resolving' }
OCNSocketPluginLibrary >> ipv4 [
	^2
]

{ #category : #'NameResolving API' }
OCNSocketPluginLibrary >> ipv4AddressForName: nameToLookup [
	
	^ self addressForName: nameToLookup addressFamily: self ipv4
	
]

{ #category : #'NameResolving API' }
OCNSocketPluginLibrary >> ipv4AddressesForName: nameToLookup [

	^self addressesForName: nameToLookup  addressFamily:  self ipv4
]

{ #category : #'name resolving' }
OCNSocketPluginLibrary >> ipv6 [ 
	^3
]

{ #category : #'NameResolving API' }
OCNSocketPluginLibrary >> ipv6AddressForName: nameToLookup [
	
	^ self addressForName: nameToLookup addressFamily: self ipv6
	
	

]

{ #category : #'NameResolving API' }
OCNSocketPluginLibrary >> ipv6AddressesForName: nameToLookup [
	
	^self addressesForName: nameToLookup  addressFamily:  self ipv6
]

{ #category : #'name resolving' }
OCNSocketPluginLibrary >> localAddressFamily [
	^1
]

{ #category : #'NameResolving API' }
OCNSocketPluginLibrary >> localHostName [
	
	|  hostname |

	hostname := String new: self primHostNameSize.
	self primHostNameResult: hostname.  
	
	^hostname
]

{ #category : #'primitives from old netnameresolver' }
OCNSocketPluginLibrary >> primAbortLookup [
	"Abort the current lookup operation, freeing the name resolver for the next query."

	<primitive: 'primitiveResolverAbortLookup' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #'primitives from old netnameresolver' }
OCNSocketPluginLibrary >> primAddressLookupResult [
	"Return the host name found by the last host address lookup. Returns nil if the last lookup was unsuccessful."

	<primitive: 'primitiveResolverAddressLookupResult' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #'primitives from old netnameresolver IPV6' }
OCNSocketPluginLibrary >> primGetAddressInfoFamily [

	<primitive: 'primitiveResolverGetAddressInfoFamily' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #'primitives from old netnameresolver IPV6' }
OCNSocketPluginLibrary >> primGetAddressInfoHost: hostName service: servName flags: flags family: family type: type protocol: protocol [

	<primitive: 'primitiveResolverGetAddressInfo' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #'primitives from old netnameresolver IPV6' }
OCNSocketPluginLibrary >> primGetAddressInfoNext [

	<primitive: 'primitiveResolverGetAddressInfoNext' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #'primitives from old netnameresolver IPV6' }
OCNSocketPluginLibrary >> primGetAddressInfoProtocol [

	<primitive: 'primitiveResolverGetAddressInfoProtocol' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #'primitives from old netnameresolver IPV6' }
OCNSocketPluginLibrary >> primGetAddressInfoResult: socketAddress [

	<primitive: 'primitiveResolverGetAddressInfoResult' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #'primitives from old netnameresolver IPV6' }
OCNSocketPluginLibrary >> primGetAddressInfoSize [

	<primitive: 'primitiveResolverGetAddressInfoSize' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #'primitives from old netnameresolver IPV6' }
OCNSocketPluginLibrary >> primGetAddressInfoType [

	<primitive: 'primitiveResolverGetAddressInfoType' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #'primitives from old netnameresolver IPV6' }
OCNSocketPluginLibrary >> primGetNameInfo: socketAddress flags: flags [
	"flags is 1 to get ip Number and 0 to get ip DNS Name"
	
	<primitive: 'primitiveResolverGetNameInfo' module: 'SocketPlugin'>
	flags == 0 ifTrue: [^self primGetNameInfo: socketAddress flags: 1 ].
	self primitiveFailed
]

{ #category : #'primitives from old netnameresolver IPV6' }
OCNSocketPluginLibrary >> primGetNameInfoHostResult: aString [

	<primitive: 'primitiveResolverGetNameInfoHostResult' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #'primitives from old netnameresolver IPV6' }
OCNSocketPluginLibrary >> primGetNameInfoHostSize [

	<primitive: 'primitiveResolverGetNameInfoHostSize' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #'primitives from old netnameresolver IPV6' }
OCNSocketPluginLibrary >> primGetNameInfoServiceResult: aString [

	<primitive: 'primitiveResolverGetNameInfoServiceResult' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #'primitives from old netnameresolver IPV6' }
OCNSocketPluginLibrary >> primGetNameInfoServiceSize [

	<primitive: 'primitiveResolverGetNameInfoServiceSize' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #'primitives from old netnameresolver IPV6' }
OCNSocketPluginLibrary >> primHostNameResult: aString [

	<primitive: 'primitiveResolverHostNameResult' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #'primitives from old netnameresolver IPV6' }
OCNSocketPluginLibrary >> primHostNameSize [

	<primitive: 'primitiveResolverHostNameSize' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #'primitives from old netnameresolver' }
OCNSocketPluginLibrary >> primInitializeNetwork: resolverSemaIndex [
	"Initialize the network drivers on platforms that need it, such as the Macintosh, and return nil if network initialization failed or the reciever if it succeeds. Since mobile computers may not always be connected to a network, this method should NOT be called automatically at startup time; rather, it should be called when first starting a networking application. It is a noop if the network driver has already been initialized. If non-zero, resolverSemaIndex is the index of a VM semaphore to be associated with the network name resolver. This semaphore will be signalled when the resolver status changes, such as when a name lookup query is completed."
	"Note: some platforms (e.g., Mac) only allow only one name lookup query at a time, so a manager process should be used to serialize resolver lookup requests."

	<primitive: 'primitiveInitializeNetwork' module: 'SocketPlugin'>
	^ nil  "return nil if primitive fails"

]

{ #category : #'primitives from old netnameresolver' }
OCNSocketPluginLibrary >> primLocalAddress [
	"Return the local address of this host."

	<primitive: 'primitiveResolverLocalAddress' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #'primitives from old netnameresolver' }
OCNSocketPluginLibrary >> primNameLookupResult [
	"Return the host address found by the last host name lookup. Returns nil if the last lookup was unsuccessful."

	<primitive: 'primitiveResolverNameLookupResult' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #'primitives from old netnameresolver' }
OCNSocketPluginLibrary >> primNameResolverError [
	"Return an integer reflecting the error status of the last network name resolver request. Zero means no error."

	<primitive: 'primitiveResolverError' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #'primitives from old netnameresolver' }
OCNSocketPluginLibrary >> primNameResolverStatus [
	"Return an integer reflecting the status of the network name resolver. For a list of possible values, see the comment in the 'initialize' method of this class."

	<primitive: 'primitiveResolverStatus' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #primitives }
OCNSocketPluginLibrary >> primSocket: socketID connectTo: hostAddress port: port [
	"Attempt to establish a connection to the given port of the given host. This is an asynchronous call; query the socket status to discover if and when the connection is actually completed."

	<primitive: 'primitiveSocketConnectToPort' module: 'SocketPlugin'>
	
]

{ #category : #'UDP primitives' }
OCNSocketPluginLibrary >> primSocket: socketID receiveUDPDataInto: aStringOrByteArray startingAt: startIndex count: count [
	"Receive data from the given socket into the given array starting at the given index. 
	Return an Array containing the amount read, the host address byte array, the host port, and the more flag"

	<primitive: 'primitiveSocketReceiveUDPDataBufCount' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #'UDP primitives' }
OCNSocketPluginLibrary >> primSocket: socketID sendUDPData: aStringOrByteArray toHost: hostAddress  port: portNumber startIndex: startIndex count: count [
	"Send data to the remote host through the given socket starting with the given byte index of the given byte array. The data sent is 'pushed' immediately. Return the number of bytes of data actually sent; any remaining data should be re-submitted for sending after the current send operation has completed."
	"Note: In general, it many take several sendData calls to transmit a large data array since the data is sent in send-buffer-sized chunks. The size of the send buffer is determined when the socket is created."

	<primitive:  'primitiveSocketSendUDPDataBufCount' module: 'SocketPlugin'>
	self primitiveFailed


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

{ #category : #'primitives from old netnameresolver' }
OCNSocketPluginLibrary >> primStartLookupOfAddress: hostAddr [
	"Look up the given host address in the Domain Name Server to find its name. This call is asynchronous. To get the results, wait for it to complete or time out and then use primAddressLookupResult."

	<primitive: 'primitiveResolverStartAddressLookup' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #'primitives from old netnameresolver' }
OCNSocketPluginLibrary >> primStartLookupOfName: hostName [
	"Look up the given host name in the Domain Name Server to find its address. This call is asynchronous. To get the results, wait for it to complete or time out and then use primNameLookupResult."

	<primitive: 'primitiveResolverStartNameLookup' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #'TCP API' }
OCNSocketPluginLibrary >> readFrom: socketId [
	self shouldBeImplemented 
]

{ #category : #'TCP API' }
OCNSocketPluginLibrary >> receiveFrom: socketId [
	self shouldBeImplemented 
]

{ #category : #'UDP primitives' }
OCNSocketPluginLibrary >> receiveUDPDataOn: socketId into: aByteArray [
	"Receive UDP data into the given buffer and return the number of bytes received. Note the given buffer may be only partially filled by the received data. What is returned is an array, the first element is the bytes read, the second the sending bytearray address, the third the senders port, the fourth, true if more of the datagram awaits reading"

	^ self primSocket: socketId
		receiveUDPDataInto: aByteArray
		startingAt: 1
		count: aByteArray size

]

{ #category : #'UDP API' }
OCNSocketPluginLibrary >> receiveUDPDatagramOn: socketId [
	"Receive UDP data into the given buffer and return the number of bytes received. Note the given buffer may be only partially filled by the received data. What is returned is an array, the first element is the bytes read, the second the sending bytearray address, the third the senders port, the fourth, true if more of the datagram awaits reading"

	|aByteArray aDatagramPacket |
	aByteArray := ByteArray new: 4.
	self receiveUDPDataOn: socketId into: aByteArray.

	aDatagramPacket sourceAddress: (aByteArray at: 2);
					data: (aByteArray at: 1);
					sourcePort: (aByteArray at: 3);
					offset: (aByteArray at: 4).
	^aDatagramPacket
]

{ #category : #'name resolving' }
OCNSocketPluginLibrary >> resolverUninitializedCode [
	^ 0  "network is not initialized"
]

{ #category : #'TCP API' }
OCNSocketPluginLibrary >> sendData: data to: socketId [
	self shouldBeImplemented 
]

{ #category : #'UDP primitives' }
OCNSocketPluginLibrary >> sendUDPDataOn: socketId contents: aByteArray toHost: hostAddress port: portNumber [
	"Send a UDP packet containing the given data to the specified host/port."
	| bytesToSend bytesSent count  |

	bytesToSend := aByteArray size.
	bytesSent := 0.
	[bytesSent < bytesToSend] whileTrue: [
		(self waitForSendDoneFor: 20)
			ifFalse: [OCNTimeOutException signal: 'send data timeout; data not sent'].
		count := self primSocket: socketId
			sendUDPData: aByteArray
			toHost: hostAddress
			port: portNumber
			startIndex: bytesSent + 1
			count: bytesToSend - bytesSent.
		bytesSent := bytesSent + count].

	^ bytesSent

]

{ #category : #'UDP API' }
OCNSocketPluginLibrary >> sendUDPOn: socketId datagram: aDatagramPacket [

	^ self sendUDPDataOn: socketId contents: aDatagramPacket data toHost: aDatagramPacket targetAddress port: aDatagramPacket targetPort
	
]
