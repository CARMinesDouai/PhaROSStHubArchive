Class {
	#name : #NeUdpLargeDataReceiver,
	#superclass : #NeUdpSocketWrapper,
	#instVars : [
		'thread',
		'receptionBuffer',
		'reconstructorsDict',
		'reconstructionBlock'
	],
	#category : #'NetworkExtras-UDP-SendReceiveLargeData'
}

{ #category : #receiving }
NeUdpLargeDataReceiver >> addChunk: chunk [
	(self reconstructorAt: chunk sourceId) addChunk: chunk
]

{ #category : #'initialize-release' }
NeUdpLargeDataReceiver >> destroy [
	self stop.
	super destroy.
]

{ #category : #'initialize-release' }
NeUdpLargeDataReceiver >> initialize [
	super initialize.
	reconstructorsDict := Dictionary new.
	thread := ActiveObject repeat: [ self receiveChunk ].
]

{ #category : #activity }
NeUdpLargeDataReceiver >> isStarted [
	^thread isStarted
]

{ #category : #'initialize-release' }
NeUdpLargeDataReceiver >> maxChunkSize: anInteger [ 
	receptionBuffer := ByteArray new: anInteger.
]

{ #category : #receiving }
NeUdpLargeDataReceiver >> newReconstructor [
	^NeReconstructor new
		withReconstructedDataDo: reconstructionBlock;
		yourself
]

{ #category : #receiving }
NeUdpLargeDataReceiver >> receiveChunk [
	| responseArray receivedBytesCount chunk |
	responseArray := socket receiveUDPDataInto: receptionBuffer.
	receivedBytesCount := responseArray first.
	receivedBytesCount = 0 ifTrue: [ ^self ].
	chunk := FLMaterializer materializeFromByteArray: (receptionBuffer first: receivedBytesCount).
	self addChunk: chunk
]

{ #category : #receiving }
NeUdpLargeDataReceiver >> reconstructorAt: id [
	^reconstructorsDict at: id ifAbsentPut: [self newReconstructor]
	
]

{ #category : #activity }
NeUdpLargeDataReceiver >> start [
	socket setPort: self port.
	thread start
]

{ #category : #activity }
NeUdpLargeDataReceiver >> stop [
	thread stop
]

{ #category : #'initialize-release' }
NeUdpLargeDataReceiver >> withReceivedDataDo: aBlock [
	reconstructionBlock := aBlock 
]
