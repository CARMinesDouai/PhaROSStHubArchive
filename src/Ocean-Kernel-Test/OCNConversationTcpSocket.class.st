"
an OCNTcpSocket has the following lifecycle :
 
state 1 : closed
state 2 : connected
state 3 : listening
state 4 : destroyed
1 -> 2, 3, 4
2 -> 1
3 -> 1

"
Class {
	#name : #OCNConversationTcpSocket,
	#superclass : #OCNTcpSocket,
	#category : #'Ocean-Kernel'
}

{ #category : #'state names' }
OCNConversationTcpSocket >> boundStateSymbol [
	^#bound

]

{ #category : #connection }
OCNConversationTcpSocket >> connectToServer: serverAddress [
	(self isUnconnected | self isBound ) ifFalse:  [ 
		OCNSocketOperationForbiddenError signal: self state asString capitalized, ' socket can not be connected' ].
	[
		self networkLibrary connect: self toServerWithIpv4Address: serverAddress.
	] on: OCNSocketOperationFailureError do: [:ex|
		self destroy.
		ex pass.
	].
	self state:  self connectedStateSymbol

]

{ #category : #'state names' }
OCNConversationTcpSocket >> connectedStateSymbol [
	^#connected

]

{ #category : #'state testing' }
OCNConversationTcpSocket >> isBound [
	^self state = self boundStateSymbol
]

{ #category : #'state testing' }
OCNConversationTcpSocket >> isConnected [ 
	^self state = self connectedStateSymbol
]

{ #category : #private }
OCNConversationTcpSocket >> newSocketId [
	^ self networkLibrary createTcpSocketDescriptorId 
]

{ #category : #communicating }
OCNConversationTcpSocket >> receive [
	self isConnected ifFalse: [OCNSocketOperationForbiddenError signal: 'Socket should be connected before receiving'].
	^self networkLibrary readFrom: self	
]

{ #category : #communicating }
OCNConversationTcpSocket >> send: data [
	| sentDataSize |
	self isConnected
		ifFalse: [ OCNSocketOperationForbiddenError signal: 'Socket should be connected before sending'  ].
	^self networkLibrary sendData: data to: self
	
]
