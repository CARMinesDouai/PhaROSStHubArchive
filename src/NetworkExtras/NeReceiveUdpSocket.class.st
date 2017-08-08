"
I am an UDP socket dedicated to reception. I provide a buffer for storing incoming data. 

I am useful for oneshot receptions. For repeated reception, use the higher lever class NeUdpServer.

The reception buffer is small by default (see defaultBufferSize method), but it can be increased.
Its content is overwritten upon each reception.

Instance Variables
	receptionBuffer		<ByteArray> reception buffer

"
Class {
	#name : #NeReceiveUdpSocket,
	#superclass : #NeUdpSocket,
	#instVars : [
		'receptionBuffer',
		'port'
	],
	#classInstVars : [
		'usedPorts'
	],
	#category : #'NetworkExtras-UDP-Kernel'
}

{ #category : #'used ports tracking' }
NeReceiveUdpSocket class >> isUsedPort: portNumber [
	^self usedPorts includes: portNumber
]

{ #category : #'instance creation' }
NeReceiveUdpSocket class >> port: portNumber [
	^self newUDP
		listenOn: portNumber;
		yourself
]

{ #category : #'used ports tracking' }
NeReceiveUdpSocket class >> registerUsedPort: portNumber [
	self usedPorts add: portNumber
]

{ #category : #'used ports tracking' }
NeReceiveUdpSocket class >> resetUsedPorts [
	^usedPorts := Set new
]

{ #category : #'used ports tracking' }
NeReceiveUdpSocket class >> unregisterUsedPort: portNumber [
	self usedPorts remove: portNumber ifAbsent: [  ]
]

{ #category : #'used ports tracking' }
NeReceiveUdpSocket class >> usedPorts [
	usedPorts ifNil: [ self resetUsedPorts ].
	^usedPorts
]

{ #category : #'initialize-release' }
NeReceiveUdpSocket >> defaultBufferSize [
	^ 1500
]

{ #category : #communicating }
NeReceiveUdpSocket >> defaultTimeoutSeconds [
	^ 3600
]

{ #category : #'used ports tracking' }
NeReceiveUdpSocket >> destroy [
	[ super destroy ] ensure: [ self unregisterUsedPort: port ]
]

{ #category : #'initialize-release' }
NeReceiveUdpSocket >> initialize [
	super initialize.
	self receptionBufferSize: self defaultBufferSize
]

{ #category : #'used ports tracking' }
NeReceiveUdpSocket >> isUsedPort: portNumber [
	^self class isUsedPort: portNumber
]

{ #category : #communicating }
NeReceiveUdpSocket >> listenOn: portNumber [
	self setPort: portNumber.
]

{ #category : #communicating }
NeReceiveUdpSocket >> receive [
	^ self receiveTimeout: self defaultTimeoutSeconds
]

{ #category : #communicating }
NeReceiveUdpSocket >> receiveTimeout: seconds [
	| bytesReadCount |
	[self waitForConnectionFor: seconds.
	self waitForDataFor: seconds.
	bytesReadCount := self receiveDataInto: receptionBuffer.
	^ receptionBuffer copyFrom: 1 to: bytesReadCount] on: PrimitiveFailed do: [ ^#() ]
]

{ #category : #'initialize-release' }
NeReceiveUdpSocket >> receptionBufferSize: bytesCount [
	receptionBuffer := ByteArray new: bytesCount.

]

{ #category : #'used ports tracking' }
NeReceiveUdpSocket >> registerUsedPort: portNumber [
	self class registerUsedPort: portNumber
]

{ #category : #communicating }
NeReceiveUdpSocket >> setPort: portNumber [
	(self isUsedPort: portNumber) ifTrue: [ NeAlreadyUsedSocketPort signal ].
	port := portNumber.
	self registerUsedPort: portNumber.
	super setPort: portNumber.
]

{ #category : #'used ports tracking' }
NeReceiveUdpSocket >> unregisterUsedPort: portNumber [
	self class unregisterUsedPort: portNumber
]
