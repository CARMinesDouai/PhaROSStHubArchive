Class {
	#name : #OCNTcpSocketReceivingDataTest,
	#superclass : #OCNTcpSocketTest,
	#category : #'Ocean-Kernel-Test'
}

{ #category : #testing }
OCNTcpSocketReceivingDataTest >> assertReceivingDataOfSize: dataSize [
	| dataToSend receptionStream waitForData dataPacket receivedData |
	dataToSend := self randomAsciiStringOfSize: dataSize.
	self startServer.
	server sendData: dataToSend.
	self connect.
	receptionStream := WriteStream on: (ByteArray new: dataSize).
	waitForData := true.
	[ waitForData ]
		whileTrue: [ 
			dataPacket := self socket receive.
			receptionStream nextPutAll: dataPacket.
			waitForData := dataPacket size > 0].
	receivedData := receptionStream contents asString.
	self assert: receivedData = dataToSend
]

{ #category : #accessing }
OCNTcpSocketReceivingDataTest >> serverClass [
	^OCNTcpSendingServerForTest 
]

{ #category : #testing }
OCNTcpSocketReceivingDataTest >> testDisconnectionWhileReceiving [
	self signalFailure: 'Needs non-blocking (multi-threading)'
]

{ #category : #'testing lifecylce' }
OCNTcpSocketReceivingDataTest >> testReceiveOnBoundSocket [
	self testBindUnconnectedSocket.
	self assertSocketState: #isBound.
	self should: [ self socket receive ] raise: OCNSocketOperationForbiddenError.
	self assertSocketState: #isBound.
	self signalFailure: 'should send testReceivingLessDataThanSocketsDataBufferSize, but a MYSTERIOUS error happens. It looks like the OS does not release the port used by bind'
]

{ #category : #'testing lifecylce' }
OCNTcpSocketReceivingDataTest >> testReceiveOnUnconnectedSocket [
	self assertSocketState: #isClean.
	self should: [ self socket receive ] raise: OCNSocketOperationForbiddenError.
	self assertSocketState: #isClean.
	self testReceivingLessDataThanSocketsDataBufferSize
]

{ #category : #testing }
OCNTcpSocketReceivingDataTest >> testReceivingLargeAmountOfDataComparedToSizeOfSocketsDataBuffer [
	self assertReceivingDataOfSize: 1000 * self library defaultDataBufferSize.

]

{ #category : #testing }
OCNTcpSocketReceivingDataTest >> testReceivingLessDataThanSocketsDataBufferSize [
	| dataSize dataToSend  receivedData | 
	dataSize := self library defaultDataBufferSize//2 .
	self assertReceivingDataOfSize: dataSize

]

{ #category : #testing }
OCNTcpSocketReceivingDataTest >> testReceivingMoreDataThanSizeOfSocketsDataBuffer [
	| dataSize |
	dataSize := 2 * self library defaultDataBufferSize.
	self assertReceivingDataOfSize: dataSize
]
