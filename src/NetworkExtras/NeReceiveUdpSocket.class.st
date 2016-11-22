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
	"mp 2/13/2006 11:05"
	"Suspends for an infinite period until receiving some data"
	
	| bytesRead |
	bytesRead := self receiveDataInto: receptionBuffer.
	^ receptionBuffer copyFrom: 1 to: bytesRead
]

{ #category : #communicating }
NeReceiveUdpSocket >> receiveTimeout: seconds [
	self waitForDataFor: seconds.
	^self receive
]

{ #category : #'initialize-release' }
NeReceiveUdpSocket >> receptionBufferSize: bytesCount [
	receptionBuffer := ByteArray new: bytesCount.

]
