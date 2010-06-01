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
	server start
]

{ #category : #'setUp-tearDown' }
OCNTCPSocketTest >> tearDown [
	super tearDown.
	server stop.
	socket close
]

{ #category : #testing }
OCNTCPSocketTest >> testCloseOnClosedSocket [
	self fail
]

{ #category : #testing }
OCNTCPSocketTest >> testCloseOnConnectedSocket [
	self fail
]

{ #category : #testing }
OCNTCPSocketTest >> testCloseOnNonConnectedSocket [
	self fail
]

{ #category : #testing }
OCNTCPSocketTest >> testConnection [
	| serverAddress |
	socket 
		createDescriptorWithDomain: library PfInet
	 	type: library SockStream
		protocol: library IpProtoTcp.
	self assert: socket isDescriptorCreated.
	self deny: socket isConnected.
	serverAddress := OCNSocketAddress new.
	serverAddress 
		family: library AfInet;
		ip: #[127 0 0 1]; "localhost should have a server"
		port: self serverPort.
	(Delay forMilliseconds: 500) wait.
	socket connectToServer: serverAddress.
	self assert: socket isConnected
]

{ #category : #testing }
OCNTCPSocketTest >> testSend [
	"this test requires an echo server on 127.0.0.1:30000 "
	| serverAddress messageText |
	socket 
		createDescriptorWithDomain: library PfInet
	 	type: library SockStream
		protocol: library IpProtoTcp.
	self assert: socket isDescriptorCreated.
	self deny: socket isConnected.
	serverAddress := OCNSocketAddress new.
	serverAddress 
		family: library AfInet;
		ip: #[127 0 0 1]; "localhost should have a server"
		port: self serverPort.
	(Delay forMilliseconds: 500) wait.	
	socket connectToServer: serverAddress.
	self assert: socket isConnected.
	messageText := 'Message from Pharo using SysSocketLibrary'.
	OCNConstants debug ifTrue: [messageText := messageText, ' [debug]'].
	self assert: ((socket send: messageText) =  messageText byteSize).
	self assert: (socket close = 0)
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
