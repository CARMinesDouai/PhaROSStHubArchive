"
server := OCNUdpReceivingServerForTest onPortNumber: 9091.
server start.  

server receivedData asString 

server stop.
Socket allInstancesDo: [ :s | s closeAndDestroy ]   .
Socket allInstances.  


"
Class {
	#name : #OCNUdpReceivingServerForTest,
	#superclass : #OCNUdpServerForTest,
	#instVars : [
		'receivedData'
	],
	#category : #'Ocean-Kernel-TestSupport'
}

{ #category : #'initialize-release' }
OCNUdpReceivingServerForTest >> initialize [ 
	super initialize.
	receivedData := (ByteArray new: 2000)  
]

{ #category : #accessing }
OCNUdpReceivingServerForTest >> interactThrough [
	
		"Receive UDP data into the given buffer and return the number of bytes received. Note the given buffer may be only partially filled by the received data. What is returned is an array, the first element is the bytes read, the second the sending bytearray address, the third the senders port, the fourth, true if more of the datagram awaits reading"
	
	"add a while true because the prmitive is non-blocking"
	
	"perhaps should use the read semaphore attached to the sockets"
	
	|socketId endTime|
	
	socketId := self listenSocket socketHandle.
	endTime := Time now asSeconds + 3.
	[
			(self listenSocket primSocketReceiveDataAvailable: socketId)
				ifTrue: [^ self listenSocket primSocket: socketId
							receiveUDPDataInto: receivedData
							startingAt: 1
							count: receivedData size].
			Time now asSeconds > endTime.
		] whileFalse.
]

{ #category : #accessing }
OCNUdpReceivingServerForTest >> receivedData [
	^receivedData
]
