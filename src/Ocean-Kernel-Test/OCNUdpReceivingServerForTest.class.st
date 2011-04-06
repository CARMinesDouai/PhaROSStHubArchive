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
	
	OCNSocketPluginLibrary new receiveUDPDataOn: self listenSocket socketHandle into: receivedData
	
]

{ #category : #accessing }
OCNUdpReceivingServerForTest >> receivedData [
	^receivedData
]
