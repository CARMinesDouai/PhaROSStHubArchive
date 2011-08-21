Class {
	#name : #OCNTcpSocketSendingDataTest,
	#superclass : #OCNTcpSocketTest,
	#instVars : [
		'sendingProcess'
	],
	#category : #'Ocean-KernelTests'
}

{ #category : #'tests sending' }
OCNTcpSocketSendingDataTest >> assertSendingDataOfSize: dataSize [
	| millisecondsForTimeout dataToSend receivedData sentDataSize sentSemaphore |
	
	millisecondsForTimeout := (((dataSize // 4) min: 60000)) max: 500.
	self startServer.
	self connect. 
	dataToSend := self randomAsciiStringOfSize: dataSize.
	sentSemaphore := Semaphore new.
	sendingProcess := [[sentDataSize := self socket send: dataToSend] ensure: [ sentSemaphore signal] ] forkAt: Processor userSchedulingPriority.
	self deny: (sentSemaphore waitTimeoutMSecs:  millisecondsForTimeout).
	server interact: false. 
	server receivedSemaphore wait.
	self assert: sentDataSize = dataSize.
	receivedData := self server receivedData.
	self assert: receivedData size = dataSize.
	self assert: receivedData = dataToSend.

]

{ #category : #accessing }
OCNTcpSocketSendingDataTest >> serverClass [
	^OCNTcpReceivingServerForTest
]

{ #category : #'setup-teardown' }
OCNTcpSocketSendingDataTest >> tearDown [ 
	super tearDown.
	sendingProcess ifNotNil: [ sendingProcess terminate ] 
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
