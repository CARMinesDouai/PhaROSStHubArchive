Class {
	#name : #OCNTcpSocketSendingDataTest,
	#superclass : #OCNTcpSocketTest,
	#category : #'Ocean-Kernel-Test'
}

{ #category : #testing }
OCNTcpSocketSendingDataTest >> assertSendingDataOfSize: dataSize [
	| dataToSend receivedData | 
	self assertConnection.
	dataToSend := self randomAsciiStringOfSize: dataSize.
	self assert: (socket send: dataToSend) = dataSize.
	(Delay forMilliseconds: 50) wait.
	receivedData := serverShell stdOut contents.
	self assert: receivedData size = dataSize.
	self assert: receivedData = dataToSend.

]

{ #category : #'setUp-tearDown' }
OCNTcpSocketSendingDataTest >> setUp [
	super setUp.
	self startServer
]

{ #category : #testing }
OCNTcpSocketSendingDataTest >> testCloseOnClosedSocket [
	self testCloseOnConnectedSocket.
	socket close.
	self assert: socket isClosed 
]

{ #category : #testing }
OCNTcpSocketSendingDataTest >> testCloseOnConnectedSocket [
	self assertConnection.
	self assert: socket isClosed not.
	socket close.
	self assert: socket isClosed
]

{ #category : #testing }
OCNTcpSocketSendingDataTest >> testDisconnectionWhileSending [
	self fail
]

{ #category : #testing }
OCNTcpSocketSendingDataTest >> testSendingLargeAmountOfDataComparedToSizeOfSocketsDataBuffer [
	self assertSendingDataOfSize: 1000 * library defaultDataBufferSize.

]

{ #category : #testing }
OCNTcpSocketSendingDataTest >> testSendingLessDataThanSocketsDataBufferSize [
	self assertSendingDataOfSize: library defaultDataBufferSize//2 .

]

{ #category : #testing }
OCNTcpSocketSendingDataTest >> testSendingMoreDataThanSizeOfSocketsDataBuffer [
	self assertSendingDataOfSize: 2 * library defaultDataBufferSize.

]
