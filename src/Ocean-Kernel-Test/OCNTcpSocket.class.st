Class {
	#name : #OCNTcpSocket,
	#superclass : #OCNSocket,
	#instVars : [
		'socketId',
		'isConnected',
		'isClosed'
	],
	#category : #'Ocean-Kernel'
}

{ #category : #connection }
OCNTcpSocket >> close [
	self isClosed not & self isConnected
		ifTrue: [ self isClosed: (self  networkLibrary close: self socketId) = 0 ]
]

{ #category : #connection }
OCNTcpSocket >> connectToServer: serverAddress [
	| result |
	result := self networkLibrary connect: self socketId toServerWithIpv4Address: serverAddress.
	self isConnected: (result = 0).

]

{ #category : #'lowlevel initialization' }
OCNTcpSocket >> createDescriptorWithDomain: communicationDomain type: socketType protocol: socketProtocol [
	| result |
	result := self networkLibrary
		socketDomain: communicationDomain
		type: socketType
		protocol: socketProtocol.
	self socketId: (result signedLongAt: 1)
]

{ #category : #'initialize-release' }
OCNTcpSocket >> initialize [ 
	super initialize.
	self isConnected: false.
	self isClosed: false.

]

{ #category : #connection }
OCNTcpSocket >> isClosed [
	^isClosed
]

{ #category : #testing }
OCNTcpSocket >> isClosed: anObject [
	isClosed := anObject
]

{ #category : #testing }
OCNTcpSocket >> isConnected [ 
	^isConnected
]

{ #category : #testing }
OCNTcpSocket >> isConnected: aBoolean [ 
	(aBoolean & self isClosed) ifTrue: [ 
		self isClosed: false
	].
	isConnected := aBoolean 
]

{ #category : #testing }
OCNTcpSocket >> isDescriptorCreated [
	self socketId ifNil: [^false].
	^self socketId ~= -1
]

{ #category : #communication }
OCNTcpSocket >> receive [
	self isConnected ifFalse: [Error signal: 'Socket not connected'].
	^self networkLibrary readFrom: self socketId	
]

{ #category : #communication }
OCNTcpSocket >> send: data [
	| sentDataSize |
	self isConnected
		ifFalse: [ Error signal: 'Socket not connected' ].
	^self networkLibrary sendData: data to: self socketId
	
]

{ #category : #accessing }
OCNTcpSocket >> socketId [
	^ socketId
]

{ #category : #accessing }
OCNTcpSocket >> socketId: anObject [
	socketId := anObject
]
