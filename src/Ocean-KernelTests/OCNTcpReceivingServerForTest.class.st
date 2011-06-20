Class {
	#name : #OCNTcpReceivingServerForTest,
	#superclass : #OCNTcpServerForTest,
	#instVars : [
		'receivedData',
		'receivedSemaphore',
		'interact'
	],
	#category : #'Ocean-KernelTests-Support'
}

{ #category : #'initialize-release' }
OCNTcpReceivingServerForTest >> initialize [ 
	super initialize.
	receivedData := String new.
	self receivedSemaphore: Semaphore new.
	self interact: true
]

{ #category : #accessing }
OCNTcpReceivingServerForTest >> interact [
	^ interact
]

{ #category : #accessing }
OCNTcpReceivingServerForTest >> interact: anObject [
	interact := anObject
]

{ #category : #accessing }
OCNTcpReceivingServerForTest >> interactThrough: aSocketStream [
	|socket delay timeOutCounter receivedDataStream |
	
	socket := aSocketStream socket.
	delay := (Delay forMilliseconds: 10).
	
	receivedDataStream := WriteStream on: (String new: 210000).
	[self interact] whileTrue: [	socket  dataAvailable
		 ifTrue: [receivedDataStream nextPutAll: socket receiveData]
		 ifFalse: [delay wait]
	].
	[socket  dataAvailable] whileTrue: [ receivedDataStream nextPutAll: socket receiveData ].
	
	receivedData := receivedDataStream contents.
		
	self receivedSemaphore signal.
	
]

{ #category : #accessing }
OCNTcpReceivingServerForTest >> receivedData [
	^receivedData
]

{ #category : #accessing }
OCNTcpReceivingServerForTest >> receivedSemaphore [
	^ receivedSemaphore
]

{ #category : #accessing }
OCNTcpReceivingServerForTest >> receivedSemaphore: anObject [
	receivedSemaphore := anObject
]
