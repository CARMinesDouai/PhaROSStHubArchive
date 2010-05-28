Class {
	#name : #OCNTCPSocketConnectTest,
	#superclass : #TestCase,
	#instVars : [
		'socket',
		'library'
	],
	#category : #'Ocean-Kernel-Test'
}

{ #category : #'setUp-tearDown' }
OCNTCPSocketConnectTest >> setUp [
	super setUp.
	socket := OCNSocket new.
	library := OCNConstants socketLibrary
]

{ #category : #testing }
OCNTCPSocketConnectTest >> testConnection [
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
		port: 80.
	socket connectToServer: serverAddress.
	self assert: socket isConnected
]

{ #category : #testing }
OCNTCPSocketConnectTest >> testSend [
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
		port: 30000.
	socket connectToServer: serverAddress.
	self assert: socket isConnected.
	messageText := 'Message from Pharo using SysSocketLibrary'.
	OCNConstants debug ifTrue: [messageText := messageText, ' [debug]'].
	self assert: ((socket send: messageText) =  messageText byteSize).
	self assert: (socket close = 0)
]

{ #category : #testing }
OCNTCPSocketConnectTest >> testSocketFileDescriptorCreation [
	| communicationDomain socketType socketProtocol |
	self deny: socket isDescriptorCreated.
	socket 
		createDescriptorWithDomain: library PfInet
	 	type: library SockStream
		protocol: library IpProtoTcp.
	self assert: socket isDescriptorCreated
]
