"
server := OCNUdpReceivingServerForTest onPortNumber: 8888.
server start.  

""java ClientUDPEcho localhost 8888 totototo""

server receivedData asString 

server kill.
Socket allInstancesDo: [ :s | s closeAndDestroy ]   .
Socket allInstances.  


"
Class {
	#name : #OCNUdpReceivingServerForTest,
	#superclass : #OCNUdpServerForTest,
	#instVars : [
		'receivedData',
		'buffer'
	],
	#category : #'Ocean-KernelTests-Support'
}

{ #category : #'initialize-release' }
OCNUdpReceivingServerForTest >> initialize [ 
	super initialize.
	buffer := (ByteArray new: 70000).
	
]

{ #category : #accessing }
OCNUdpReceivingServerForTest >> interactThrough [
	
		"Receive UDP data into the given buffer and return the number of bytes received. Note the given buffer may be only partially filled by the received data. What is returned is an array, the first element is the bytes read, the second the sending bytearray address, the third the senders port, the fourth, true if more of the datagram awaits reading"
	
	"add a while true because the prmitive is non-blocking"
	
	"perhaps should use the read semaphore attached to the sockets"
	
	|socketId endTime resultArray receivedDataSize|
	
	socketId := self listenSocket socketHandle.
	endTime := Time now asSeconds + 3.
	[
			(self listenSocket primSocketReceiveDataAvailable: socketId)
				ifTrue: [resultArray := self listenSocket primSocket: socketId
							receiveUDPDataInto: buffer
							startingAt: 1
							count: buffer size.
						receivedData := (buffer copyFrom: 1 to: (resultArray at: 1)) asString	
						].
			Time now asSeconds > endTime.
		] whileFalse.
]

{ #category : #accessing }
OCNUdpReceivingServerForTest >> receivedData [
	^receivedData
]

{ #category : #'initialize-release' }
OCNUdpReceivingServerForTest >> setUpListenSocket [ 
	super setUpListenSocket.
	self listenSocket primSocketBind: self listenSocket socketHandle to: #[127 0 0 1] port: self portNumber.
]
