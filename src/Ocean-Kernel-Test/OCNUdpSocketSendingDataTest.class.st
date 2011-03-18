Class {
	#name : #OCNUdpSocketSendingDataTest,
	#superclass : #OCNUdpSocketTest,
	#traits : 'OCNTSocketSendingDataTest - {#socket. #serverShell. #randomAsciiStringOfSize:}',
	#classTraits : 'OCNTSocketSendingDataTest classTrait',
	#category : #'Ocean-Kernel-Test'
}

{ #category : #requirements }
OCNUdpSocketSendingDataTest >> assertSendingDataOfSize: dataSize [
	| dataToSend receivedData aDatagramPacket receivedDataStream | 
	self startServer.
	dataToSend := self randomAsciiStringOfSize: dataSize.
	aDatagramPacket := OCNDatagramPacket new.
	aDatagramPacket
		data: dataToSend; 
		targetAddress: self serverAddress ; 
		more: false.
	self assert: (self socket send: aDatagramPacket) = dataSize.
	(Delay forMilliseconds: 50) wait.
	
	receivedDataStream := FileStream readOnlyFileNamed: 'test.log'.  
	[ receivedData := receivedDataStream contents  ] ensure: [ receivedDataStream close ].
	
	self deny: receivedData isEmpty.
	self assert: (dataToSend beginsWith: receivedData). "for debug"
	self assert: receivedData size = dataSize.
	self assert: receivedData = dataToSend.

]
