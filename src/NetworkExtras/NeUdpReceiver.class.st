Class {
	#name : #NeUdpReceiver,
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
NeUdpReceiver >> addChunk: chunk [
	(self reconstructorAt: chunk id) addChunk: chunk
]

{ #category : #'initialize-release' }
NeUdpReceiver >> destroy [
	self stop.
	super destroy.
]

{ #category : #'initialize-release' }
NeUdpReceiver >> initialize [
	super initialize.
	reconstructorsDict := Dictionary new.
	thread := ActiveObject repeat: [ self receiveChunk ].
]

{ #category : #activity }
NeUdpReceiver >> isStarted [
	^thread isStarted
]

{ #category : #'initialize-release' }
NeUdpReceiver >> maxChunkSize: anInteger [ 
	receptionBuffer := ByteArray new: anInteger.
]

{ #category : #receiving }
NeUdpReceiver >> newReconstructor [
	^NeReconstructor new
		withReconstructedDataDo: reconstructionBlock;
		yourself
]

{ #category : #receiving }
NeUdpReceiver >> receiveChunk [
	| responseArray receivedBytesCount chunk |
	responseArray := socket receiveUDPDataInto: receptionBuffer.
	receivedBytesCount := responseArray first.
	receivedBytesCount = 0 ifTrue: [ ^self ].
	chunk := FLMaterializer materializeFromByteArray: (receptionBuffer first: receivedBytesCount).
	self addChunk: chunk
]

{ #category : #receiving }
NeUdpReceiver >> reconstructorAt: id [
	^reconstructorsDict at: id ifAbsentPut: [self newReconstructor]
	
]

{ #category : #activity }
NeUdpReceiver >> start [
	socket setPort: self port.
	thread start
]

{ #category : #activity }
NeUdpReceiver >> stop [
	thread stop
]

{ #category : #'initialize-release' }
NeUdpReceiver >> withReceivedDataDo: aBlock [
	reconstructionBlock := aBlock 
]
