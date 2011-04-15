Class {
	#name : #OCNUdpSocketReceivingDataTest,
	#superclass : #OCNUdpSocketTest,
	#category : #'Ocean-Kernel-Test'
}

{ #category : #asserting }
OCNUdpSocketReceivingDataTest >> assertReceivingDataOfSize: dataSize [
	| dataToSend receptionStream waitForData dataPacket receivedData |
	dataToSend := self randomAsciiStringOfSize: dataSize.
	self startServer.
	server dataToSend: dataToSend.

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
OCNUdpSocketReceivingDataTest >> serverClass [
	^OCNUdpSendingServerForTest 
]

{ #category : #testing }
OCNUdpSocketReceivingDataTest >> testReceivingLargeAmountOfDataComparedToSizeOfSocketsDataBuffer [
	self assertReceivingDataOfSize: 1000 * socket receiveDataBufferSize.

]

{ #category : #testing }
OCNUdpSocketReceivingDataTest >> testReceivingLessDataThanSocketsDataBufferSize [
	| dataSize dataToSend  receivedData | 
	dataSize := socket receiveDataBufferSize//2 .
	self assertReceivingDataOfSize: dataSize

]

{ #category : #testing }
OCNUdpSocketReceivingDataTest >> testReceivingMoreDataThanSizeOfSocketsDataBuffer [
	| dataSize |
	dataSize := 2 * socket receiveDataBufferSize.
	self assertReceivingDataOfSize: dataSize
]
