Class {
	#name : #NeMulticastSocketTest,
	#superclass : #TestCase,
	#instVars : [
		'socket',
		'multicastPort'
	],
	#category : #'NetworkExtras-UDP-Kernel'
}

{ #category : #testing }
NeMulticastSocketTest >> setUp [
	super setUp.
	multicastPort := 1234.
	socket := NeMulticastSocketRefactored
				group: '226.0.0.12'
				port: multicastPort
]

{ #category : #testing }
NeMulticastSocketTest >> tearDown [
	super tearDown.	
	socket closeAndDestroy.

]

{ #category : #Running }
NeMulticastSocketTest >> testInterface [
	"mp 4/10/2006 15:55"
	
	self assert: socket networkInterface equals: #(0 0).
	socket networkInterfaceIp: '0.0.0.0'.
	self assert: socket networkInterface equals: #(0 0)
]

{ #category : #testing }
NeMulticastSocketTest >> testLoopbackMode [
	| sentData |
	self assert: socket isLoopbackModeEnabled.
	sentData := 'hello'.
	socket send: sentData.
	self assert: (socket receiveTimeout: 1) asString equals: sentData.
	
	socket isLoopbackModeEnabled: false.
	self assert: socket isLoopbackModeEnabled.
	socket send: sentData.
	self should: [socket receiveTimeout: 1] raise: ConnectionTimedOut
]

{ #category : #testing }
NeMulticastSocketTest >> testSendReceive [
	| sender receiver |
	receiver := socket.
		receiver unregisterUsedPort. "Hack to allow having two multicast sockets on the same port!"
		sender := NeMulticastSocketRefactored 
				group: '226.0.0.12'
				port: multicastPort.
	[ sender send: 'Hello'.
		self assert: (receiver receiveTimeout: 1) asString equals: 'Hello'
	] ensure: [
		sender closeAndDestroy]
]

{ #category : #testing }
NeMulticastSocketTest >> testTimeToLive [
	"mp 4/10/2006 15:55"
	
	| setTTLResult expectedResult getTTLResult |
	self assert: socket timeToLive equals: #(0 1).
	(2 to: 255) do: [:timeToLive|
		expectedResult := {0. timeToLive}.
		setTTLResult := socket timeToLive: timeToLive.
		getTTLResult := socket timeToLive.
		self assert: setTTLResult equals: expectedResult.
		self assert: getTTLResult equals: expectedResult]
]
