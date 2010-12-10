Class {
	#name : #OCNTcpSocket,
	#superclass : #OCNSocket,
	#category : #'Ocean-Kernel'
}

{ #category : #'state names' }
OCNTcpSocket >> boundStateSymbol [
	^#bound

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

{ #category : #'state testing' }
OCNTcpSocket >> isBound [
	^self state = self boundStateSymbol
]

{ #category : #'state testing' }
OCNTcpSocket >> isConnected [ 
	^self state = self connectedStateSymbol
]

{ #category : #'initialize-release' }
OCNTcpSocket >> newSocketId [
	^ self networkLibrary createTcpSocketDescriptorId 
]

{ #category : #communication }
OCNTcpSocket >> receive [
	self isConnected ifFalse: [OCNSocketOperationForbiddenError signal: 'Socket should be connected before receiving'].
	^self networkLibrary readFrom: self socketId	
]

{ #category : #communication }
OCNTcpSocket >> send: data [
	| sentDataSize |
	self isConnected
		ifFalse: [ OCNSocketOperationForbiddenError signal: 'Socket should be connected before sending'  ].
	^self networkLibrary sendData: data to: self socketId
	
]
