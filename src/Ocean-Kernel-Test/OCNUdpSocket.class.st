Class {
	#name : #OCNUdpSocket,
	#superclass : #OCNSocket,
	#category : #'Ocean-Kernel'
}

{ #category : #'initialize-release' }
OCNUdpSocket >> newSocketId [
	^ self networkLibrary createUdpSocketDescriptorId 
]

{ #category : #communicating }
OCNUdpSocket >> receive [
	^self networkLibrary receiveUDPDatagramOn: self socketId
]

{ #category : #communicating }
OCNUdpSocket >> send: aDatagramPacket [
	aDatagramPacket verify ifTrue:[
		self networkLibrary sendUDPOn: self socketId datagram: aDatagramPacket
	] ifFalse:[
		OCNBadDatagramException signal: 'The datagram is not well structured'
	]
]
