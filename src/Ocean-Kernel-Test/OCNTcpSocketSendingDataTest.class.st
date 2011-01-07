Class {
	#name : #OCNTcpSocketSendingDataTest,
	#superclass : #OCNTcpSocketTest,
	#category : #'Ocean-Kernel-Test'
}

{ #category : #testing }
OCNTcpSocketSendingDataTest >> assertSendingDataOfSize: dataSize [
	| dataToSend receivedData | 
	self startServer.
	self connect.
	dataToSend := self randomAsciiStringOfSize: dataSize.
	self assert: (socket send: dataToSend) = dataSize.
	(Delay forMilliseconds: 50) wait.
	receivedData := serverShell stdOut contents.
	self assert: receivedData size = dataSize.
	self assert: receivedData = dataToSend.

]

{ #category : #testing }
OCNTcpSocketSendingDataTest >> testDisconnectionWhileSending [
	self signalFailure: 'Needs non-blocking (multi-threading)'
]

{ #category : #'testing lifecylce' }
OCNTcpSocketSendingDataTest >> testSendOnBoundSocket [
	self testBindUnconnectedSocket.
	self assertSocketState: #isBound.
	self should: [ socket send: 'hello' ] raise: OCNSocketOperationForbiddenError.
	self assertSocketState: #isBound.
	self signalFailure: 'should send testSendingLessDataThanSocketsDataBufferSize, but a MYSTERIOUS error happens. It looks like the OS does not release the port used by bind'
]

{ #category : #'testing lifecylce' }
OCNTcpSocketSendingDataTest >> testSendOnUnconnectedSocket [
	self assertSocketState: #isUnconnected.
	self should: [ socket send: 'hello' ] raise: OCNSocketOperationForbiddenError.
	self assertSocketState: #isUnconnected.
	self testSendingLessDataThanSocketsDataBufferSize
]

{ #category : #testing }
OCNTcpSocketSendingDataTest >> testSendingLargeAmountOfDataComparedToSizeOfSocketsDataBuffer [
	self assertSendingDataOfSize: 1000 * library defaultDataBufferSize.

]

{ #category : #testing }
OCNTcpSocketSendingDataTest >> testSendingLessDataThanSocketsDataBufferSize [
	self assertSendingDataOfSize: library defaultDataBufferSize//2 .

]

{ #category : #testing }
OCNTcpSocketSendingDataTest >> testSendingMoreDataThanSizeOfSocketsDataBuffer [
	self assertSendingDataOfSize: 2 * library defaultDataBufferSize.

]
