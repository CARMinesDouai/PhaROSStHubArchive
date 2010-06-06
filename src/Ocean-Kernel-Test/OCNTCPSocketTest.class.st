Class {
	#name : #OCNTCPSocketTest,
	#superclass : #TestCase,
	#instVars : [
		'server',
		'socket',
		'library'
	],
	#category : #'Ocean-Kernel-Test'
}

{ #category : #'setUp-tearDown' }
OCNTCPSocketTest >> serverPort [
	^9123
]

{ #category : #'setUp-tearDown' }
OCNTCPSocketTest >> setUp [
	super setUp.
	socket := OCNSocket new.
	library := OCNConstants socketLibrary.
	server := OCNNetCatBasedServer port: self serverPort.
	server start.
	(Delay forMilliseconds: 5) wait.
]

{ #category : #'setUp-tearDown' }
OCNTCPSocketTest >> tearDown [
	super tearDown.
	server stop.
	socket close
]

{ #category : #testing }
OCNTCPSocketTest >> testCloseOnClosedSocket [
	self testCloseOnConnectedSocket.
	socket close.
	self assert: socket isClosed 
]

{ #category : #testing }
OCNTCPSocketTest >> testCloseOnConnectedSocket [
	self testConnection.
	self assert: socket isClosed not.
	socket close.
	self assert: socket isClosed
]

{ #category : #testing }
OCNTCPSocketTest >> testCloseOnNonConnectedSocket [
	self testSocketFileDescriptorCreation.
	self assert: socket isClosed not.
	socket close.
	self flag: #LF.
	"self should: [self socket close] raise: OCNNonConnectedSocketExecption."
	self assert: socket isClosed not
]

{ #category : #testing }
OCNTCPSocketTest >> testConnection [
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
OCNTCPSocketTest >> testSend [
	| serverAddress messageText |
	self testConnection.
	messageText := 'Message from Pharo using SysSocketLibrary'.
	OCNConstants debug ifTrue: [messageText := messageText, ' [debug]'].
	self assert: ((socket send: messageText) =  messageText byteSize)
]

{ #category : #testing }
OCNTCPSocketTest >> testSocketFileDescriptorCreation [
	| communicationDomain socketType socketProtocol |
	self deny: socket isDescriptorCreated.
	socket 
		createDescriptorWithDomain: library PfInet
	 	type: library SockStream
		protocol: library IpProtoTcp.
	self assert: socket isDescriptorCreated
]
