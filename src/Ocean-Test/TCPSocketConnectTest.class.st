Class {
	#name : #TCPSocketConnectTest,
	#superclass : #TestCase,
	#instVars : [
		'socket',
		'library'
	],
	#category : #'Ocean-Test'
}

{ #category : #'setUp-tearDown' }
TCPSocketConnectTest >> setUp [
	super setUp.
	socket := NGSocket new.
	library := SysSocketLibrary uniqueInstance
]

{ #category : #testing }
TCPSocketConnectTest >> testConnection [
	| serverAddress |
	socket 
		createDescriptorWithDomain: library PfInet
	 	type: library SockStream
		protocol: library IpProtoTcp.
	self assert: socket isDescriptorCreated.
	self deny: socket isConnected.
	serverAddress := NGSocketAddress new.
	serverAddress 
		family: library AfInet;
		ip: #[127 0 0 1]; "localhost should have a server"
		port: 80.
	socket connectToServer: serverAddress.
	self assert: socket isConnected
]

{ #category : #testing }
TCPSocketConnectTest >> testSocketFileDescriptorCreation [
	| communicationDomain socketType socketProtocol |
	self deny: socket isDescriptorCreated.
	socket 
		createDescriptorWithDomain: library PfInet
	 	type: library SockStream
		protocol: library IpProtoTcp.
	self assert: socket isDescriptorCreated
]
