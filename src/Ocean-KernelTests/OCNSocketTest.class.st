Class {
	#name : #OCNSocketTest,
	#superclass : #TestCase,
	#instVars : [
		'socket',
		'library',
		'server',
		'serverAddress'
	],
	#category : #'Ocean-KernelTests'
}

{ #category : #testing }
OCNSocketTest class >> isAbstract [
	^true
]

{ #category : #accessing }
OCNSocketTest class >> lookupHierarchyRoot [
	^self superclass
]

{ #category : #accessing }
OCNSocketTest class >> shouldBeSubclassedForBackendTesting [
	^false
]

{ #category : #'asserting lifecycle' }
OCNSocketTest >> assertSocket: aSocket state: aSelectorToAssert [

	| selectorsToDeny |
	
	self assert: (aSocket perform: aSelectorToAssert).
	
	selectorsToDeny := self stateTestingSelectors copyWithout: aSelectorToAssert.
	
	selectorsToDeny do: [ :aSelectorToDeny | 
		self deny: (aSocket perform: aSelectorToDeny)
	]

	
]

{ #category : #'asserting lifecycle' }
OCNSocketTest >> assertSocketState: aSelectorToAssert [
	self assertSocket: socket state: aSelectorToAssert
]

{ #category : #accessing }
OCNSocketTest >> library [
	^library 
]

{ #category : #accessing }
OCNSocketTest >> networkLibraryClass [
	^self subclassResponsibility
]

{ #category : #'data for tests' }
OCNSocketTest >> randomAsciiStringOfSize: dataSize [
 	^OCNStringGenerator randomStringOfSize: dataSize

]

{ #category : #accessing }
OCNSocketTest >> server [
	^ server 
]

{ #category : #accessing }
OCNSocketTest >> serverAddress [
	^ serverAddress 
]

{ #category : #'setUp-tearDown' }
OCNSocketTest >> serverClass [
	^OCNTcpReceivingServerForTest 
]

{ #category : #accessing }
OCNSocketTest >> serverPort [
	^9123
]

{ #category : #'setUp-tearDown' }
OCNSocketTest >> setUp [
	super setUp.
	library := OCNNetworkLibraryProxyFactory proxyForLibraryClass: self networkLibraryClass.
	self setUpSocketWithLibrary: self library.	
	serverAddress := OCNIpv4Address loopbackAddressWithPort:  self serverPort.

]

{ #category : #'setUp-tearDown' }
OCNSocketTest >> setUpServer [
	server:= self serverClass onPortNumber: self serverPort 
]

{ #category : #'setUp-tearDown' }
OCNSocketTest >> setUpSocketWithLibrary: aLibrary [
	socket := self socketClass newWithNetworkLibrary: aLibrary
]

{ #category : #accessing }
OCNSocketTest >> socket [ 
	^socket
]

{ #category : #accessing }
OCNSocketTest >> socketClass [ 
	^self subclassResponsibility 
]

{ #category : #'server management' }
OCNSocketTest >> startServer [
	self setUpServer.
	server start.
	(Delay forMilliseconds: 50) wait
]

{ #category : #accessing }
OCNSocketTest >> stateTestingSelectors [ 
	^self subclassResponsibility 
]

{ #category : #'setUp-tearDown' }
OCNSocketTest >> tearDown [
	super tearDown.
	server ifNotNil: [ server kill ].
	socket ifNotNil: [socket destroy].
]

{ #category : #testing }
OCNSocketTest >> testDestroyDestroyedSocket [
	self testDestroyUnconnectedSocket.
	self assertSocketState: #isDestroyed.
	self shouldnt: [socket destroy] raise: Error.
	self assertSocketState: #isDestroyed.
	
]

{ #category : #testing }
OCNSocketTest >> testDestroyUnconnectedSocket [
	self assertSocketState: #isClean.
	socket destroy.
	self assertSocketState: #isDestroyed.

]
