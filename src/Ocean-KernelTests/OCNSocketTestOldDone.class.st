Class {
	#name : #OCNSocketTestOldDone,
	#superclass : #TestCase,
	#instVars : [
		'socket',
		'library',
		'server',
		'serverAddress'
	],
	#category : #'Ocean-KernelTests-Old'
}

{ #category : #testing }
OCNSocketTestOldDone class >> isAbstract [
	^true
]

{ #category : #accessing }
OCNSocketTestOldDone class >> lookupHierarchyRoot [
	^self superclass
]

{ #category : #coverage }
OCNSocketTestOldDone class >> packageNamesUnderTest [
	^ #('Ocean-Kernel' 'Ocean-LibraryPlugin')
]

{ #category : #accessing }
OCNSocketTestOldDone class >> shouldBeSubclassedForBackendTesting [
	^false
]

{ #category : #'asserting lifecycle' }
OCNSocketTestOldDone >> assertSocket: aSocket state: aSelectorToAssert [

	| selectorsToDeny |
	
	self assert: (aSocket perform: aSelectorToAssert).
	
	selectorsToDeny := self stateTestingSelectors copyWithout: aSelectorToAssert.
	
	selectorsToDeny do: [ :aSelectorToDeny | 
		self deny: (aSocket perform: aSelectorToDeny)
	]

	
]

{ #category : #'asserting lifecycle' }
OCNSocketTestOldDone >> assertSocketState: aSelectorToAssert [
	self assertSocket: socket state: aSelectorToAssert
]

{ #category : #accessing }
OCNSocketTestOldDone >> library [
	^library 
]

{ #category : #accessing }
OCNSocketTestOldDone >> networkLibraryClass [
	^self subclassResponsibility
]

{ #category : #'data for tests' }
OCNSocketTestOldDone >> randomAsciiStringOfSize: dataSize [
 	^OCNStringGenerator randomStringOfSize: dataSize

]

{ #category : #accessing }
OCNSocketTestOldDone >> server [
	^ server 
]

{ #category : #accessing }
OCNSocketTestOldDone >> serverAddress [
	^ serverAddress 
]

{ #category : #'setUp-tearDown' }
OCNSocketTestOldDone >> serverClass [
	^OCNTcpReceivingServerForTest 
]

{ #category : #accessing }
OCNSocketTestOldDone >> serverPort [
	^9123
]

{ #category : #'setUp-tearDown' }
OCNSocketTestOldDone >> setUp [
	super setUp.
	library := OCNNetworkLibraryProxyFactory proxyForLibraryClass: self networkLibraryClass.
	self setUpSocketWithLibrary: self library.	
	serverAddress := OCNIpv4Address loopbackAddressWithPort:  self serverPort.

]

{ #category : #'setUp-tearDown' }
OCNSocketTestOldDone >> setUpServer [
	server:= self serverClass onPortNumber: self serverPort 
]

{ #category : #'setUp-tearDown' }
OCNSocketTestOldDone >> setUpSocketWithLibrary: aLibrary [
	socket := self socketClass newWithNetworkLibrary: aLibrary
]

{ #category : #accessing }
OCNSocketTestOldDone >> socket [ 
	^socket
]

{ #category : #accessing }
OCNSocketTestOldDone >> socketClass [ 
	^self subclassResponsibility 
]

{ #category : #'server management' }
OCNSocketTestOldDone >> startServer [
	self setUpServer.
	server start.
	(Delay forMilliseconds: 50) wait
]

{ #category : #accessing }
OCNSocketTestOldDone >> stateTestingSelectors [ 
	^self subclassResponsibility 
]

{ #category : #'setUp-tearDown' }
OCNSocketTestOldDone >> tearDown [
	super tearDown.
	server ifNotNil: [ server kill ].
	socket ifNotNil: [socket destroy].
]

{ #category : #testing }
OCNSocketTestOldDone >> testDestroyDestroyedSocket [
	self testDestroyUnconnectedSocket.
	self assertSocketState: #isDestroyed.
	self shouldnt: [socket destroy] raise: Error.
	self assertSocketState: #isDestroyed.
	
]

{ #category : #testing }
OCNSocketTestOldDone >> testDestroyUnconnectedSocket [
	self assertSocketState: #isClean.
	socket destroy.
	self assertSocketState: #isDestroyed.

]
