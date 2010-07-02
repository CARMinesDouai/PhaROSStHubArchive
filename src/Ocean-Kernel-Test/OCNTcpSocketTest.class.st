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

{ #category : #'setUp-tearDown' }
OCNTcpSocketTest >> serverPort [
	^9123
]

{ #category : #'setUp-tearDown' }
OCNTcpSocketTest >> setUp [
	super setUp.
	socket := OCNTcpSocket new.
	library := OCNConstants socketLibrary.
	server := OCNNetCatBasedServer port: self serverPort.
	server start.
	(Delay forMilliseconds: 5) wait.
]

{ #category : #'setUp-tearDown' }
OCNTcpSocketTest >> tearDown [
	super tearDown.
	server stop.
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
	serverAddress := OCNSocketAddress new.
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
	| serverAddress messageText |
	self testConnection.
	messageText := 'Message from Pharo using SysSocketLibrary'.
	OCNConstants debug ifTrue: [messageText := messageText, ' [debug]'].
	self assert: ((socket send: messageText) =  messageText byteSize).
	self signalFailure: 'Need to rewrite the test using NetCat to check that the other side really receives the exact bytes'
]

{ #category : #testing }
OCNTcpSocketTest >> testSendingLargeAmountOfData [
	"Go beyond Socket>>alienDataBufferSize"
	self fail
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
