Class {
	#name : #NeUdpSocketWrapper,
	#superclass : #Object,
	#instVars : [
		'socket',
		'port'
	],
	#category : #'NetworkExtras-UDP-SendReceiveLargeData'
}

{ #category : #'instance creation' }
NeUdpSocketWrapper class >> onSocket: udpSocket [
	^self new
		socket: udpSocket;
		yourself
]

{ #category : #'instance creation' }
NeUdpSocketWrapper class >> onUnicastSocket [
	^self onSocket: Socket newUDP
]

{ #category : #'initialize-release' }
NeUdpSocketWrapper >> defaultMaxChunkSize [
	^1500
]

{ #category : #'initialize-release' }
NeUdpSocketWrapper >> destroy [
	socket closeAndDestroy
]

{ #category : #'initialize-release' }
NeUdpSocketWrapper >> finalize [
	self destroy.
]

{ #category : #'initialize-release' }
NeUdpSocketWrapper >> initialize [
	super initialize.
	self maxChunkSize: self defaultMaxChunkSize.
	self finalizationRegistry add: self.
]

{ #category : #'initialize-release' }
NeUdpSocketWrapper >> maxChunkSize: anInteger [
	self subclassResponsibility
]

{ #category : #accessing }
NeUdpSocketWrapper >> socket [
	^ socket
]

{ #category : #accessing }
NeUdpSocketWrapper >> socket: anObject [
	socket := anObject
]
