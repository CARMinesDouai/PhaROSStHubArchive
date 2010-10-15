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
	self assertConnection.
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

{ #category : #accessing }
OCNTcpSocketReceivingDataTest >> serverShellClass [ 
	^OCNFileStdInOutShell
]

{ #category : #'setUp-tearDown' }
OCNTcpSocketReceivingDataTest >> setUpServerShell [
	super setUpServerShell.
	serverShell	stdInFileName: 'test.in'

]

{ #category : #'setUp-tearDown' }
OCNTcpSocketReceivingDataTest >> tearDown [
	super tearDown.
	serverShell deleteStdInFile
]

{ #category : #testing }
OCNTcpSocketReceivingDataTest >> testDisconnectionWhileReceiving [
	self fail
]

{ #category : #testing }
OCNTcpSocketReceivingDataTest >> testReceivingLargeAmountOfDataComparedToSizeOfSocketsDataBuffer [
	self assertReceivingDataOfSize: 1000 * library defaultDataBufferSize.

]

{ #category : #testing }
OCNTcpSocketReceivingDataTest >> testReceivingLessDataThanSocketsDataBufferSize [
	| dataSize dataToSend  receivedData | 
	dataSize := library defaultDataBufferSize//2 .
	self assertReceivingDataOfSize: dataSize

]

{ #category : #testing }
OCNTcpSocketReceivingDataTest >> testReceivingMoreDataThanSizeOfSocketsDataBuffer [
	| dataSize |
	dataSize := 2 * library defaultDataBufferSize.
	self assertReceivingDataOfSize: dataSize
]
