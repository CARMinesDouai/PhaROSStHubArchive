Class {
	#name : #OCNUdpReceivingServerForTest,
	#superclass : #OCNUdpServerForTest,
	#instVars : [
		'receivedDataStream'
	],
	#category : #'Ocean-Kernel-TestSupport'
}

{ #category : #'initialize-release' }
OCNUdpReceivingServerForTest >> initialize [ 
	super initialize.
	receivedDataStream := (String new: 2000) writeStream 
]

{ #category : #accessing }
OCNUdpReceivingServerForTest >> interactThrough: aDatagram [
	
	self listenSocket receiveUDPDataInto: receivedDataStream
]

{ #category : #accessing }
OCNUdpReceivingServerForTest >> receivedData [
	^receivedDataStream contents 
]
