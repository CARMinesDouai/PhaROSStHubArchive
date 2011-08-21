Class {
	#name : #OCNTcpSocketFailureTest,
	#superclass : #OCNTcpSocketTest,
	#category : #'Ocean-KernelTests'
}

{ #category : #accessing }
OCNTcpSocketFailureTest >> serverClass [
	^OCNPublicSocketTcpServerForTest 
]

{ #category : #testing }
OCNTcpSocketFailureTest >> testDisconnectionWhileReceiving [
	| dataSize dataToSend receptionStream waitForDataDelay serverSocket |
	dataSize := 10 * socket receiveDataBufferSize. 
	dataToSend := self randomAsciiStringOfSize: dataSize.
	self startServer.
	self connect.
	serverSocket := server conversationSocket.
	serverSocket sendData: dataToSend.
	[self socket isDataAvailable] whileFalse: [waitForDataDelay wait].
	serverSocket closeAndDestroy.
	[self socket isDataAvailable] whileTrue: [self socket receive].
	self should: [self socket receive] raise: OCNSocketOperationForbiddenError.
	self assert: self socket isDestroyed 
]

{ #category : #'tests sending' }
OCNTcpSocketFailureTest >> testDisconnectionWhileSending [
	| dataSize dataToSend receptionStream waitForDataDelay serverSocket |
	dataSize := 5 * socket receiveDataBufferSize. 
	dataToSend := self randomAsciiStringOfSize: dataSize.
	self startServer.
	self connect.
	serverSocket := server conversationSocket.
	self socket send: dataToSend.
	waitForDataDelay := Delay forMilliseconds: 10.
	[serverSocket dataAvailable] whileFalse: [waitForDataDelay wait].
	serverSocket closeAndDestroy.
	self should: [self socket send: dataToSend] raise: OCNTimeOutError.
	self assert: self socket isDestroyed 
]

{ #category : #testing }
OCNTcpSocketFailureTest >> testSocketCreationFailure [
	self signalFailure: 'test that an exception is raised when socket creation fails'
]

{ #category : #testing }
OCNTcpSocketFailureTest >> testSocketRestoredAtImageStartup [
	self signalFailure: 'socket restored in the same state when image startup'
]
