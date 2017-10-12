"
I am an UDP socket. 
I am an abstract class, use my subclasses
"
Class {
	#name : #NeUdpSocket,
	#superclass : #Socket,
	#instVars : [
		'receptionBuffer',
		'receptionPort'
	],
	#category : #'NetworkExtras-UDP-Kernel'
}

{ #category : #'instance creation' }
NeUdpSocket class >> new [
	^self udpCreateIfFail: [
		UIManager default 
			abort: 'Either network is not available, or no resources left to create another socket'
			title: self name, ' creation failed!' ]
]

{ #category : #'instance creation' }
NeUdpSocket class >> receptionPort: portNumber [
	^self newUDP
		receptionPort: portNumber;
		yourself
]

{ #category : #'initialize-release' }
NeUdpSocket >> defaultBufferSize [
	^ 1500
]

{ #category : #receiving }
NeUdpSocket >> defaultTimeoutSeconds [
	^ 30
]

{ #category : #'reception ports tracking' }
NeUdpSocket >> destroy [
	[ super destroy ] ensure: [ self unregisterUsedPort]
]

{ #category : #'initialize-release' }
NeUdpSocket >> initReceptionBuffer [
	self receptionBufferSize: self defaultBufferSize
]

{ #category : #'reception ports tracking' }
NeUdpSocket >> isUsedPort: portNumber [
	^self usedPortsTracker isUsedPort: portNumber
]

{ #category : #receiving }
NeUdpSocket >> receive [
	^ self receiveTimeout: self defaultTimeoutSeconds
]

{ #category : #receiving }
NeUdpSocket >> receiveTimeout: seconds [
	| bytesReadCount |
	[self waitForConnectionFor: seconds.
	self waitForDataFor: seconds.
	bytesReadCount := self receiveDataInto: self receptionBuffer.
	^ self receptionBuffer copyFrom: 1 to: bytesReadCount] on: PrimitiveFailed do: [ ^#() ]
]

{ #category : #receiving }
NeUdpSocket >> receptionBuffer [
	receptionBuffer ifNil: [ self initReceptionBuffer ].
	^receptionBuffer
]

{ #category : #'initialize-release' }
NeUdpSocket >> receptionBufferSize: bytesCount [
	receptionBuffer := ByteArray new: bytesCount.

]

{ #category : #receiving }
NeUdpSocket >> receptionPort [
	^receptionPort
]

{ #category : #receiving }
NeUdpSocket >> receptionPort: portNumber [
	self setPort: portNumber.
]

{ #category : #'reception ports tracking' }
NeUdpSocket >> registerUsedPort: portNumber [
	self usedPortsTracker registerUsedPort: portNumber
]

{ #category : #sending }
NeUdpSocket >> send: anObject [
	self sendData: anObject asByteArray toHost: self targetIp port: self targetPort
]

{ #category : #'reception ports tracking' }
NeUdpSocket >> setPort: portNumber [
	(self isUsedPort: portNumber) ifTrue: [ NeAlreadyUsedSocketPort signal ].
	receptionPort := portNumber.
	self registerUsedPort: portNumber.
	super setPort: portNumber.
]

{ #category : #sending }
NeUdpSocket >> targetIp [
	self subclassResponsibility
]

{ #category : #sending }
NeUdpSocket >> targetPort [
	self subclassResponsibility
]

{ #category : #'reception ports tracking' }
NeUdpSocket >> unregisterUsedPort [
	self usedPortsTracker unregisterUsedPort: self receptionPort
]

{ #category : #'reception ports tracking' }
NeUdpSocket >> usedPortsTracker [
	^NeUdpUsedPortsTracker
]
