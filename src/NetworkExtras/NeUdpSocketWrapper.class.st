Class {
	#name : #NeUdpSocketWrapper,
	#superclass : #Object,
	#instVars : [
		'socket'
	],
	#category : #'NetworkExtras-UDP-SendReceiveLargeData'
}

{ #category : #'instance creation' }
NeUdpSocketWrapper class >> multicastSocketClass [
	self subclassResponsibility
]

{ #category : #'instance creation' }
NeUdpSocketWrapper class >> onMulticastSocketGroup: groupIp port: port [
	| socket |
	socket := self multicastSocketClass group: groupIp port: port.
	^ self onSocket: socket
]

{ #category : #'instance creation' }
NeUdpSocketWrapper class >> onSocket: udpSocket [
	^self new
		socket: udpSocket;
		yourself
]

{ #category : #'initialize-release' }
NeUdpSocketWrapper >> destroy [
	socket closeAndDestroy
]

{ #category : #accessing }
NeUdpSocketWrapper >> socket [
	^ socket
]

{ #category : #accessing }
NeUdpSocketWrapper >> socket: anObject [
	socket := anObject
]
