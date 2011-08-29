Class {
	#name : #OCNTcpSocket,
	#superclass : #OCNSocket,
	#category : #'Ocean-Kernel'
}

{ #category : #private }
OCNTcpSocket >> basicDestroy [
	super basicDestroy.
	self networkLibrary tcpDestroy: self.
	self socketId: nil.
]

{ #category : #'initialize-release' }
OCNTcpSocket >> newSocketId [
	^ self networkLibrary createTcpSocketDescriptorIdFor: self
]
