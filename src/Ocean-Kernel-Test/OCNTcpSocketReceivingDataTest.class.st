Class {
	#name : #OCNTcpSocketReceivingDataTest,
	#superclass : #OCNTcpSocketTest,
	#category : #'Ocean-Kernel-Test'
}

{ #category : #testing }
OCNTcpSocketReceivingDataTest >> assertReceivingDataOfSize: dataSize [
	| dataToSend stdIn receptionStream waitForData dataPacket receivedData |
	dataToSend := self randomAsciiStringOfSize: dataSize.
	serverShell deleteStdInFile.
	stdIn := FileStream fileNamed: serverShell stdInFileName.
	[ stdIn nextPutAll: dataToSend ] ensure: [ stdIn close ].
	self startServer.
	self testConnection.
	receptionStream := WriteStream on: (ByteArray new: dataSize).
	waitForData := true.
	[ waitForData ]
		whileTrue: [ 
			dataPacket := socket receive.
			receptionStream nextPutAll: dataPacket.
			waitForData := dataPacket size > 0].
	receivedData := receptionStream contents asString.
	self assert: receivedData = dataToSend
]

{ #category : #'setUp-tearDown' }
OCNTcpSocketReceivingDataTest >> createServerShell [
	serverShell := OCNFileStdInOutShell new.
	serverShell stdOutFileName: 'test.log' ; 
		stdInFileName: 'test.in'
]

{ #category : #'setUp-tearDown' }
OCNTcpSocketReceivingDataTest >> setUp [
	socket := OCNTcpSocket new.
	library := OCNConstants socketLibrary.
	self createServerShell.
]

{ #category : #'setUp-tearDown' }
OCNTcpSocketReceivingDataTest >> tearDown [
	super tearDown.
	serverShell deleteStdInFile.
]

{ #category : #testing }
OCNTcpSocketReceivingDataTest >> testReceivingLargeAmountOfDataComparedToSizeOfSocketsDataBuffer [
	self assertReceivingDataOfSize: 1000 * socket defaultDataBufferSize.

]

{ #category : #testing }
OCNTcpSocketReceivingDataTest >> testReceivingLessDataThanSocketsDataBufferSize [
	| dataSize dataToSend  receivedData | 
	dataSize := socket defaultDataBufferSize//2 .
	self assertReceivingDataOfSize: dataSize

]

{ #category : #testing }
OCNTcpSocketReceivingDataTest >> testReceivingMoreDataThanSizeOfSocketsDataBuffer [
	| dataSize |
	dataSize := 2 * socket defaultDataBufferSize.
	self assertReceivingDataOfSize: dataSize
]
