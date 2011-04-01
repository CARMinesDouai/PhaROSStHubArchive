Class {
	#name : #OCNTcpReceivingServerForTest,
	#superclass : #OCNTcpServerForTest,
	#instVars : [
		'receivedDataStream'
	],
	#category : #'Ocean-Kernel-TestSupport'
}

{ #category : #'initialize-release' }
OCNTcpReceivingServerForTest >> initialize [ 
	super initialize.
	receivedDataStream := (String new: 2000) writeStream 
]

{ #category : #accessing }
OCNTcpReceivingServerForTest >> interactThrough: aSocketStream [
	receivedDataStream nextPutAll: aSocketStream upToEnd
]

{ #category : #accessing }
OCNTcpReceivingServerForTest >> receivedData [
	^receivedDataStream contents 
]
