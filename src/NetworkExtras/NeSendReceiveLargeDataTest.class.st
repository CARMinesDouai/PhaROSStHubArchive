Class {
	#name : #NeSendReceiveLargeDataTest,
	#superclass : #NeLargeDataTest,
	#instVars : [
		'receiver',
		'socketWrappers'
	],
	#category : #'NetworkExtras-UDP-SendReceiveLargeData'
}

{ #category : #testing }
NeSendReceiveLargeDataTest >> newSender [
	| newSender |
	newSender := NeUdpLargeDataSender onUnicastIp: self targetIp port: self targetPort.
	socketWrappers add: newSender.
	^newSender
]

{ #category : #testing }
NeSendReceiveLargeDataTest >> setUp [
	super setUp.
	socketWrappers := Set new.
	self setUpReceiver.
]

{ #category : #testing }
NeSendReceiveLargeDataTest >> setUpReceiver [
	receiver := NeUdpLargeDataReceiver onUnicastPort: self targetPort.
	receiver start.
	socketWrappers add: receiver.
]

{ #category : #testing }
NeSendReceiveLargeDataTest >> targetIp [
	^ #[127 0 0 1]
]

{ #category : #testing }
NeSendReceiveLargeDataTest >> targetPort [
	^54321
]

{ #category : #testing }
NeSendReceiveLargeDataTest >> tearDown [
	super tearDown.
	socketWrappers do: [ :each | each destroy].

]

{ #category : #testing }
NeSendReceiveLargeDataTest >> test1Sender1Receiver [
	| receivedData sentData sender |
	receiver withReceivedDataDo: [ :data | receivedData := data ].
	sender := self newSender.
	sentData := self get100KBytesOfSourceFile.
	sender send: sentData.
	self waitWhile: [ receivedData isNil ] timeout: 500 milliSeconds.
	self assert: receivedData equals: sentData asByteArray
]

{ #category : #testing }
NeSendReceiveLargeDataTest >> test2Senders1Receiver [
	| receivedDataSet sentData1 sentData2 sender1 sender2 |
	sender1 := self newSender.
	sender1 id: #sender1.
	sender2 := self newSender.
	sender2 id: #sender2.
	receivedDataSet := Set new.
	receiver withReceivedDataDo: [ :data | receivedDataSet add: data ].
	sentData1 := self get100KBytesOfSourceFile asByteArray.
	sentData2 := self get5KBytesOfSourceFile asByteArray.
	[ sender1 send: sentData1 ] forkAt: Processor userBackgroundPriority.
	[ sender2 send: sentData2 ] forkAt: Processor userInterruptPriority.
	self waitWhile: [ receivedDataSet size < 2 ] timeout: 500 milliSeconds.
	self
		assert: receivedDataSet
		equals:
			{sentData1.
			sentData2} asSet
]
