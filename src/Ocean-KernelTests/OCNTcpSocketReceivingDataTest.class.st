Class {
	#name : #OCNTcpSocketReceivingDataTest,
	#superclass : #OCNTcpSocketTest,
	#category : #'Ocean-KernelTests'
}

{ #category : #testing }
OCNTcpSocketReceivingDataTest >> assertReceivingDataOfSize: dataSize [
	| dataToSend receptionStream waitForDataDelay dataPacket receivedData |
	dataToSend := self randomAsciiStringOfSize: dataSize.
	self startServer.
	server sendData: dataToSend.
	self connect.
	receptionStream := WriteStream on: (ByteArray new: dataSize).
	waitForDataDelay := Delay forMilliseconds: 10.
	[self socket isConnected]
		whileTrue: [ 
			self socket isDataAvailable 
				ifTrue: [
					receptionStream nextPutAll: self socket receive]
				ifFalse: [
					waitForDataDelay wait]].
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
	self testReceivingLessDataThanSocketsDataBufferSize.
	"self signalFailure: 'should send testReceivingLessDataThanSocketsDataBufferSize, but a MYSTERIOUS error happens. It looks like the OS does not release the port used by bind'"
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
	self assertReceivingDataOfSize: 1000 * socket receiveDataBufferSize.

]

{ #category : #testing }
OCNTcpSocketReceivingDataTest >> testReceivingLessDataThanSocketsDataBufferSize [
	| dataSize dataToSend  receivedData | 
	dataSize := socket receiveDataBufferSize//2 .
	self assertReceivingDataOfSize: dataSize

]

{ #category : #testing }
OCNTcpSocketReceivingDataTest >> testReceivingMoreDataThanSizeOfSocketsDataBuffer [
	| dataSize |
	dataSize := 2 * socket receiveDataBufferSize.
	self assertReceivingDataOfSize: dataSize
]
