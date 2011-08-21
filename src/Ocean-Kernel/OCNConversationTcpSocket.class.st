"
an OCNTcpSocket has the following lifecycle :
 
state 1 : clean
state 2 : bound
state 3 : connected
state 4 : destroyed
1 -> 2, 3, 4
2 -> 3, 4
3 -> 4



""simple example to finish""


ip := OCNIPV4SocketAddress family: OCNIPV4SocketAddress afInetFamily;
		ip: (OCNNetNameResolver ipv4AddressForName: 'www.google.fr'); 
		port: aPortNumber ;
		yourself
OCNConversationTcpSocket new connectToServer: 


(OCNNetNameResolver ipv4AddressForName: 'www.google.fr') '209.85.143.104'  
"
Class {
	#name : #OCNConversationTcpSocket,
	#superclass : #OCNTcpSocket,
	#category : #'Ocean-Kernel'
}

{ #category : #connection }
OCNConversationTcpSocket >> connectToServer: serverAddress [
	(self isClean | self isBound ) ifFalse:  [ 
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

{ #category : #accessing }
OCNConversationTcpSocket >> connectionTimeOutSeconds [
	^3
]

{ #category : #'state testing' }
OCNConversationTcpSocket >> isBound [
	^self state = self boundStateSymbol
]

{ #category : #'state testing' }
OCNConversationTcpSocket >> isConnected [ 
	^self state = self connectedStateSymbol
]

{ #category : #communicating }
OCNConversationTcpSocket >> isDataAvailable [
	^self isConnected and: [self networkLibrary isDataAvailableFrom: self]
]

{ #category : #'initialize-release' }
OCNConversationTcpSocket >> newSocketId [
	^ self networkLibrary createTcpSocketDescriptorIdFor: self
]

{ #category : #communicating }
OCNConversationTcpSocket >> receive [
	self isConnected ifFalse: [OCNSocketOperationForbiddenError signal: 'Socket should be connected before receiving'].
	^self networkLibrary tcpReceiveFrom: self	
]

{ #category : #communicating }
OCNConversationTcpSocket >> send: aByteStringOrByteArray [
	| totalToSendCount totalSentCount  indexOfFirstByteToSend pendingBytesCount toSendCount sentCount indexOfLastByteToSend dataToSend|
	self isConnected
		ifFalse: [ OCNSocketOperationForbiddenError signal: 'Socket should be connected before sending' ].
	totalToSendCount := aByteStringOrByteArray size.
	totalSentCount := 0.
	[totalSentCount < totalToSendCount] whileTrue: [
		indexOfFirstByteToSend := totalSentCount + 1.
		pendingBytesCount := totalToSendCount - totalSentCount.
		toSendCount := self sendDataBufferSize min: pendingBytesCount.
		indexOfLastByteToSend := indexOfFirstByteToSend + toSendCount - 1. 
		dataToSend := aByteStringOrByteArray copyFrom: indexOfFirstByteToSend  to:  indexOfLastByteToSend.
		sentCount := self networkLibrary tcpSendData: dataToSend to: self.
		totalSentCount := sentCount + totalSentCount.
	].
	^totalSentCount  
]
