Class {
	#name : #OCNUdpSocketReceivingDataTest,
	#superclass : #OCNUdpSocketTest,
	#category : #'Ocean-Kernel-Test'
}

{ #category : #requirements }
OCNUdpSocketReceivingDataTest >> assertReceivingDataOfSize: dataSize [
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
OCNUdpSocketReceivingDataTest >> serverClass [
	^OCNUdpReceivingServerForTest 
]
