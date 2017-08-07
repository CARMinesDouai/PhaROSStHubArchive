"
An MulticastSocketTest is a TestCase for MulticastSocket.

Instance Variables
	socket		<MulticastSocket>
	multicastPort:		<Integer>
"
Class {
	#name : #NeMulticastSocketTest,
	#superclass : #TestCase,
	#instVars : [
		'socket',
		'multicastPort'
	],
	#category : #'NetworkExtras-UDP-Kernel'
}

{ #category : #'initialize-release' }
NeMulticastSocketTest >> setUp [
	super setUp.
	multicastPort := 1234.
	socket := MulticastSocket 
				group: '226.0.0.12'
				port: multicastPort
]

{ #category : #'initialize-release' }
NeMulticastSocketTest >> tearDown [
	super tearDown.	
	socket closeAndDestroy.

]

{ #category : #Running }
NeMulticastSocketTest >> testInterface [
	"mp 4/10/2006 15:55"
	
	self assert: socket getInterface equals: #(0 0).
	socket setInterfaceTo: '0.0.0.0'.
	self assert: socket getInterface equals: #(0 0)
]

{ #category : #Running }
NeMulticastSocketTest >> testLoopbackMode [
	| sentData |
	self assert: socket getLoopbackMode equals: #(0 1).
	sentData := 'hello'.
	socket send: sentData.
	self assert: (socket receiveTimeout: 1) asString equals: sentData.
	
	socket setLoopbackModeTo: false.
	self assert: socket getLoopbackMode equals: #(0 0).
	socket send: sentData.
	self should: [socket receiveTimeout: 1] raise: ConnectionTimedOut
]

{ #category : #Running }
NeMulticastSocketTest >> testSendReceive [
	| sender receiver |
	[	receiver := socket.
		sender := MulticastSocket 
				group: '226.0.0.12'
				port: multicastPort.
		sender send: 'Hello'.
		self assert: (receiver receiveTimeout: 1) asString equals: 'Hello'
	] ensure: [
		sender closeAndDestroy]
]

{ #category : #Running }
NeMulticastSocketTest >> testTimeToLive [
	"mp 4/10/2006 15:55"
	
	| setTTLResult expectedResult getTTLResult |
	self assert: socket getTimeToLive equals: #(0 1).
	(2 to: 255) do: [:timeToLive|
		expectedResult := {0. timeToLive}.
		setTTLResult := socket setTimeToLiveTo: timeToLive.
		getTTLResult := socket getTimeToLive.
		self assert: setTTLResult equals: expectedResult.
		self assert: getTTLResult equals: expectedResult]
]
