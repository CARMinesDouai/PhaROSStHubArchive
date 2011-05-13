Class {
	#name : #OCNSocketTest,
	#superclass : #TestCase,
	#instVars : [
		'socket',
		'library',
		'server',
		'serverAddress'
	],
	#category : #'Ocean-Kernel-Test'
}

{ #category : #'as yet unclassified' }
OCNSocketTest class >> allTestSelectors [ 
	^self superclass testSelectors, self testSelectors
]

{ #category : #testing }
OCNSocketTest class >> isAbstract [
	^true
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
	| randomStringGenerator |
	randomStringGenerator := OCNBench new.
	^ randomStringGenerator createRandomStringOfSize: dataSize.

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
	socket := self socketClass newWithNetworkLibrary: self library.
	serverAddress := OCNIpv4Address loopbackAddressWithPort:  self serverPort.

]

{ #category : #'setUp-tearDown' }
OCNSocketTest >> setUpServer [
	server:= self serverClass onPortNumber: self serverPort 
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
	socket destroy.
]

{ #category : #testing }
OCNSocketTest >> testSocketCreationFailure [
	self signalFailure: 'test that an exception is raised when socket creation fails'
]

{ #category : #testing }
OCNSocketTest >> testSocketFinalization [
	self signalFailure: 'socket finalized before GC collection'
]

{ #category : #testing }
OCNSocketTest >> testSocketRestoredAtImageStartup [
	self signalFailure: 'socket restored in the same state when image startup'
]
