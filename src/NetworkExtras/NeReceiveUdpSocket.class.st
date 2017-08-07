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
		'receptionBuffer'
	],
	#category : #'NetworkExtras-UDP-Kernel'
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
