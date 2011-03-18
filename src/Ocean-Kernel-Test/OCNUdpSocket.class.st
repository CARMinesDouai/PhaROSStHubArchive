Class {
	#name : #OCNUdpSocket,
	#superclass : #OCNSocket,
	#category : #'Ocean-Kernel'
}

{ #category : #private }
OCNUdpSocket >> newSocketId [
	^ self networkLibrary createUdpSocketDescriptorId 
]

{ #category : #communicating }
OCNUdpSocket >> receive [
	^self networkLibrary receiveUDPDatagramOn: self socketId
]

{ #category : #communicating }
OCNUdpSocket >> receive: port [
	^self networkLibrary receiveUDPDatagramOn: self socketId
]

{ #category : #communicating }
OCNUdpSocket >> send: aDatagramPacket [
	aDatagramPacket verify ifTrue:[
		^self networkLibrary sendUDPOn: self socketId datagram: aDatagramPacket
	] ifFalse:[
		OCNInvalidDatagramPacketError signal: 'The datagram is not well structured'
	]
]
