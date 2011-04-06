Class {
	#name : #OCNUdpSocketSendingDataTest,
	#superclass : #OCNUdpSocketTest,
	#traits : 'TOCNSocketSendingDataTest - {#socket. #randomAsciiStringOfSize:}',
	#classTraits : 'TOCNSocketSendingDataTest classTrait',
	#category : #'Ocean-Kernel-Test'
}

{ #category : #requirements }
OCNUdpSocketSendingDataTest >> assertSendingDataOfSize: dataSize [
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
OCNUdpSocketSendingDataTest >> serverClass [
	^OCNUdpSendingServerForTest
]

{ #category : #'tests sending' }
OCNUdpSocketSendingDataTest >> testSendingLargeAmountOfDataComparedToSizeOfSocketsDataBuffer [
	self should: [ self assertSendingDataOfSize: 1000 * self library defaultDataBufferSize ] raise: OCNInvalidDatagramPacketError

]

{ #category : #'tests sending' }
OCNUdpSocketSendingDataTest >> testSendingMoreDataThanSizeOfSocketsDataBuffer [
	self assertSendingDataOfSize: 2 * self library defaultDataBufferSize

]
