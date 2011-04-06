Class {
	#name : #OCNUdpSocketSendingDataTest,
	#superclass : #OCNUdpSocketTest,
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
	self should: [ self assertSendingDataOfSize: 65529 ] raise: OCNInvalidDatagramPacketError

]

{ #category : #'tests sending' }
OCNUdpSocketSendingDataTest >> testSendingLessDataThanSocketsDataBufferSize [
	self assertSendingDataOfSize: self library defaultDataBufferSize//2 .

]

{ #category : #'tests sending' }
OCNUdpSocketSendingDataTest >> testSendingMoreDataThanSizeOfSocketsDataBuffer [
	self assertSendingDataOfSize: 2 * self library defaultDataBufferSize

]
