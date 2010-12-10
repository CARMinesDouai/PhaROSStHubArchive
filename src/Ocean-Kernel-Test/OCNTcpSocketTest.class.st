Class {
	#name : #OCNTcpSocketTest,
	#superclass : #TestCase,
	#instVars : [
		'socket',
		'library',
		'serverShell'
	],
	#category : #'Ocean-Kernel-Test'
}

{ #category : #testing }
OCNTcpSocketTest >> assertSocket: aSocket state: aSelectorToAssert [

	| selectorsToDeny |
	
	self assert: (aSocket perform: aSelectorToAssert).
	
	selectorsToDeny := #(#isUnconnected #isBound #isConnected isDestroyed) copyWithout: aSelectorToAssert.
	
	selectorsToDeny do: [ :aSelectorToDeny | 
		self deny: (aSocket perform: aSelectorToDeny)
	]

	
]

{ #category : #testing }
OCNTcpSocketTest >> assertSocketState: aSelectorToAssert [
	self assertSocket: socket state: aSelectorToAssert
]

{ #category : #testing }
OCNTcpSocketTest >> clientPort [
	^ 2222
]

{ #category : #testing }
OCNTcpSocketTest >> connect [
	| serverAddress |
	self startServer.
	serverAddress := OCNIPV4SocketAddress loopbackAddressWithPort:  self serverPort.	
	socket connectToServer: serverAddress.

]

{ #category : #generating }
OCNTcpSocketTest >> randomAsciiStringOfSize: dataSize [
	| randomStringGenerator |
	randomStringGenerator := OCNBench new.
	^ randomStringGenerator createRandomStringOfSize: dataSize.

]

{ #category : #accessing }
OCNTcpSocketTest >> serverPort [
	^9123
]

{ #category : #accessing }
OCNTcpSocketTest >> serverShellClass [ 
	^OCNFileStdOutShell
]

{ #category : #'setUp-tearDown' }
OCNTcpSocketTest >> setUp [
	super setUp.
	socket := OCNTcpSocket new.
	library := OCNNetworkLibraryProxyFactory networkLibraryProxy.
	self setUpServerShell.

]

{ #category : #'setUp-tearDown' }
OCNTcpSocketTest >> setUpServerShell [
	serverShell := self serverShellClass onStdOutFileNamed: 'test.log'
]

{ #category : #'server management' }
OCNTcpSocketTest >> startServer [
	serverShell exec: 'nc -4 -l ' , String space , self serverPort printString.
	(Delay forMilliseconds: 50) wait
]

{ #category : #'setUp-tearDown' }
OCNTcpSocketTest >> tearDown [
	super tearDown.
	serverShell deleteStdOutFile.
	serverShell kill.
	socket destroy.
]

{ #category : #'testing lifecylce' }
OCNTcpSocketTest >> testBindBoundSocket [
	
	| initialPort otherPort |
	initialPort := self clientPort.
	otherPort := 9125.
	self assertSocketState: #isUnconnected.
	socket bindToLocalHostPort: initialPort.	
	self assertSocketState: #isBound.
	self should: [socket bindToLocalHostPort: initialPort] raise: OCNSocketOperationForbiddenError.	
	self assertSocketState: #isBound.
	self should: [socket bindToLocalHostPort: otherPort] raise: OCNSocketOperationForbiddenError.	
	self assertSocketState: #isBound
	
]

{ #category : #'testing lifecylce' }
OCNTcpSocketTest >> testBindConnectedSocket [
	self connect.
	self assertSocketState: #isConnected.
	self should: [socket bindToLocalHostPort: self serverPort] raise: OCNSocketOperationForbiddenError.
	self assertSocketState: #isConnected
	
]

{ #category : #'testing lifecylce' }
OCNTcpSocketTest >> testBindDestroyedSocket [
	socket destroy.
	self assertSocketState: #isDestroyed.
	self should: [socket bindToLocalHostPort: self serverPort] raise: OCNSocketOperationForbiddenError.
	self assertSocketState: #isDestroyed
	
]

{ #category : #testing }
OCNTcpSocketTest >> testBindFailureOfUnconnectedSocket [
	| socketThatShouldFail |
	socket bindToLocalHostPort: self serverPort.
	self assertSocketState: #isBound.
	socketThatShouldFail :=  OCNTcpSocket new.
	self assertSocket: socketThatShouldFail state: #isUnconnected.
	[
		self should: [socketThatShouldFail bindToLocalHostPort: self serverPort] raise: OCNSocketOperationFailureError.
		self assertSocket: socketThatShouldFail state: #isDestroyed.
	] ensure: [
	socketThatShouldFail destroy].
	self assertSocketState: #isBound.
	
]

{ #category : #testing }
OCNTcpSocketTest >> testBindUnconnectedSocket [
	| socketAddress expectedClientPort |
	self testSocketUnconnectedOnCreation.
	socketAddress := OCNIPV4SocketAddress loopbackAddressWithPort:  self serverPort.	
	socket bindToAddress: socketAddress.
	self assertSocketState: #isBound.
	self signalFailure: 'Ensures that client socket is bount to clientPort '
]

{ #category : #testing }
OCNTcpSocketTest >> testConnectBoundSocket [
	self testBindUnconnectedSocket.
	self connect.
	self assertSocketState: #isConnected
]

{ #category : #testing }
OCNTcpSocketTest >> testConnectConnectedSocket [
	self connect.
	self assertSocketState: #isConnected.
	self shouldnt: [ self connect ] raise: Error.
	self assertSocketState: #isConnected
	
]

{ #category : #testing }
OCNTcpSocketTest >> testConnectDestroyedSocket [
	socket destroy.
	self assertSocketState: #isDestroyed.
	self should: [self connect] raise: Error.
	self assertSocketState: #isDestroyed
]

{ #category : #testing }
OCNTcpSocketTest >> testConnectFailureOfBountSocket [
	self fail
]

{ #category : #testing }
OCNTcpSocketTest >> testConnectFailureOfUnconnectedSocket [
	self fail
]

{ #category : #testing }
OCNTcpSocketTest >> testConnectUnconnectedSocket [
	self fail
]

{ #category : #testing }
OCNTcpSocketTest >> testDestroyBoundSocket [
	self fail
]

{ #category : #testing }
OCNTcpSocketTest >> testDestroyConnectedSocket [
	self connect.
	self assertSocketState: #isConnected.
	socket destroy.
	self assertSocketState: #isDestroyed
]

{ #category : #testing }
OCNTcpSocketTest >> testDestroyDestroyedSocket [
	self fail
]

{ #category : #testing }
OCNTcpSocketTest >> testDestroyFailureOfSocketInAnyState [
	self fail
]

{ #category : #testing }
OCNTcpSocketTest >> testDestroyUnconnectedSocket [
	self fail
]

{ #category : #testing }
OCNTcpSocketTest >> testSocketFinalization [
	self signalFailure: 'socket finalized before GC collection'
]

{ #category : #testing }
OCNTcpSocketTest >> testSocketRestoredAtImageStartup [
	self signalFailure: 'socket restored in the same state when image startup'
]

{ #category : #testing }
OCNTcpSocketTest >> testSocketUnconnectedOnCreation [
	self assert: socket socketId notNil.
	self assertSocketState:  #isUnconnected.

]

{ #category : #testing }
OCNTcpSocketTest >> testTcpAPIRaiseExecptions [
	self signalFailure: 'bind, connect, ... should raise exceptions on failure'
]
