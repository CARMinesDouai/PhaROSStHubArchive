Class {
	#name : #OCNUdpSocketSendingDataTest,
	#superclass : #OCNUdpSocketTest,
	#traits : 'OCNSocketSendingDataTest - {#socket. #serverShell. #randomAsciiStringOfSize:}',
	#classTraits : 'OCNSocketSendingDataTest classTrait',
	#category : #'Ocean-Kernel-Test'
}

{ #category : #requirements }
OCNUdpSocketSendingDataTest >> assertSendingDataOfSize: dataSize [
	| dataToSend receivedData aDatagramPacket | 
	self startServer.
	dataToSend := self randomAsciiStringOfSize: dataSize.
	aDatagramPacket := OCNDatagramPacket new.
	aDatagramPacket
		data: dataToSend; 
		targetAddress: self serverAddress ; 
		more: false.
	self assert: (self socket send: aDatagramPacket) = dataSize.
	(Delay forMilliseconds: 50) wait.
	receivedData := self serverShell stdOut contents.
	self assert: (dataToSend beginsWith: receivedData). "for debug"
	self assert: receivedData size = dataSize.
	self assert: receivedData = dataToSend.

]
