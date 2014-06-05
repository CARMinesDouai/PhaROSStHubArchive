Class {
	#name : #OCNTcpSocket,
	#superclass : #OCNSocket,
	#instVars : [
		'connectionTimeoutSeconds'
	],
	#category : #'Ocean-Kernel'
}

{ #category : #private }
OCNTcpSocket >> basicDestroy [
	super basicDestroy.
	self networkLibrary tcpDestroy: self.
	self socketId: nil.
]

{ #category : #accessing }
OCNTcpSocket >> connectionTimeoutSeconds [
	^connectionTimeoutSeconds
]

{ #category : #accessing }
OCNTcpSocket >> connectionTimeoutSeconds: anObject [
	connectionTimeoutSeconds := anObject
]

{ #category : #'initialize-release' }
OCNTcpSocket >> initialize [ 
	super initialize.
	self connectionTimeoutSeconds: 3.

]

{ #category : #'backward compatibility' }
OCNTcpSocket >> localPort [
	^ self networkLibrary localPortOf: self 
]

{ #category : #'initialize-release' }
OCNTcpSocket >> newSocketId [
	^ self networkLibrary createTcpSocketDescriptorIdFor: self
]
