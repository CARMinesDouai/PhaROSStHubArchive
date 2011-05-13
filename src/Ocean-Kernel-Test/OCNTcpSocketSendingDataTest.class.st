Class {
	#name : #OCNTcpSocketSendingDataTest,
	#superclass : #OCNTcpSocketTest,
	#category : #'Ocean-Kernel-Test'
}

{ #category : #'tests sending' }
OCNTcpSocketSendingDataTest >> assertSendingDataOfSize: dataSize [
	| dataToSend receivedData sentDataSize sentSemaphore millisecondsForTimeout |
	
	millisecondsForTimeout := (((dataSize // 4) min: 5000)) max: 500.
	self startServer.
	self connect. 
	dataToSend := self randomAsciiStringOfSize: dataSize.
	sentSemaphore := Semaphore new.
	[self shouldnt: [sentDataSize := self socket send: dataToSend] raise: Error. sentSemaphore signal] forkAt: Processor lowIOPriority.
	self deny: (sentSemaphore waitTimeoutMSecs: millisecondsForTimeout). "ensures there was no timeout"
	self assert: sentDataSize = dataSize.
	(Delay forMilliseconds: millisecondsForTimeout) wait. 
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
	self signalFailure: 'Needs non-blocking (multi-threaded FFI call or non-blocking primitives)'
]

{ #category : #'testing lifecylce' }
OCNTcpSocketSendingDataTest >> testSendOnBoundSocket [
	self testBindUnconnectedSocket.
	self assertSocketState: #isBound.
	self should: [ self socket send: 'hello' ] raise: OCNSocketOperationForbiddenError.
	self assertSocketState: #isBound.
	self testSendingLessDataThanSocketsDataBufferSize
]

{ #category : #'testing lifecylce' }
OCNTcpSocketSendingDataTest >> testSendOnUnconnectedSocket [
	self assertSocketState: #isClean.
	self should: [self socket send: 'hello' ] raise: OCNSocketOperationForbiddenError.
	self assertSocketState: #isClean.
	self testSendingLessDataThanSocketsDataBufferSize
]

{ #category : #'tests sending' }
OCNTcpSocketSendingDataTest >> testSendingLargeAmountOfDataComparedToSizeOfSocketsDataBuffer [
	self assertSendingDataOfSize: 1000 * socket sendDataBufferSize.

]

{ #category : #'tests sending' }
OCNTcpSocketSendingDataTest >> testSendingLessDataThanSocketsDataBufferSize [
	self assertSendingDataOfSize: socket sendDataBufferSize//2 .

]

{ #category : #'tests sending' }
OCNTcpSocketSendingDataTest >> testSendingMoreDataThanSizeOfSocketsDataBuffer [
	self assertSendingDataOfSize: 2 * socket sendDataBufferSize.

]
