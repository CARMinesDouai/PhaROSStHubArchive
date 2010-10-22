Class {
	#name : #OCNTcpSocket,
	#superclass : #OCNSocket,
	#category : #'Ocean-Kernel'
}

{ #category : #connection }
OCNTcpSocket >> close [
	self isClosed
		ifTrue: [ ^ self ].
	(self networkLibrary close: self socketId) = 0
		ifTrue: [ self state: self closedStateSymbol ]
]

{ #category : #'state names' }
OCNTcpSocket >> closedStateSymbol [
	^ #closed
]

{ #category : #connection }
OCNTcpSocket >> connectToServer: serverAddress [
	| result |
	result := self networkLibrary connect: self socketId toServerWithIpv4Address: serverAddress.
	(result = 0) ifTrue: [ self state:  self connectedStateSymbol]

]

{ #category : #'state names' }
OCNTcpSocket >> connectedStateSymbol [
	^#connected

]

{ #category : #'initialize-release' }
OCNTcpSocket >> initialize [ 
	super initialize.
	self state: self closedStateSymbol
]

{ #category : #connection }
OCNTcpSocket >> isClosed [
	^self state = self closedStateSymbol
]

{ #category : #testing }
OCNTcpSocket >> isConnected [ 
	^self state = self connectedStateSymbol 
]

{ #category : #'initialize-release' }
OCNTcpSocket >> newSocketId [
	^ self networkLibrary createTcpSocketDescriptorId 
]

{ #category : #communication }
OCNTcpSocket >> receive [
	self isConnected ifFalse: [OCNSocketConnectedException signal].
	^self networkLibrary readFrom: self socketId	
]

{ #category : #communication }
OCNTcpSocket >> send: data [
	| sentDataSize |
	self isConnected
		ifFalse: [ OCNSocketConnectedException signal  ].
	^self networkLibrary sendData: data to: self socketId
	
]
