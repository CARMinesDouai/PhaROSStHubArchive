Class {
	#name : #NeMulticastSocketTest,
	#superclass : #TestCase,
	#instVars : [
		'socket',
		'multicastPort',
		'allSockets'
	],
	#category : #'NetworkExtras-UDP-Kernel'
}

{ #category : #testing }
NeMulticastSocketTest >> newSocketGroup: groupIp port: port [
	| newSocket |
	newSocket := NeMulticastSocket
				group: groupIp
				port: port.
	allSockets add: newSocket.
	^newSocket
]

{ #category : #testing }
NeMulticastSocketTest >> setUp [
	super setUp.
	multicastPort := NeUdpUsedPortsTracker freePortAtRandom.
	allSockets := Set new.
	socket := self newSocketGroup: '226.0.0.12'
				port: multicastPort
]

{ #category : #testing }
NeMulticastSocketTest >> tearDown [
	super tearDown.	
	allSockets do: #closeAndDestroy.

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
	self assert: (socket receiveTimeout: 0.1) asString equals: sentData.
	
	socket isLoopbackModeEnabled: false.
	self deny: socket isLoopbackModeEnabled.
	socket send: sentData.
	self should: [socket receiveTimeout: 0.1] raise: ConnectionTimedOut
]

{ #category : #testing }
NeMulticastSocketTest >> testSendReceive [
	| sender receiver |
	receiver := socket.
	receiver unregisterUsedPort. "Hack to allow having two multicast sockets on the same port!"
	sender := self newSocketGroup: '226.0.0.12'
				port: multicastPort.
	sender send: 'Hello'.
	self assert: (receiver receiveTimeout: 0.1) asString equals: 'Hello'

]

{ #category : #testing }
NeMulticastSocketTest >> testSendReceiveOnDifferentGroups [
	| sender1 receiver1 sender2 receiver2 multicastPort2 |
	receiver1 := socket.
	receiver1 unregisterUsedPort. "Hack to allow having two multicast sockets on the same port!"
	sender1 := NeMulticastSocket 
				group: '226.0.0.12'
				port: multicastPort.
	multicastPort2 := NeUdpUsedPortsTracker freePortAtRandom.
	receiver2 := NeMulticastSocket 
				group: '226.0.0.42'
				port: multicastPort2.
	receiver2 unregisterUsedPort. "Hack to allow having two multicast sockets on the same port!"
	sender2 := NeMulticastSocket 
				group: '226.0.0.42'
				port: multicastPort2.
	sender1 send: 'Hello'.
	self assert: (receiver1 receiveTimeout: 0.1) asString equals: 'Hello'.
	self should: [ receiver2 receiveTimeout: 0.1 ] raise: ConnectionTimedOut.
	sender2 send: 'Goodbye'.
	self assert: (receiver2 receiveTimeout: 0.1) asString equals: 'Goodbye'.
	self should: [ receiver1 receiveTimeout: 0.1 ] raise: ConnectionTimedOut.

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
