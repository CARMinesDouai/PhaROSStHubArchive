"
Here is the list of primitives available in Cog Socket Plugin:

===
#('sqNetworkInit(resolverSemaIndex);' 'sqNetworkShutdown(void);' 'sqResolverAbort(void);' 'sqResolverAddrLookupResult(char *nameForAddress, nameSize);' 'sqResolverAddrLookupResultSize(void);' 'sqResolverError(void);' 'sqResolverLocalAddress(void);' 'sqResolverNameLookupResult(void);' 'sqResolverStartAddrLookup(address);' 'sqResolverStartNameLookup(char *hostName, nameSize);' 'sqResolverStatus(void);' 'sqSocketAbortConnection(SocketPtr s);' 'sqSocketCloseConnection(SocketPtr s);' 'sqSocketConnectionStatus(SocketPtr s);' 'sqSocketConnectToPort(SocketPtr s, addr, port);' 'sqSocketCreateNetTypeSocketTypeRecvBytesSendBytesSemaID(SocketPtr s, netType, socketType, recvBufSize, sendBufSize, semaIndex);' 'sqSocketCreateNetTypeSocketTypeRecvBytesSendBytesSemaIDReadSemaIDWriteSemaID(SocketPtr s, netType, socketType, recvBufSize, sendBufSize, semaIndex, readSemaIndex, writeSemaIndex);' 'sqSocketDestroy(SocketPtr s);' 'sqSocketError(SocketPtr s);' 'sqSocketListenOnPort(SocketPtr s, port);' 'sqSocketLocalAddress(SocketPtr s);' 'sqSocketLocalPort(SocketPtr s);' 'sqSocketReceiveDataAvailable(SocketPtr s);' 'sqSocketReceiveDataBufCount(SocketPtr s, char *buf, bufSize);' 'sqSocketRemoteAddress(SocketPtr s);' 'sqSocketRemotePort(SocketPtr s);' 'sqSocketSendDataBufCount(SocketPtr s, char *buf, bufSize);' 'sqSocketSendDone(SocketPtr s);' 'sqSocketListenOnPortBacklogSize(SocketPtr s, port, backlogSize);' 'sqSocketListenOnPortBacklogSizeInterface(SocketPtr s, port, backlogSize, addr);' 'sqSocketAcceptFromRecvBytesSendBytesSemaID(SocketPtr s, SocketPtr serverSocket, recvBufSize, sendBufSize, semaIndex);' 'sqSocketAcceptFromRecvBytesSendBytesSemaIDReadSemaIDWriteSemaID(SocketPtr s, SocketPtr serverSocket, recvBufSize, sendBufSize, semaIndex, readSemaIndex, writeSemaIndex);' 'sqSocketReceiveUDPDataBufCountaddressportmoreFlag(SocketPtr s, char *buf, bufSize,  *address,  *port, *moreFlag);' 'sqSockettoHostportSendDataBufCount(SocketPtr s, address, port, char *buf, bufSize);' 'sqSocketSetOptionsoptionNameStartoptionNameSizeoptionValueStartoptionValueSizereturnedValue(SocketPtr s, char *optionName, optionNameSize, char *optionValue, optionValueSize, *result);' 'sqSocketGetOptionsoptionNameStartoptionNameSizereturnedValue(SocketPtr s, char *optionName, optionNameSize, *result);' 'sqSocketBindToPort(SocketPtr s, int addr, int port);' 'sqSocketSetReusable(SocketPtr s);')
===

Here is the list of non-present primitives in Cog but available in the Squeak VMs (even 5.8):
===
#('sqResolverGetAddressInfoHostSizeServiceSizeFlagsFamilyTypeProtocol(char *hostName, hostSize, char *servName, servSize, flags, family, type, protocol);' 'sqResolverGetAddressInfoSize(void);' 'sqResolverGetAddressInfoResultSize(char *addr, addrSize);' 'sqResolverGetAddressInfoFamily(void);' 'sqResolverGetAddressInfoType(void);' 'sqResolverGetAddressInfoProtocol(void);' 'sqResolverGetAddressInfoNext(void);' 'sqSocketAddressSizeGetPort(char *addr, addrSize);' 'sqSocketAddressSizeSetPort(char *addr, addrSize, port);' 'sqResolverGetNameInfoSizeFlags(char *addr, addrSize, flags);' 'sqResolverGetNameInfoHostSize(void);' 'sqResolverGetNameInfoHostResultSize(char *name, nameSize);' 'sqResolverGetNameInfoServiceSize(void);' 'sqResolverGetNameInfoServiceResultSize(char *name, nameSize);' 'sqResolverHostNameSize(void);' 'sqResolverHostNameResultSize(char *name, nameSize);' 'sqSocketBindToAddressSize(SocketPtr s, char *addr, addrSize);' 'sqSocketListenBacklog(SocketPtr s, backlogSize);' 'sqSocketConnectToAddressSize(SocketPtr s, char *addr, addrSize);' 'sqSocketLocalAddressSize(SocketPtr s);' 'sqSocketLocalAddressResultSize(SocketPtr s, char *addr, int addrSize);' 'sqSocketRemoteAddressSize(SocketPtr s);' 'sqSocketRemoteAddressResultSize(SocketPtr s, char *addr, int addrSize);')
===
"
Class {
	#name : #OCNSocketPluginLibrary,
	#superclass : #Object,
	#instVars : [
		'isDestroyed',
		'semaphore',
		'semaIndex',
		'readSemaphore',
		'writeSemaphore',
		'readSemaIndex',
		'writeSemaIndex',
		'receiveDataBuffer',
		'primitiveOnlySupportsOneSemaphore'
	],
	#classVars : [
		'Clean',
		'Connected',
		'DefaultHostName',
		'InvalidSocket',
		'OtherEndClosed',
		'ResolverBusy',
		'ResolverError',
		'ResolverMutex',
		'ResolverReady',
		'ResolverSemaphore',
		'ResolverUninitialized',
		'TCPSocketType',
		'ThisEndClosed',
		'UDPSocketType',
		'WaitingForConnection'
	],
	#classInstVars : [
		'default'
	],
	#category : #'Ocean-LibraryPlugin'
}

{ #category : #initialization }
OCNSocketPluginLibrary class >> initialize [
	"self initialize"

	"Socket Types"
	TCPSocketType := 0.
	UDPSocketType := 1.

	"Socket Status Values"
	InvalidSocket := -1.
	Clean := 0.
	WaitingForConnection := 1.
	Connected := 2.
	OtherEndClosed := 3.
	ThisEndClosed := 4.
	
	"NetNameResolver initialize"
	"Note: On the Mac, the name resolver is asynchronous (i.e., Pharo can do other things while it is working), but can only handle one request at a time. On other platforms, such as Unix, the resolver is synchronous; a call to, say, the name lookup primitive will block all Pharo processes until it returns."

	"Resolver Status Values"
	ResolverUninitialized := 0.	"network is not initialized"
	ResolverReady := 1.			"resolver idle, last request succeeded"
	ResolverBusy := 2.			"lookup in progress"
	ResolverError := 3.			"resolver idle, last request failed"

	DefaultHostName := ''.
]

{ #category : #'instance creation' }
OCNSocketPluginLibrary class >> proxy [
	self flag: 'Reimplement the initializeNetwork stuff'.
	NetNameResolver initializeNetwork.
	^self new
]

{ #category : #'API-TCP' }
OCNSocketPluginLibrary >> acceptFrom: aServerSocket [
	|conversationSocket conversationSocketId networkLibrary |
	
	self ensureNetworkInitialized.
	
	self waitForConnectionOf: aServerSocket timeoutSeconds: aServerSocket acceptTimeoutSeconds 
		onTimeoutDo: [OCNSocketOperationFailureError signal: 'Accept timeout'].

	networkLibrary :=  self species new. 
	conversationSocketId := self
		primAcceptFrom: aServerSocket socketId
		receiveBufferSize:  OCNSocket receiveDataBufferSize
		sendBufSize: OCNSocket sendDataBufferSize 
		semaIndex:  networkLibrary semaIndex
		readSemaIndex:  networkLibrary readSemaIndex
		writeSemaIndex:  networkLibrary writeSemaIndex.
	
	^OCNConversationTcpSocket newConnectedWithId: conversationSocketId library: networkLibrary

]

{ #category : #'Support For NameResolving' }
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

{ #category : #'Support For NameResolving' }
OCNSocketPluginLibrary >> addressForName: hostName timeout: secs [
	"Look up the given host name and return its address. Return nil if the address is not found in the given number of seconds."
	"OCNSocketPluginLibrary proxy addressForName: 'create.ucsb.edu' timeout: 30"
	"OCNSocketPluginLibrary proxy addressForName: '100000jobs.de' timeout: 30"
	"OCNSocketPluginLibrary proxy addressForName: '1.7.6.4' timeout: 30"
	"OCNSocketPluginLibrary proxy addressForName: '' timeout: 30 (This seems to return nil?)"

	| deadline result |
	"check if this is a valid numeric host address (e.g. 1.2.3.4)"
	result := self addressFromString: hostName.
	result isNil ifFalse: [^result].

	"Look up a host name, including ones that start with a digit (e.g. 100000jobs.de or www.pharo-project.org)"
	deadline := Time millisecondClockValue + (secs * 1000).
	"Protect the execution of this block, as the ResolverSemaphore is used for both parts of the transaction."
	self resolverMutex
		critical: [
			(self waitForResolverReadyUntil: deadline)
				ifTrue: [
					self primStartLookupOfName: hostName.
					(self waitForCompletionUntil: deadline)
						ifTrue: [result := self primNameLookupResult]
						ifFalse: [OCNNameLookupError signal: 'Could not resolve the server named: ', hostName]]
				ifFalse: [OCNNameLookupError signal: 'Could not resolve the server named: ', hostName]].
	^result 
]

{ #category : #'Support For NameResolving' }
OCNSocketPluginLibrary >> addressFromString: addressString [ 
	"Return the internet address represented by the given string. The string should contain four positive decimal integers delimited by periods, commas, or spaces, where each integer represents one address byte. Return nil if the string is not a host address in an acceptable format."
	"NetNameResolver addressFromString: '1.2.3.4'"
	"NetNameResolver addressFromString: '1,2,3,4'"
	"NetNameResolver addressFromString: '1 2 3 4'"
	| newAddr s byte delimiter |
	newAddr := ByteArray new: 4.
	s := addressString readStream.
	s skipSeparators.
	1 
		to: 4
		do: 
			[ :i | 
			byte := self readDecimalByteFrom: s.
			byte isNil ifTrue: [ ^ nil ].
			newAddr 
				at: i
				put: byte.
			i < 4 ifTrue: 
				[ delimiter := s next.
				(delimiter = $. or: [ delimiter = $, or: [ delimiter = $  ] ]) ifFalse: [ ^ nil ] ] ].
	^ newAddr
]

{ #category : #'Support For NameResolving' }
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

{ #category : #'Support For NameResolving' }
OCNSocketPluginLibrary >> allAddressFamily [
	^0
]

{ #category : #'API-Socket' }
OCNSocketPluginLibrary >> bind: aSocket toIpv4Address: anOCNIPV4SocketAddress [ 

	((1 to: (2 raisedTo: 16)) includes: anOCNIPV4SocketAddress port) ifFalse: [
		OCNSocketOperationFailureError signal: anOCNIPV4SocketAddress port printString , ' is not a valid port number'].

	[ self primSocketBind: aSocket socketId to: (anOCNIPV4SocketAddress ip ) port: anOCNIPV4SocketAddress port ] 
		on: PrimitiveFailed 
		do: [ OCNSocketOperationFailureError signal: 'binding socket to port ', anOCNIPV4SocketAddress port printString , ' failed' ]
]

{ #category : #'API-TCP' }
OCNSocketPluginLibrary >> connect: aSocket toServerWithIpv4Address: serverAddress [

	self ensureNetworkInitialized.
	self primSocket: aSocket socketId connectTo: serverAddress ip port: serverAddress port.
	self waitForConnectionOf: aSocket timeoutSeconds: aSocket connectionTimeoutSeconds

]

{ #category : #'Support For Sockets' }
OCNSocketPluginLibrary >> convertIpv4StringAddressToByteArray: stringAddress [
	^((stringAddress subStrings: '.')  collect: [ :string | string asInteger]) asByteArray
]

{ #category : #'Support For Sockets' }
OCNSocketPluginLibrary >> createSocketDescriptorIdFor: anOCNSocket withType:  socketType [
	
	| socketId status|

	socketId := self primSocketCreateNetwork: 0
			type: socketType
			receiveBufferSize: anOCNSocket receiveDataBufferSize
			sendBufSize: anOCNSocket sendDataBufferSize
			semaIndex: semaIndex.
	
	self flag: 'clean the following test. a newly created Udp socket is in the Connected state'.
	(socketId notNil and: [((status := (self primSocketConnectionStatus: socketId)) = Clean) or: [ status = Connected ]]) ifTrue: [ ^socketId ].
	self releaseSemaphores.
	OCNSocketOperationFailureError signal: 'Socket creation failure'
	
]

{ #category : #'API-TCP' }
OCNSocketPluginLibrary >> createTcpSocketDescriptorIdFor: anOCNSocket [
	^self createSocketDescriptorIdFor: anOCNSocket withType: TCPSocketType	
]

{ #category : #'API-UDP' }
OCNSocketPluginLibrary >> createUdpSocketDescriptorIdFor: anOCNSocket [
	^self createSocketDescriptorIdFor: anOCNSocket  withType: UDPSocketType

]

{ #category : #'Support For NameResolving' }
OCNSocketPluginLibrary >> defaultAddressLookupTimeout [
	^3 "seconds"
	
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

{ #category : #'initialize-release' }
OCNSocketPluginLibrary >> initSemaphores [
	semaphore := Semaphore new.
	readSemaphore := Semaphore new.
	writeSemaphore := Semaphore new.
	
	semaIndex := Smalltalk registerExternalObject: semaphore.
	readSemaIndex := Smalltalk registerExternalObject: readSemaphore.
	writeSemaIndex := Smalltalk registerExternalObject: writeSemaphore.

]

{ #category : #'initialize-release' }
OCNSocketPluginLibrary >> initialize [
	super initialize.
	isDestroyed := false.
	primitiveOnlySupportsOneSemaphore := false.
	[self initSemaphores] on: Error do: [ :er | OCNSocketOperationFailureError signal: 'Socket creation failure']

]

{ #category : #'Support For NameResolving' }
OCNSocketPluginLibrary >> ipv4 [
	^2
]

{ #category : #'API-NameResolving IpV4' }
OCNSocketPluginLibrary >> ipv4AddressForName: nameToLookup [
	|resultAddress |
	resultAddress := OCNIpv4Address new.
	resultAddress ip: (self addressForName: nameToLookup timeout: self defaultAddressLookupTimeout).
	^resultAddress
	
]

{ #category : #'API-NameResolving IpV4' }
OCNSocketPluginLibrary >> ipv4AddressesForName: nameToLookup [

	^(self addressesForName: nameToLookup  addressFamily:  self ipv4) collect: [:adressString | OCNIpv4Address newFromString: adressString ]
]

{ #category : #'API-NameResolving IpV4' }
OCNSocketPluginLibrary >> ipv4LocalHostAddress [
	^OCNIpv4Address new 
		ip: self primLocalAddress; 
		yourself
]

{ #category : #'Support For NameResolving' }
OCNSocketPluginLibrary >> ipv6 [ 
	^3
]

{ #category : #'API-NameResolving IpV6' }
OCNSocketPluginLibrary >> ipv6AddressForName: nameToLookup [
	
	^self ipv6AddressFromString: (self addressForName: nameToLookup addressFamily: self ipv6)
	
	
]

{ #category : #'Support For NameResolving' }
OCNSocketPluginLibrary >> ipv6AddressFromString: aString [
	^OCNIpv6Address newFromString:  (aString splitOn: $%) first

]

{ #category : #'API-NameResolving IpV6' }
OCNSocketPluginLibrary >> ipv6AddressesForName: nameToLookup [
	
	^(self addressesForName: nameToLookup  addressFamily:  self ipv6) collect:[:address | self ipv6AddressFromString:  address ]
]

{ #category : #'API-TCP' }
OCNSocketPluginLibrary >> isDataAvailableFrom: socket [
	^ self primSocketReceiveDataAvailable: socket socketId

]

{ #category : #'API-TCP' }
OCNSocketPluginLibrary >> isSocketConnected: socket [ 
	socket socketId ifNil: [^ false].
	^ (self primSocketConnectionStatus: socket socketId) == self tcpSocketConnectedStatus

]

{ #category : #'API-TCP' }
OCNSocketPluginLibrary >> listen: aServerSocket on: anIpAddress [
	[self primSocket: aServerSocket socketId listenOn: anIpAddress port backlogSize:  aServerSocket backlogSize interface: anIpAddress ip]
		on: PrimitiveFailed 
		do: [ OCNSocketOperationFailureError signal: 'socket cannot listen' ]

	
]

{ #category : #'Support For NameResolving' }
OCNSocketPluginLibrary >> localAddressFamily [
	^1
]

{ #category : #'Support For NameResolving' }
OCNSocketPluginLibrary >> localAddressString [
	"Return a string representing the local host address as four decimal bytes delimited with decimal points."

	^ self stringFromAddress: self localHostAddress

]

{ #category : #'Support For NameResolving' }
OCNSocketPluginLibrary >> localHostAddress [
	"Return the local address of this host."

	^ self primLocalAddress

]

{ #category : #'API-NameResolving IpV4' }
OCNSocketPluginLibrary >> localHostName [
	
	|  hostname |

	hostname := String new: self primHostNameSize.
	self primHostNameResult: hostname.  
	"sadly, this primitive returns the name stored in the localhost machine (e.g. machine.local on OSX) and not the name used by the DNS server "
	
	^hostname
]

{ #category : #'Support For NameResolving' }
OCNSocketPluginLibrary >> nameForAddress: hostAddress timeout: secs [
	"Look up the given host address and return its name. Return nil if the lookup fails or is not completed in the given number of seconds. Depends on the given host address being known to the gateway, which may not be the case for dynamically allocated addresses."
	
	| deadline result |
	deadline := Time millisecondClockValue + (secs * 1000).
	"Protect the execution of this block, as the ResolverSemaphore is used for both parts of the transaction."
	self resolverMutex
		critical: [
			result := (self waitForResolverReadyUntil: deadline)
				ifTrue: [
					self primStartLookupOfAddress: hostAddress.
					(self waitForCompletionUntil: deadline)
						ifTrue: [self primAddressLookupResult]
						ifFalse: [nil]]
				ifFalse: [nil]].
	^result

]

{ #category : #'Primitives-NameResolving' }
OCNSocketPluginLibrary >> primAbortLookup [
	"Abort the current lookup operation, freeing the name resolver for the next query."

	<primitive: 'primitiveResolverAbortLookup' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #'Primitives-TCP' }
OCNSocketPluginLibrary >> primAcceptFrom: aHandle receiveBufferSize: rcvBufSize sendBufSize: sndBufSize semaIndex: semaphoreIndex [
	"Create and return a new socket handle based on accepting the connection from the given listening socket"

	<primitive: 'primitiveSocketAccept' module: 'SocketPlugin'>

	^ self primitiveFailed
]

{ #category : #'Primitives-TCP' }
OCNSocketPluginLibrary >> primAcceptFrom: aHandle receiveBufferSize: rcvBufSize sendBufSize: sndBufSize semaIndex: semaInd readSemaIndex: aReadSema writeSemaIndex: aWriteSema [
	"Create and return a new socket handle based on accepting the connection from the given listening socket"
	<primitive: 'primitiveSocketAccept3Semaphores' module: 'SocketPlugin'>
	primitiveOnlySupportsOneSemaphore := true.
	^self primAcceptFrom: aHandle receiveBufferSize: rcvBufSize sendBufSize: sndBufSize semaIndex: semaIndex 
]

{ #category : #'Primitives-NameResolving' }
OCNSocketPluginLibrary >> primAddressLookupResult [
	"Return the host name found by the last host address lookup. Returns nil if the last lookup was unsuccessful."

	<primitive: 'primitiveResolverAddressLookupResult' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #'Primitives-TCP' }
OCNSocketPluginLibrary >> primDestroySocket: socketId [

	"Socket>>primSocketDestroy:"	
	<primitive: 'primitiveSocketDestroy' module: 'SocketPlugin'>

	OCNSocketOperationFailureError signal: 'Destroy failed'
]

{ #category : #'Primitives-Unused from old netnameresolver IPV6' }
OCNSocketPluginLibrary >> primGetAddressInfoFamily [

	<primitive: 'primitiveResolverGetAddressInfoFamily' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #'Primitives-NameResolvingIPV6' }
OCNSocketPluginLibrary >> primGetAddressInfoHost: hostName service: servName flags: flags family: family type: type protocol: protocol [

	<primitive: 'primitiveResolverGetAddressInfo' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #'Primitives-NameResolvingIPV6' }
OCNSocketPluginLibrary >> primGetAddressInfoNext [

	<primitive: 'primitiveResolverGetAddressInfoNext' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #'Primitives-Unused from old netnameresolver IPV6' }
OCNSocketPluginLibrary >> primGetAddressInfoProtocol [

	<primitive: 'primitiveResolverGetAddressInfoProtocol' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #'Primitives-NameResolvingIPV6' }
OCNSocketPluginLibrary >> primGetAddressInfoResult: socketAddress [

	<primitive: 'primitiveResolverGetAddressInfoResult' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #'Primitives-NameResolvingIPV6' }
OCNSocketPluginLibrary >> primGetAddressInfoSize [

	<primitive: 'primitiveResolverGetAddressInfoSize' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #'Primitives-Unused from old netnameresolver IPV6' }
OCNSocketPluginLibrary >> primGetAddressInfoType [

	<primitive: 'primitiveResolverGetAddressInfoType' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #'Primitives-NameResolvingIPV6' }
OCNSocketPluginLibrary >> primGetNameInfo: socketAddress flags: flags [
	"flags is 1 to get ip Number and 0 to get ip DNS Name"
	
	<primitive: 'primitiveResolverGetNameInfo' module: 'SocketPlugin'>
	flags == 0 ifTrue: [^self primGetNameInfo: socketAddress flags: 1 ].
	self primitiveFailed
]

{ #category : #'Primitives-NameResolvingIPV6' }
OCNSocketPluginLibrary >> primGetNameInfoHostResult: aString [

	<primitive: 'primitiveResolverGetNameInfoHostResult' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #'Primitives-NameResolvingIPV6' }
OCNSocketPluginLibrary >> primGetNameInfoHostSize [

	<primitive: 'primitiveResolverGetNameInfoHostSize' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #'Primitives-Unused from old netnameresolver IPV6' }
OCNSocketPluginLibrary >> primGetNameInfoServiceResult: aString [

	<primitive: 'primitiveResolverGetNameInfoServiceResult' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #'Primitives-Unused from old netnameresolver IPV6' }
OCNSocketPluginLibrary >> primGetNameInfoServiceSize [

	<primitive: 'primitiveResolverGetNameInfoServiceSize' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #'Primitives-Unused from old netnameresolver IPV6' }
OCNSocketPluginLibrary >> primHostNameResult: aString [

	<primitive: 'primitiveResolverHostNameResult' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #'Primitives-Unused from old netnameresolver IPV6' }
OCNSocketPluginLibrary >> primHostNameSize [

	<primitive: 'primitiveResolverHostNameSize' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #'Primitives-NameResolving' }
OCNSocketPluginLibrary >> primInitializeNetwork: resolverSemaIndex [
	"Initialize the network drivers on platforms that need it, such as the Macintosh, and return nil if network initialization failed or the reciever if it succeeds. Since mobile computers may not always be connected to a network, this method should NOT be called automatically at startup time; rather, it should be called when first starting a networking application. It is a noop if the network driver has already been initialized. If non-zero, resolverSemaIndex is the index of a VM semaphore to be associated with the network name resolver. This semaphore will be signalled when the resolver status changes, such as when a name lookup query is completed."
	"Note: some platforms (e.g., Mac) only allow only one name lookup query at a time, so a manager process should be used to serialize resolver lookup requests."

	<primitive: 'primitiveInitializeNetwork' module: 'SocketPlugin'>
	^ nil  "return nil if primitive fails"

]

{ #category : #'Primitives-NameResolving' }
OCNSocketPluginLibrary >> primLocalAddress [
	"Return the local address of this host."

	<primitive: 'primitiveResolverLocalAddress' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #'Primitives-NameResolving' }
OCNSocketPluginLibrary >> primNameLookupResult [
	"Return the host address found by the last host name lookup. Returns nil if the last lookup was unsuccessful."

	<primitive: 'primitiveResolverNameLookupResult' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #'Primitives-Unused-from old netnameresolver' }
OCNSocketPluginLibrary >> primNameResolverError [
	"Return an integer reflecting the error status of the last network name resolver request. Zero means no error."

	<primitive: 'primitiveResolverError' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #'Primitives-NameResolving' }
OCNSocketPluginLibrary >> primNameResolverStatus [
	"Return an integer reflecting the status of the network name resolver. For a list of possible values, see the comment in the 'initialize' method of this class."

	<primitive: 'primitiveResolverStatus' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #'Primitives-Unused' }
OCNSocketPluginLibrary >> primSocket: socketID bindTo: socketAddress [

	<primitive: 'primitiveSocketBindTo' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #'Primitives-Unused' }
OCNSocketPluginLibrary >> primSocket: socketID connectTo: socketAddress [

	<primitive: 'primitiveSocketConnectTo' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #'Primitives-TCP' }
OCNSocketPluginLibrary >> primSocket: socketID connectTo: hostAddress port: port [
	"Attempt to establish a connection to the given port of the given host. This is an asynchronous call; query the socket status to discover if and when the connection is actually completed."

	<primitive: 'primitiveSocketConnectToPort' module: 'SocketPlugin'>
	OCNSocketOperationFailureError signal: 'Connect failed'

]

{ #category : #'Primitives-Unused' }
OCNSocketPluginLibrary >> primSocket: socketID getOption: aString [ 
	"Get some option information on this socket. Refer to the UNIX 
	man pages for valid SO, TCP, IP, UDP options. In case of doubt
	refer to the source code.
	TCP:=NODELAY, SO:=KEEPALIVE are valid options for example
	returns an array containing the error code and the option value"

	<primitive: 'primitiveSocketGetOptions' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #'Primitives-Unused' }
OCNSocketPluginLibrary >> primSocket: aHandle listenOn: portNumber backlogSize: backlog [
	"Primitive. Set up the socket to listen on the given port.
	Will be used in conjunction with #accept only."
	<primitive: 'primitiveSocketListenWithOrWithoutBacklog' module: 'SocketPlugin'>
	self destroy. "Accept not supported so clean up"
]

{ #category : #'Primitives-TCP' }
OCNSocketPluginLibrary >> primSocket: aHandle listenOn: portNumber backlogSize: backlog interface: ifAddr [
	"Primitive. Set up the socket to listen on the given port.
	Will be used in conjunction with #accept only."
	<primitive: 'primitiveSocketListenOnPortBacklogInterface' module: 'SocketPlugin'>
	OCNSocketOperationFailureError signal:  'Listen failed'
]

{ #category : #'Primitives-Unused' }
OCNSocketPluginLibrary >> primSocket: socketId listenOnPort: aPortNumber [
	<primitive: 'primitiveSocketListenOnPort' module: 'SocketPlugin'>
	self primitiveFailed
]

{ #category : #'Primitives-Unused' }
OCNSocketPluginLibrary >> primSocket: socketID listenWithBacklog: backlogSize [

	<primitive: 'primitiveSocketListenWithBacklog' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #'Primitives-Unused' }
OCNSocketPluginLibrary >> primSocket: socketID localAddressResult: socketAddress [

	<primitive: 'primitiveSocketLocalAddressResult' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #'Primitives-TCP' }
OCNSocketPluginLibrary >> primSocket: socketID receiveDataInto: aStringOrByteArray startingAt: startIndex count: count [
	"Receive data from the given socket into the given array starting at the given index. Return the number of bytes read or zero if no data is available."

	<primitive: 'primitiveSocketReceiveDataBufCount' module: 'SocketPlugin'>
	OCNSocketOperationFailureError signal: 'Reception failed'

]

{ #category : #'Primitives-UDP' }
OCNSocketPluginLibrary >> primSocket: socketID receiveUDPDataInto: aStringOrByteArray startingAt: startIndex count: count [
	"Receive data from the given socket into the given array starting at the given index. 
	Return an Array containing the amount read, the host address byte array, the host port, and the more flag"

	<primitive: 'primitiveSocketReceiveUDPDataBufCount' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #'Primitives-Unused' }
OCNSocketPluginLibrary >> primSocket: socketID remoteAddressResult: socketAddress [

	<primitive: 'primitiveSocketRemoteAddressResult' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #'Primitives-TCP' }
OCNSocketPluginLibrary >> primSocket: socketID sendData: aStringOrByteArray startIndex: startIndex count: count [
	"Send data to the remote host through the given socket starting with the given byte index of the given byte array. The data sent is 'pushed' immediately. Return the number of bytes of data actually sent; any remaining data should be re-submitted for sending after the current send operation has completed."
	"Note: In general, it many take several sendData calls to transmit a large data array since the data is sent in send-buffer-sized chunks. The size of the send buffer is determined when the socket is created."

	<primitive: 'primitiveSocketSendDataBufCount' module: 'SocketPlugin'>
	OCNSocketOperationFailureError signal: 'Sending failed'

]

{ #category : #'Primitives-UDP' }
OCNSocketPluginLibrary >> primSocket: socketID sendUDPData: aStringOrByteArray toHost: hostAddress  port: portNumber startIndex: startIndex count: count [
	"Send data to the remote host through the given socket starting with the given byte index of the given byte array. The data sent is 'pushed' immediately. Return the number of bytes of data actually sent; any remaining data should be re-submitted for sending after the current send operation has completed."
	"Note: In general, it many take several sendData calls to transmit a large data array since the data is sent in send-buffer-sized chunks. The size of the send buffer is determined when the socket is created."

	<primitive:  'primitiveSocketSendUDPDataBufCount' module: 'SocketPlugin'>
	self primitiveFailed


]

{ #category : #'Primitives-Unused' }
OCNSocketPluginLibrary >> primSocket: socketID setOption: aString value: aStringValue [
	"Set some option information on this socket. Refer to the UNIX 
	man pages for valid SO, TCP, IP, UDP options. In case of doubt
	refer to the source code.
	TCP:=NODELAY, SO:=KEEPALIVE are valid options for example
	returns an array containing the error code and the negotiated value"

	<primitive: 'primitiveSocketSetOptions' module: 'SocketPlugin'>
	^nil
]

{ #category : #'Primitives-Unused' }
OCNSocketPluginLibrary >> primSocketAbortConnection: socketID [
	"Terminate the connection on the given port immediately without going through the normal close sequence. This is an asynchronous call; query the socket status to discover if and when the connection is actually terminated."

	<primitive: 'primitiveSocketAbortConnection' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #'Primitives-Unused' }
OCNSocketPluginLibrary >> primSocketAddressGetPort [
	<primitive: 'primitiveSocketAddressGetPort' module: 'SocketPlugin'>
	"should fix arg"
	self primitiveFailed
]

{ #category : #'Primitives-Unused' }
OCNSocketPluginLibrary >> primSocketAddressSetPort [
	<primitive: 'primitiveSocketAddressSetPort' module: 'SocketPlugin'>
	"should fix arg"
	self primitiveFailed
]

{ #category : #'Primitives-Unused' }
OCNSocketPluginLibrary >> primSocketBind: socketID to: anIntFromIPAddress port: aPortNumber [
	<primitive: 'primitiveSocketBindToPort' module: 'SocketPlugin'>
	self primitiveFailed
]

{ #category : #'Primitives-Unused' }
OCNSocketPluginLibrary >> primSocketCloseConnection: socketID [
	"Close the connection on the given port. The remote end is informed that this end has closed and will do no further sends. This is an asynchronous call; query the socket status to discover if and when the connection is actually closed."

	<primitive: 'primitiveSocketCloseConnection' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #'Support For TCP' }
OCNSocketPluginLibrary >> primSocketConnectionStatus: socketID [
	"Return an integer reflecting the connection status of this socket. For a list of possible values, see the comment in the 'initialize' method of this class. If the primitive fails, return a status indicating that the socket handle is no longer valid, perhaps because the Pharo image was saved and restored since the socket was created. (Sockets do not survive snapshots.)"

	<primitive: 'primitiveSocketConnectionStatus' module: 'SocketPlugin'>
	^InvalidSocket 
]

{ #category : #'Primitives-Socket' }
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

{ #category : #'Primitives-Socket' }
OCNSocketPluginLibrary >> primSocketCreateNetwork: netType type: socketType receiveBufferSize: rcvBufSize sendBufSize: sendBufSize semaIndex: semaphoreIndex readSemaIndex: aReadSemaphore writeSemaIndex: aWriteSema [
	"See comment in primSocketCreateNetwork: with one semaIndex. However you should know that some implementations
	ignore the buffer size and this interface supports three semaphores,  one for open/close/listen and the other two for
	reading and writing"

	<primitive: 'primitiveSocketCreate3Semaphores' module: 'SocketPlugin'>
	primitiveOnlySupportsOneSemaphore := true.
	^ self primSocketCreateNetwork: netType
			type: socketType
			receiveBufferSize: rcvBufSize
			sendBufSize: sendBufSize
			semaIndex: semaIndex	
]

{ #category : #'Primitives-Unused' }
OCNSocketPluginLibrary >> primSocketDestroy: socketID [
	"Release the resources associated with this socket. If a connection is open, it is aborted."

	<primitive: 'primitiveSocketDestroy' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #'Primitives-Unused' }
OCNSocketPluginLibrary >> primSocketDisableSocketAccess [
	"Primitive. Disable access to sockets.
	Cannot be revoked from the image."
	<primitive: 'primitiveDisableSocketAccess' module: 'SocketPlugin'>
	^self primitiveFailed
]

{ #category : #'Primitives-Unused' }
OCNSocketPluginLibrary >> primSocketError: socketID [
	"Return an integer encoding the most recent error on this socket. Zero means no error."

	<primitive: 'primitiveSocketError' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #'Primitives-Unused' }
OCNSocketPluginLibrary >> primSocketHasSocketAccess [
	"Return true if the right to access sockets hasn't been revoked"
	<primitive: 'primitiveHasSocketAccess' module: 'SocketPlugin'>
	^true "assume so unless otherwise proven"
]

{ #category : #'Primitives-Unused' }
OCNSocketPluginLibrary >> primSocketListenOnPortBacklog [
	<primitive: 'primitiveSocketListenOnPortBacklog' module: 'SocketPlugin'>
	"should fix arg"
	self primitiveFailed
]

{ #category : #'Primitives-Unused' }
OCNSocketPluginLibrary >> primSocketLocalAddress: socketID [
	"Return the local host address for this socket."

	<primitive: 'primitiveSocketLocalAddress' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #'Primitives-Unused' }
OCNSocketPluginLibrary >> primSocketLocalAddressSize: handle [

	<primitive: 'primitiveSocketLocalAddressSize' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #'Primitives-Unused' }
OCNSocketPluginLibrary >> primSocketLocalPort: socketID [
	"Return the local port for this socket, or zero if no port has yet been assigned."

	<primitive: 'primitiveSocketLocalPort' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #'Primitives-Socket' }
OCNSocketPluginLibrary >> primSocketReceiveDataAvailable: socketID [
	"Return true if data may be available for reading from the current socket."

	<primitive: 'primitiveSocketReceiveDataAvailable' module: 'SocketPlugin'>
	SocketPrimitiveFailed signal

]

{ #category : #'Primitives-Unused' }
OCNSocketPluginLibrary >> primSocketRemoteAddress: socketID [
	"Return the remote host address for this socket, or zero if no connection has been made."

	<primitive: 'primitiveSocketRemoteAddress' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #'Primitives-Unused' }
OCNSocketPluginLibrary >> primSocketRemoteAddressSize: handle [

	<primitive: 'primitiveSocketRemoteAddressSize' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #'Primitives-Unused' }
OCNSocketPluginLibrary >> primSocketRemotePort: socketID [
	"Return the remote port for this socket, or zero if no connection has been made."

	<primitive: 'primitiveSocketRemotePort' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #'Primitives-Socket' }
OCNSocketPluginLibrary >> primSocketSendDone: socketID [
	"Return true if there is no send in progress on the current socket."

	<primitive: 'primitiveSocketSendDone' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #'Primitives-NameResolving' }
OCNSocketPluginLibrary >> primStartLookupOfAddress: hostAddr [
	"Look up the given host address in the Domain Name Server to find its name. This call is asynchronous. To get the results, wait for it to complete or time out and then use primAddressLookupResult."

	<primitive: 'primitiveResolverStartAddressLookup' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #'Primitives-NameResolving' }
OCNSocketPluginLibrary >> primStartLookupOfName: hostName [
	"Look up the given host name in the Domain Name Server to find its address. This call is asynchronous. To get the results, wait for it to complete or time out and then use primNameLookupResult."

	<primitive: 'primitiveResolverStartNameLookup' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #'Support For NameResolving' }
OCNSocketPluginLibrary >> readDecimalByteFrom: aStream [
	"Read a positive, decimal integer from the given stream. Stop when a non-digit or end-of-stream is encountered. Return nil if stream is not positioned at a decimal digit or if the integer value read exceeds 255.
JMM - 000503 fixed didn't work correctly"

	| digitSeen value digit |
	digitSeen := false.
	value := 0.
	[aStream atEnd] whileFalse: 
		[digit := aStream next digitValue.
		(digit < 0 or: [digit > 9]) ifTrue: [
			aStream skip: -1.
			(digitSeen not or: [value > 255]) ifTrue: [^ nil].
			^ value].
		digitSeen := true.
		value := (value * 10) + digit].
	(digitSeen not or: [value > 255]) ifTrue: [^ nil].
	^ value

]

{ #category : #accessing }
OCNSocketPluginLibrary >> readSemaIndex [
	^readSemaIndex
]

{ #category : #accessing }
OCNSocketPluginLibrary >> receiveDataBuffer [
	^receiveDataBuffer ifNil: [ receiveDataBuffer := (ByteArray new: OCNSocket receiveDataBufferSize) ]
]

{ #category : #accessing }
OCNSocketPluginLibrary >> receiveDataBuffer: aByteArray [
	receiveDataBuffer := aByteArray
]

{ #category : #'Support For UDP' }
OCNSocketPluginLibrary >> receiveUDPDataOn: socketId into: aByteArray [
	"Receive UDP data into the given buffer and return the number of bytes received. Note the given buffer may be only partially filled by the received data. What is returned is an array, the first element is the bytes read, the second the sending bytearray address, the third the senders port, the fourth, true if more of the datagram awaits reading"
	
	"add a while true because the prmitive is non-blocking"
	
	"perhaps should use the read semaphore attached to the sockets"
	
	
	
	self waitForDataOn: socketId for: 3 onTimedOut: [ OCNTimeOutError signal: 'no data available' ].
	^ self primSocket: socketId
			receiveUDPDataInto: aByteArray
			startingAt: 1
			count: aByteArray size.
	
]

{ #category : #'API-UDP' }
OCNSocketPluginLibrary >> receiveUDPDatagramOn: aSocket [
	"Receive UDP data into the given buffer and return the number of bytes received. Note the given buffer may be only partially filled by the received data. What is returned is an array, the first element is the bytes read, the second the sending bytearray address, the third the senders port, the fourth, true if more of the datagram awaits reading"

	| resultInfos aDatagramPacket |
	
	"resultInfos := ByteArray new: 4."
	resultInfos := self receiveUDPDataOn: aSocket socketId into: self receiveDataBuffer.
	
	aDatagramPacket := OCNDatagramPacket new.
	aDatagramPacket 
					data: (self receiveDataBuffer copyFrom: 1 to: (resultInfos at: 1)) ;
					sourceIP: (resultInfos at: 2) port: (resultInfos at: 3) type: OCNIpv4Address;
					targetAddress: nil; "should be implemented when we will pass a real IP object in parameter"
					more: (resultInfos at: 4).

	^aDatagramPacket
]

{ #category : #'initialize-release' }
OCNSocketPluginLibrary >> releaseSemaphores [
	
	Smalltalk unregisterExternalObject: semaphore.
	Smalltalk unregisterExternalObject: readSemaphore.
	Smalltalk unregisterExternalObject: writeSemaphore.

	readSemaphore := writeSemaphore := semaphore := nil.
]

{ #category : #'Support For NameResolving' }
OCNSocketPluginLibrary >> resolverMutex [
	ResolverMutex ifNil: [ResolverMutex := Semaphore forMutualExclusion].
	^ResolverMutex
]

{ #category : #'Support For NameResolving' }
OCNSocketPluginLibrary >> resolverStatus [
	^self primNameResolverStatus

]

{ #category : #'Support For NameResolving' }
OCNSocketPluginLibrary >> resolverUninitializedCode [
	^ 0  "network is not initialized"
]

{ #category : #accessing }
OCNSocketPluginLibrary >> semaIndex [
	^semaIndex
]

{ #category : #'Support For UDP' }
OCNSocketPluginLibrary >> sendUDPDataOn: socketId contents: aByteArray toHost: hostAddress port: portNumber [
	"Send a UDP packet containing the given data to the specified host/port."
	| bytesToSend bytesSent count  |

	bytesToSend := aByteArray size.
	bytesSent := 0.
	[bytesSent < bytesToSend] whileTrue: [
		self waitForSendDoneOn: socketId for: 20.
		count := self primSocket: socketId
			sendUDPData: aByteArray
			toHost: hostAddress
			port: portNumber
			startIndex: bytesSent + 1
			count: bytesToSend - bytesSent.
		bytesSent := bytesSent + count].

	^ bytesSent

]

{ #category : #'API-UDP' }
OCNSocketPluginLibrary >> sendUDPOn: aSocket datagram: aDatagramPacket [
	"this method should deal with sourceAdress: from DatagramPacket."
	^ self sendUDPDataOn: aSocket socketId contents: aDatagramPacket data toHost: aDatagramPacket targetAddress ip port: aDatagramPacket targetAddress port
	
]

{ #category : #'Support For NameResolving' }
OCNSocketPluginLibrary >> stringFromAddress: addr [
	"Return a string representing the given host address as four decimal bytes delimited with decimal points."

	| s |
	s := String new writeStream.
	1 to: 3 do: [ :i | (addr at: i) printOn: s. s nextPut: $.].
	(addr at: 4) printOn: s.
	^ s contents

]

{ #category : #'API-TCP' }
OCNSocketPluginLibrary >> tcpDestroy: aSocket [
	
	aSocket socketId ifNil: [ ^self ].
	isDestroyed ifTrue: [^self].
	self primSocketCloseConnection: aSocket socketId.
	self primDestroySocket: aSocket socketId.
	self releaseSemaphores.
	isDestroyed := true
]

{ #category : #'API-TCP' }
OCNSocketPluginLibrary >> tcpReceiveFrom: aSocket [
	| bytesRead |
	bytesRead := self primSocket: aSocket socketId receiveDataInto: self receiveDataBuffer startingAt: 1 count: self receiveDataBuffer size.
	^self receiveDataBuffer copyFrom: 1 to: bytesRead
]

{ #category : #'API-TCP' }
OCNSocketPluginLibrary >> tcpSendData: aByteStringOrByteArray to: aSocket [
	|socketId sentCount| 
	socketId := aSocket socketId.
	sentCount := self 
					primSocket: socketId 
					sendData: aByteStringOrByteArray 
					startIndex: 1 
					count: aByteStringOrByteArray size.
	self 
		waitForSendDoneOn: socketId 
		for: aSocket sendTimeOutSeconds.
	^sentCount


]

{ #category : #'Support For TCP' }
OCNSocketPluginLibrary >> tcpSocketConnectedStatus [
	^2
]

{ #category : #'API-UDP' }
OCNSocketPluginLibrary >> udpDestroy: aSocket [
	
	aSocket socketId ifNil: [ ^self ].
	isDestroyed ifTrue: [^self].
	self primDestroySocket: aSocket socketId.
	self releaseSemaphores.
	isDestroyed := true

]

{ #category : #'Support For NameResolving' }
OCNSocketPluginLibrary >> waitForCompletionUntil: deadline [
	"Wait up to the given number of seconds for the resolver to be ready to accept a new request. Return true if the resolver is ready, false if the network is not initialized or the resolver does not become free within the given time period."

	| status |
	status := self resolverStatus.
	[(status = ResolverBusy) and:
	 [Time millisecondClockValue < deadline]]
		whileTrue: [
			"wait for resolver to be available"
			ResolverSemaphore waitTimeoutMSecs: (deadline - Time millisecondClockValue).
			status := self resolverStatus].

	status = ResolverReady
		ifTrue: [^ true]
		ifFalse: [
			status = ResolverBusy ifTrue: [self primAbortLookup].
			^ false].

]

{ #category : #'Support For TCP' }
OCNSocketPluginLibrary >> waitForConnectionOf: anOCNSocket timeoutSeconds: timeout [
	
	self waitForConnectionOf: anOCNSocket timeoutSeconds: timeout 
		onTimeoutDo: [OCNSocketOperationFailureError signal: 'Connection timeout']

]

{ #category : #'Support For TCP' }
OCNSocketPluginLibrary >> waitForConnectionOf: anOCNSocket timeoutSeconds: timeout onTimeoutDo: aTimeoutBlock [
	| endTime |
	endTime := Time now asSeconds + timeout.
	[(self primSocketConnectionStatus: anOCNSocket socketId) = Connected ifTrue: [^self].
		Time now asSeconds > endTime.
	] whileFalse.
	aTimeoutBlock value

]

{ #category : #'Support For Receiving' }
OCNSocketPluginLibrary >> waitForDataOn: socketId for: timeoutSeconds onTimedOut: timedOutBlock [
	"Wait for the given nr of seconds for data to arrive or signal a TimeOutException."
	
	| startTime msecsDelta |
	startTime := Time millisecondClockValue.
	msecsDelta := (timeoutSeconds * 1000) truncated.
	[(Time millisecondsSince: startTime) < msecsDelta] whileTrue: [
		(self primSocketReceiveDataAvailable: socketId) ifTrue: [^self].
		"(socketId isNil or: [ (self primSocketConnectionStatus: socketId) ~= Connected]) ifTrue: [ 
				
		]."
		"readSemaphore waitTimeoutMSecs: (msecsDelta / 10)".
		(Delay forMilliseconds: msecsDelta / 10) wait
	].
	
	(self primSocketReceiveDataAvailable: socketId) ifFalse: timedOutBlock

]

{ #category : #'Support For NameResolving' }
OCNSocketPluginLibrary >> waitForResolverReadyUntil: deadline [
	"Wait up to the given number of seconds for the resolver to be ready to accept a new request. Return true if the resolver is not busy, false if the network is not initialized or the resolver does not become free within the given time period."

	| status |
	status := self resolverStatus.
	status = ResolverUninitialized ifTrue: [^ false].

	[(status = ResolverBusy) and:
	 [Time millisecondClockValue < deadline]]
		whileTrue: [
			"wait for resolver to be available"
			ResolverSemaphore waitTimeoutMSecs: (deadline - Time millisecondClockValue).
			status := self resolverStatus].

	^ status ~= ResolverBusy

]

{ #category : #'Support For Sending' }
OCNSocketPluginLibrary >> waitForSendDoneOn: socketId for: timeoutSeconds [
	self 
		waitForSendDoneOn: socketId 
		for: timeoutSeconds 
		onTimeOut:  [OCNTimeOutError signal: 'send data timeout; data not sent'].
]

{ #category : #'Support For Sending' }
OCNSocketPluginLibrary >> waitForSendDoneOn: socketId for: timeoutSeconds onTimeOut: aBlock [
	"Wait up until the given deadline for the current send operation to complete. Return true if it completes by the deadline, false if not."

	| startTime msecsDelta msecsEllapsed sendDone |
	
" Look at Socket>>waitForSendDoneUntil: and Socket>>waitForSendDoneFor:"
	
	startTime := Time millisecondClockValue.
	msecsDelta := (timeoutSeconds * 1000) truncated.
	[(sendDone := self primSocketSendDone: socketId) not and: [ socketId notNil
			"Connection end and final data can happen fast, so test in this order"
		and: [(msecsEllapsed := Time millisecondsSince: startTime) < msecsDelta]]] whileTrue: [
			self writeSemaphore waitTimeoutMSecs: msecsDelta - msecsEllapsed].

	sendDone ifFalse: aBlock
]

{ #category : #accessing }
OCNSocketPluginLibrary >> writeSemaIndex [
	^writeSemaIndex
]

{ #category : #'Support For Sending' }
OCNSocketPluginLibrary >> writeSemaphore [
	primitiveOnlySupportsOneSemaphore ifTrue: [^semaphore].
	^writeSemaphore
]
