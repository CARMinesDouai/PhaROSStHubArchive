Class {
	#name : #NeReceiveUdpSocket,
	#superclass : #NeUdpSocket,
	#instVars : [
		'receptionBuffer'
	],
	#category : #'NetworkExtras-UDP-Unicast'
}

{ #category : #'instance creation' }
NeReceiveUdpSocket class >> port: portNumber [
	^self newUDP
		listenOn: portNumber;
		yourself
]

{ #category : #'initialize-release' }
NeReceiveUdpSocket >> defaultBufferSize [
	^ 1500
]

{ #category : #communicating }
NeReceiveUdpSocket >> defaultTimeoutSeconds [
	^ 3600
]

{ #category : #'initialize-release' }
NeReceiveUdpSocket >> initialize [
	super initialize.
	self receptionBufferSize: self defaultBufferSize
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
