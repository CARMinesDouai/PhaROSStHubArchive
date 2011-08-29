Class {
	#name : #OCNUdpSocket,
	#superclass : #OCNSocket,
	#category : #'Ocean-Kernel'
}

{ #category : #private }
OCNUdpSocket >> basicDestroy [
	super basicDestroy.
	self networkLibrary udpDestroy: self
]

{ #category : #private }
OCNUdpSocket >> newSocketId [
	^ self networkLibrary createUdpSocketDescriptorIdFor: self 
]

{ #category : #communicating }
OCNUdpSocket >> receive [
	^self networkLibrary receiveUDPDatagramOn: self 
]

{ #category : #communicating }
OCNUdpSocket >> send: aDatagramPacket [
	aDatagramPacket verify ifTrue:[
		^self networkLibrary sendUDPOn: self datagram: aDatagramPacket
	] ifFalse:[
		OCNInvalidDatagramPacketError signal: 'The datagram is not well structured'
	]
]
