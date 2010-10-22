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
OCNTcpSocketTest >> assertConnection [
	| serverAddress |
	self startServer.
	self testSocketFileDescriptorCreation.
	self deny: socket isConnected.
	serverAddress := OCNIPV4SocketAddress new.
	serverAddress 
		family: library AfInet;
		ip: #[127 0 0 1]; "localhost should have a server"
		port: self serverPort.
	socket connectToServer: serverAddress.
	self assert: socket isConnected
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
	socket close.
]

{ #category : #testing }
OCNTcpSocketTest >> testCloseOnClosedSocket [
	self assert: socket isClosed.
	self signalFailure: 'it is not true (socket is NOT closed) since it has a valid socketId. close deallocate the socketId!'.
	self deny: socket isConnected.
	socket close.
	self assert: socket isClosed.
	self deny: socket isConnected.
	"self testCloseOnConnectedSocket."


]

{ #category : #testing }
OCNTcpSocketTest >> testCloseOnConnectedSocket [
	self assertConnection.
	self deny: socket isClosed.
	self assert: socket isConnected.
	socket close.
	self assert: socket isClosed.
	self deny: socket isConnected
]

{ #category : #testing }
OCNTcpSocketTest >> testSocketFileDescriptorCreation [
	self assert: socket socketId notNil.
	self deny: socket isConnected.
	self assert: socket isClosed.
]

{ #category : #testing }
OCNTcpSocketTest >> testSocketStatus [
	"use OCNShell with lsof to really test socket state"
	self fail.
]
