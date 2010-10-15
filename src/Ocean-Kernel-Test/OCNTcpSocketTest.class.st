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
OCNTcpSocketTest >> testCloseOnNonConnectedSocket [
	self testSocketFileDescriptorCreation.
	self assert: socket isClosed not.
	socket close.
	"self should: [self socket close] raise: OCNNonConnectedSocketExecption."
	self assert: socket isClosed not.
	self signalFailure:  'TODO should raise an execption'.
]

{ #category : #testing }
OCNTcpSocketTest >> testSocketFileDescriptorCreation [
	| communicationDomain socketType socketProtocol |
	self deny: socket isDescriptorCreated.
	socket 
		createDescriptorWithDomain: library PfInet
	 	type: library SockStream
		protocol: library IpProtoTcp.
	self assert: socket isDescriptorCreated
]

{ #category : #testing }
OCNTcpSocketTest >> testSocketStatus [
	"use OCNShell with lsof to really test socket state"
	self fail.
]
