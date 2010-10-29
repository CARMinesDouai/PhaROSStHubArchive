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
OCNTcpSocketTest >> assertSocketState: aSelectorToAssert [

	| selectorsToDeny |
	
	self assert: (socket perform: aSelectorToAssert).
	
	selectorsToDeny := #(#isUnconnected #isBound #isConnected isDestroyed) copyWithout: aSelectorToAssert.
	
	selectorsToDeny do: [ :aSelectorToDeny | 
		self deny: (socket perform: aSelectorToDeny)
	]

	
]

{ #category : #testing }
OCNTcpSocketTest >> clientPort [
	^ 2222
]

{ #category : #testing }
OCNTcpSocketTest >> connect [
	| serverAddress |
	self startServer.
	serverAddress := OCNIPV4SocketAddress new.
	serverAddress 
		family: library AfInet;
		ip: #[127 0 0 1]; "localhost should have a server"
		port: self serverPort.
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

{ #category : #testing }
OCNTcpSocketTest >> testBindBoundSocket [
	self fail
]

{ #category : #testing }
OCNTcpSocketTest >> testBindConnectedSocket [
	self fail
]

{ #category : #testing }
OCNTcpSocketTest >> testBindDestroyedSocket [
	self fail
]

{ #category : #testing }
OCNTcpSocketTest >> testBindUnconnectedSocket [
	| socketAddress expectedClientPort |
	self testSocketUnconnectedOnCreation.
	socketAddress := (OCNIPV4SocketAddress new)
		family: library AfInet;
		ip: #[127 0 0 1];
		port: self clientPort.	
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
	self fail
]

{ #category : #testing }
OCNTcpSocketTest >> testConnectDestroyedSocket [
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
OCNTcpSocketTest >> testDestroyUnconnectedSocket [
	self fail
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

{ #category : #testing }
OCNTcpSocketTest >> testUnconnectBoundSocket [
	self fail
]

{ #category : #testing }
OCNTcpSocketTest >> testUnconnectConnectedSocket [
	self fail
]

{ #category : #testing }
OCNTcpSocketTest >> testUnconnectDestroyedSocket [
	self fail
]

{ #category : #testing }
OCNTcpSocketTest >> testUnconnectUnconnectedSocket [
	self fail
]
