"
// ClientUDP 127.0.0.1 9123

socket := OCNUdpSocket newWithNetworkLibrary: OCNSocketPluginLibrary proxy.  
socket socketId.
socket bindToLocalHostPort: 9123.  

count:= 0.
datagram := nil. 
[datagram isNil and: [ count < 5]] whileTrue: [
	[datagram := socket receive] on: OCNTimeOutError do: []. 
	count := count + 1].

datagram data asString.

socket destroy.

"
Class {
	#name : #OCNUdpSocketReceivingDataTest,
	#superclass : #OCNUdpSocketTest,
	#category : #'Ocean-KernelTests-Old'
}

{ #category : #asserting }
OCNUdpSocketReceivingDataTest >> assertReceivingDataOfSize: dataSize [
	| receivedSize sentBytes listenSocket receiveProcess dataToSend receptionStream dataPacket receivedData |
	dataToSend := self randomAsciiStringOfSize: dataSize.

	
	self socket bindToLocalHostPort: self serverPort.

	receptionStream := WriteStream on: (ByteArray new: dataSize).
	
	receiveProcess := [1 to: ((dataSize // self socket receiveDataBufferSize) + ((dataSize rem: (self socket receiveDataBufferSize)) / dataSize))
		do: [:e |
			dataPacket := self socket receive.
			receptionStream nextPutAll: dataPacket data.
		]] newProcess. "On pense que le flag more n'est pas g√©r√© par la primitive sendUDP de oldSocket"
	
	receiveProcess priority: Processor lowIOPriority.
	receiveProcess resume.
	
	listenSocket := Socket newUDPWithBufferOfSize: self socket receiveDataBufferSize. "we should send packets containing at most readDataBufferSize characters of the receiving socket"
	

	sentBytes := 0.

	[sentBytes < dataToSend size ] whileTrue: [
		|count maxSending|
		maxSending:= (sentBytes + self socket receiveDataBufferSize) min: dataToSend size.
		(Delay forMilliseconds: 15) wait.
		count :=  listenSocket primSocket:  listenSocket socketHandle
			sendUDPData: dataToSend
			toHost: self serverAddress ip
			port:  self serverPort 
			startIndex: (sentBytes + 1)
			count:  (maxSending - sentBytes) "dataToSend size". 
		sentBytes := sentBytes + count.
	].

	(Delay forMilliseconds: 300) wait.

	receivedData := receptionStream contents asString.
	receiveProcess terminate.
	listenSocket closeAndDestroy.
	
	self assert: receivedData = dataToSend
	

]

{ #category : #accessing }
OCNUdpSocketReceivingDataTest >> serverClass [
	^OCNUdpSendingServerForTest 
]

{ #category : #accessing }
OCNUdpSocketReceivingDataTest >> shouldBeSubclassedForBackendTesting [
	^true
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
