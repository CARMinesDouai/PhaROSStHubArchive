Class {
	#name : #OCNUdpSocketReceivingDataTest,
	#superclass : #OCNUdpSocketTest,
	#traits : 'TOCNSocketSendingDataTest - {#socket. #randomAsciiStringOfSize:. #testDisconnectionWhileSending}',
	#classTraits : 'TOCNSocketSendingDataTest classTrait',
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

{ #category : #requirements }
OCNUdpSocketReceivingDataTest >> assertSendingDataOfSize: dataSize [
	| dataToSend receivedData aDatagramPacket receivedDataStream sentDataSize| 
	self startServer.
	dataToSend := self randomAsciiStringOfSize: dataSize.
	aDatagramPacket := OCNDatagramPacket new.
	aDatagramPacket
		data: dataToSend; 
		targetAddress: self serverAddress ; 
		more: false.
		
	[sentDataSize := self socket send: aDatagramPacket] on: OCNInvalidDatagramPacketError do: [ :e | e pass ].
	
	(Delay forMilliseconds: 50) wait.
	
	receivedDataStream := FileStream readOnlyFileNamed: 'test.log'.  
	[ receivedData := receivedDataStream contents  ] ensure: [ receivedDataStream close ].
	
	self assert: sentDataSize = receivedData size.
	self deny: receivedData isEmpty.
	self assert: (dataToSend beginsWith: receivedData). "for debug"
	self assert: receivedData size = dataSize.
	self assert: receivedData = dataToSend.

]

{ #category : #accessing }
OCNUdpSocketReceivingDataTest >> serverClass [
	^OCNUdpReceivingServerForTest 
]
