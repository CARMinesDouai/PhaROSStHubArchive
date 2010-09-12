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
OCNTcpSocketTest >> assertSendingDataOfSize: dataSize [
	| dataToSend receivedData | 
	self testConnection.
	dataToSend := self randomAsciiStringOfSize: dataSize.
	self assert: (socket send: dataToSend) = dataSize.
	(Delay forMilliseconds: 50) wait.
	receivedData := serverShell stdOut contents.
	self assert: receivedData size = dataSize.
	self assert: receivedData = dataToSend.

]

{ #category : #'setUp-tearDown' }
OCNTcpSocketTest >> createServerShell [
	serverShell := OCNFileStdOutShell onStdOutFileNamed: 'test.log'
]

{ #category : #testing }
OCNTcpSocketTest >> randomAsciiStringOfSize: dataSize [
	| allCharacters dataToSendStream |
	allCharacters := Character alphabet.
	dataToSendStream := WriteStream on: (String new: dataSize).
	dataSize timesRepeat: [ dataToSendStream nextPut: allCharacters atRandom ].
	^ dataToSendStream contents
]

{ #category : #'setUp-tearDown' }
OCNTcpSocketTest >> serverPort [
	^9123
]

{ #category : #'setUp-tearDown' }
OCNTcpSocketTest >> setUp [
	super setUp.
	socket := OCNTcpSocket new.
	library := OCNConstants socketLibrary.
	self createServerShell.
	self startServer
]

{ #category : #'setUp-tearDown' }
OCNTcpSocketTest >> startServer [
	serverShell exec: 'nc -4 -l ' , String space , self serverPort printString.
	(Delay forMilliseconds: 50) wait
]

{ #category : #'setUp-tearDown' }
OCNTcpSocketTest >> tearDown [
	super tearDown.
	serverShell deleteStdOutFile.
	serverShell kill.
	socket close
]

{ #category : #testing }
OCNTcpSocketTest >> testCloseOnClosedSocket [
	self testCloseOnConnectedSocket.
	socket close.
	self assert: socket isClosed 
]

{ #category : #testing }
OCNTcpSocketTest >> testCloseOnConnectedSocket [
	self testConnection.
	self assert: socket isClosed not.
	socket close.
	self assert: socket isClosed
]

{ #category : #testing }
OCNTcpSocketTest >> testCloseOnNonConnectedSocket [
	self testSocketFileDescriptorCreation.
	self assert: socket isClosed not.
	socket close.
	self flag: #LF.
	"self should: [self socket close] raise: OCNNonConnectedSocketExecption."
	self assert: socket isClosed not
]

{ #category : #testing }
OCNTcpSocketTest >> testConnection [
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

{ #category : #testing }
OCNTcpSocketTest >> testDisconnectionWhileReceiving [
	self fail
]

{ #category : #testing }
OCNTcpSocketTest >> testDisconnectionWhileSending [
	self fail
]

{ #category : #testing }
OCNTcpSocketTest >> testSendingLargeAmountOfDataComparedToSizeOfSocketsDataBuffer [
	self assertSendingDataOfSize: 1000 * socket defaultDataBufferSize.

]

{ #category : #testing }
OCNTcpSocketTest >> testSendingLessDataThanSocketsDataBufferSize [
	self assertSendingDataOfSize: socket defaultDataBufferSize//2 .

]

{ #category : #testing }
OCNTcpSocketTest >> testSendingMoreDataThanSizeOfSocketsDataBuffer [
	self assertSendingDataOfSize: 2 * socket defaultDataBufferSize.

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
