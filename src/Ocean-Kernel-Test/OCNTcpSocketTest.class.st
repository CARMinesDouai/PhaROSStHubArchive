Class {
	#name : #OCNTcpSocketTest,
	#superclass : #TestCase,
	#instVars : [
		'server',
		'socket',
		'library'
	],
	#category : #'Ocean-Kernel-Test'
}

{ #category : #testing }
OCNTcpSocketTest >> assertSendingDataOfSize: dataSize [
	| dataToSendStream wideStringToSend byteStringToSend|
	dataToSendStream := FileStream fileNamed: SmalltalkImage current sourcesName.
	[wideStringToSend := dataToSendStream next: dataSize] ensure:  [dataToSendStream close].
	byteStringToSend := ByteString fromByteArray: (wideStringToSend asByteArray).
	self assert: (socket send: byteStringToSend) = dataSize.
	(Delay forMilliseconds: 50) wait.
	self assert: server stdOut upToEnd withoutTrailingBlanks = byteStringToSend
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
	server := OCNShell new. 
	server exec: 'nc -4 -lk localhost', String space, self serverPort printString.
	(Delay forMilliseconds: 50) wait
]

{ #category : #'setUp-tearDown' }
OCNTcpSocketTest >> tearDown [
	super tearDown.
	server kill.
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
OCNTcpSocketTest >> testReceive [
	self fail
]

{ #category : #testing }
OCNTcpSocketTest >> testReceivingLargeAmountOfData [
	"Go beyond Socket>>alienDataBufferSize"
	self fail
]

{ #category : #testing }
OCNTcpSocketTest >> testSend [
	"Go beyond Socket>>defaultDataBufferSize"

	self testConnection.
	{socket defaultDataBufferSize//2 . 
		2 * socket defaultDataBufferSize. 
		1000 * socket defaultDataBufferSize
	} do: [:dataSize| 
		self assertSendingDataOfSize: dataSize].

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
