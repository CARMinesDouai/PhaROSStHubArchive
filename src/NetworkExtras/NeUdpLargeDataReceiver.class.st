Class {
	#name : #NeUdpLargeDataReceiver,
	#superclass : #NeUdpSocketWrapper,
	#instVars : [
		'thread',
		'reconstructorsDict',
		'reconstructionBlock'
	],
	#category : #'NetworkExtras-UDP-SendReceiveLargeData'
}

{ #category : #'instance creation' }
NeUdpLargeDataReceiver class >> onUnicastPort: portNumber [
	^ self onSocket: (NeReceiveUdpSocket port: portNumber)
]

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

{ #category : #receiving }
NeUdpLargeDataReceiver >> newReconstructor [
	^NeReconstructor new
		withReconstructedDataDo: reconstructionBlock;
		yourself
]

{ #category : #receiving }
NeUdpLargeDataReceiver >> receiveChunk [
	| receivedBytes chunk |
	receivedBytes := socket receive.
	receivedBytes ifEmpty: [ ^ self ].
	chunk := FLMaterializer materializeFromByteArray: receivedBytes.
	self addChunk: chunk
]

{ #category : #receiving }
NeUdpLargeDataReceiver >> reconstructorAt: id [
	^reconstructorsDict at: id ifAbsentPut: [self newReconstructor]
	
]

{ #category : #activity }
NeUdpLargeDataReceiver >> start [
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
