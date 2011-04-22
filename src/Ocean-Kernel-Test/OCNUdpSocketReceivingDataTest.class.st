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
	#category : #'Ocean-Kernel-Test'
}

{ #category : #asserting }
OCNUdpSocketReceivingDataTest >> assertReceivingDataOfSize: dataSize [
	| receivedSize sentBytes listenSocket receiveProcess dataToSend receptionStream readMore dataPacket receivedData |
	dataToSend := self randomAsciiStringOfSize: dataSize.
	
	self socket bindToLocalHostPort: self serverPort.

	receptionStream := WriteStream on: (ByteArray new: dataSize).
	readMore := true.
	receiveProcess := [[ readMore ]
		whileTrue: [ 
			dataPacket := self socket receive.
			receptionStream nextPutAll: dataPacket data.
			readMore := dataPacket more]] newProcess. "On pense que le flag more n'est pas géré par la primitive sendUDP de oldSocket"
	
	"receiveProcess priority: Processor lowIOPriority."
	receiveProcess resume.
	
	

	"self startServer."
	"old socket for sending"
	listenSocket := Socket newUDPWithBufferOfSize: self socket receiveDataBufferSize. "we should send packets containing at most readDataBufferSize characters of the receiving socket"
	
	sentBytes := 0.
	[sentBytes < dataToSend size ] whileTrue: [ |count|
		count :=  listenSocket primSocket:  listenSocket socketHandle
			sendUDPData: dataToSend
			toHost: self serverAddress ip
			port:  self serverPort 
			startIndex: sentBytes + 1
			count:  dataToSend size. 
			sentBytes := sentBytes + count.
	].
	
	"server dataToSend: dataToSend."

	(Delay forMilliseconds: 5000) wait.

	receivedData := receptionStream contents asString.
	receiveProcess terminate.
	listenSocket closeAndDestroy.
	
	self assert: receivedData = dataToSend
	

]

{ #category : #accessing }
OCNUdpSocketReceivingDataTest >> serverClass [
	^OCNUdpSendingServerForTest 
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
