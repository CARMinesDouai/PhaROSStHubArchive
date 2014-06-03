Class {
	#name : #OCNSocket,
	#superclass : #Object,
	#instVars : [
		'socketId',
		'networkLibrary',
		'state'
	],
	#category : #'Ocean-Kernel'
}

{ #category : #'instance creation' }
OCNSocket class >> new [
	^self newWithNetworkLibraryClass: OCNNetworkLibraryProxyFactory defaultNetworkLibraryProxyClass
]

{ #category : #'instance creation' }
OCNSocket class >> newWithNetworkLibrary: aNetworkLibraryProxy [
	^self basicNew 
		networkLibrary: aNetworkLibraryProxy;
		initialize;
		yourself
]

{ #category : #'instance creation' }
OCNSocket class >> newWithNetworkLibraryClass: aNetworkLibraryClass [
	^self newWithNetworkLibrary: (OCNNetworkLibraryProxyFactory proxyForLibraryClass:  aNetworkLibraryClass)
]

{ #category : #constants }
OCNSocket class >> receiveDataBufferSize [
	^2048
]

{ #category : #constants }
OCNSocket class >> sendDataBufferSize [
	^2048
]

{ #category : #connection }
OCNSocket >> basicDestroy [
	self state: self destroyedStateSymbol.

]

{ #category : #connecting }
OCNSocket >> bindToAddress: anIpAddress [ 
	self isClean ifFalse: [ 
		OCNSocketOperationForbiddenError signal: self state asString capitalized, ' socket can not be bound' ].
	[
		self networkLibrary bind: self toIpv4Address: anIpAddress
	] on: OCNSocketOperationFailureError do: [:ex|
		self destroy.
		ex pass.
	].
	self state: self boundStateSymbol
	
]

{ #category : #connecting }
OCNSocket >> bindToLocalHostPort: aPortNumber [ 
	| localhostAddress |
	localhostAddress := OCNIpv4Address loopbackAddressWithPort: aPortNumber.
	self bindToAddress: localhostAddress 	
]

{ #category : #'state names' }
OCNSocket >> boundStateSymbol [
	^#bound

]

{ #category : #'state names' }
OCNSocket >> cleanStateSymbol [
	^ #clean
]

{ #category : #'backward compatibility' }
OCNSocket >> closeAndDestroy [
	
	^ self destroy 
]

{ #category : #connection }
OCNSocket >> destroy [
	self isDestroyed
		ifTrue: [ ^ self ].
	self basicDestroy
]

{ #category : #'state names' }
OCNSocket >> destroyedStateSymbol [
	^ #destroyed
]

{ #category : #finalization }
OCNSocket >> finalize [ 
	super finalize.
	self destroy.
]

{ #category : #accessing }
OCNSocket >> getOption: aName [ 
	"Get options on this socket, see Unix man pages for values for 
	sockets, IP, TCP, UDP. IE SO_KEEPALIVE
	returns an array, element one is an status number (0 ok, -1 read only option)
	element two is the resulting of the requested option"

	self isValid
		ifFalse: [OCNSocketOperationForbiddenError signal: 'Socket must be clean before getting an option'].
	^self networkLibrary primSocket: socketId getOption: aName

"| foo options |
Socket initializeNetwork.
foo := Socket newTCP.
foo connectTo: (NetNameResolver addressFromString: '192.168.1.1') port: 80.
foo waitForConnectionUntil: (Socket standardDeadline).

options := {
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
	fum :=foo getOption: (options at: i).
	Transcript show: (options at: i),fum printString;cr].

foo := Socket newUDP.
foo setPeer: (NetNameResolver addressFromString: '192.168.1.9') port: 7.
foo waitForConnectionUntil: (Socket standardDeadline).

1 to: options size do: [:i | | fum |
	fum :=foo getOption: (options at: i).
	Transcript show: (options at: i),fum printString;cr].
"
]

{ #category : #'initialize-release' }
OCNSocket >> initialize [
	super initialize.
	self state: self cleanStateSymbol.
	self socketId ifNotNil: [ ^self ].
	self initializeWithId: self newSocketId
]

{ #category : #'initialize-release' }
OCNSocket >> initializeWithId: aSocketId [
	[self socketId: aSocketId] 
		on: OCNSocketOperationFailureError 
		do: [:ex|
			self destroy.
			ex pass].
	WeakRegistry default add: self. "to ensure future finalization"


]

{ #category : #'state testing' }
OCNSocket >> isBound [
	^self state = self boundStateSymbol
]

{ #category : #'state testing' }
OCNSocket >> isClean [
	^self state = self cleanStateSymbol
]

{ #category : #'state testing' }
OCNSocket >> isDestroyed [
	^self state = self destroyedStateSymbol
]

{ #category : #'state testing' }
OCNSocket >> isValid [
	^ self isDestroyed not
]

{ #category : #accessing }
OCNSocket >> networkLibrary [
	^ networkLibrary ifNil: [ networkLibrary := OCNNetworkLibraryProxyFactory networkLibraryProxy ]
]

{ #category : #accessing }
OCNSocket >> networkLibrary: anObject [
	networkLibrary := anObject
]

{ #category : #'initialize-release' }
OCNSocket >> newSocketId [
	self subclassResponsibility 
]

{ #category : #constants }
OCNSocket >> receiveDataBufferSize [
	^self class receiveDataBufferSize 
]

{ #category : #constants }
OCNSocket >> sendDataBufferSize [
	^self class sendDataBufferSize 
]

{ #category : #accessing }
OCNSocket >> setOption: aName value: aValue [ 
	| value |
	"setup options on this socket, see Unix man pages for values for 
	sockets, IP, TCP, UDP. IE SO_KEEPALIVE
	returns an array, element one is the error number
	element two is the resulting of the negotiated value.
	See getOption for list of keys"

	self isValid
		ifFalse: [InvalidSocketStatusException signal: 'Socket status must valid before setting an option'].
	value := aValue asString.
	aValue == true ifTrue: [value := '1'].
	aValue == false ifTrue: [value := '0'].
	^ self networkLibrary primSocket: socketId setOption: aName value: value
]

{ #category : #accessing }
OCNSocket >> socketId [
	^ socketId
]

{ #category : #accessing }
OCNSocket >> socketId: anObject [
	socketId := anObject.
]

{ #category : #accessing }
OCNSocket >> state [
	^ state
]

{ #category : #private }
OCNSocket >> state: anObject [
	
	state := anObject
]
