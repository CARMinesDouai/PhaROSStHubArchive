Class {
	#name : #OCNTcpSocketSendingDataTest,
	#superclass : #OCNTcpSocketTest,
	#traits : 'TOCNSocketSendingDataTest - {#socket. #randomAsciiStringOfSize:. #testDisconnectionWhileSending}',
	#classTraits : 'TOCNSocketSendingDataTest classTrait',
	#category : #'Ocean-Kernel-Test'
}

{ #category : #'tests sending' }
OCNTcpSocketSendingDataTest >> assertSendingDataOfSize: dataSize [
	| dataToSend receivedData | 
	self startServer.
	self connect.
	dataToSend := self randomAsciiStringOfSize: dataSize.
	self assert: (self socket send: dataToSend) = dataSize.
	(Delay forMilliseconds: 50) wait.
	receivedData := self server receivedData.
	self assert: receivedData size = dataSize.
	self assert: receivedData = dataToSend.

]

{ #category : #accessing }
OCNTcpSocketSendingDataTest >> serverClass [
	^OCNTcpReceivingServerForTest 
]

{ #category : #'tests sending' }
OCNTcpSocketSendingDataTest >> testDisconnectionWhileSending [

	self signalFailure:'should be implemented'.
]

{ #category : #'testing lifecylce' }
OCNTcpSocketSendingDataTest >> testSendOnBoundSocket [
	self testBindUnconnectedSocket.
	self assertSocketState: #isBound.
	self should: [ self socket send: 'hello' ] raise: OCNSocketOperationForbiddenError.
	self assertSocketState: #isBound.
	self signalFailure: 'should send testSendingLessDataThanSocketsDataBufferSize, but a MYSTERIOUS error happens. It looks like the OS does not release the port used by bind'
]

{ #category : #'testing lifecylce' }
OCNTcpSocketSendingDataTest >> testSendOnUnconnectedSocket [
	self assertSocketState: #isUnconnected.
	self should: [self socket send: 'hello' ] raise: OCNSocketOperationForbiddenError.
	self assertSocketState: #isUnconnected.
	self testSendingLessDataThanSocketsDataBufferSize
]
