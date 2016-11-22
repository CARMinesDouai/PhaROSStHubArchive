Class {
	#name : #NeSendReceiveLargeDataTest,
	#superclass : #NeLargeDataTest,
	#instVars : [
		'receiver',
		'sender'
	],
	#category : #'NetworkExtras-UDP-SendReceiveLargeData'
}

{ #category : #testing }
NeSendReceiveLargeDataTest >> receiverIp [
	^ #[127 0 0 1]
]

{ #category : #testing }
NeSendReceiveLargeDataTest >> receiverPort [
	^54321
]

{ #category : #testing }
NeSendReceiveLargeDataTest >> setUp [
	super setUp.
	receiver := NeUdpLargeDataReceiver new.
	receiver port: self receiverPort.
	receiver start.
	sender := NeUdpLargeDataSender new.
	sender ip: self receiverIp.
	sender port: self receiverPort
]

{ #category : #testing }
NeSendReceiveLargeDataTest >> tearDown [
	super tearDown.
	receiver destroy.
	sender destroy.
]

{ #category : #testing }
NeSendReceiveLargeDataTest >> test1Sender1Receiver [
	| receivedData sentData |
	receiver withReceivedDataDo: [ :data | receivedData := data ].
	sentData := self get100KBytesOfSourceFile.
	sender send: sentData.
	self waitWhile: [ receivedData isNil ] timeout: 500 milliSeconds.
	self assert: receivedData equals: sentData asByteArray
]

{ #category : #testing }
NeSendReceiveLargeDataTest >> test2Senders1Receiver [
	| receivedDataSet sentData1 sentData2 sender2 |
	sender2 := NeUdpLargeDataSender new.
	sender2 ip: self receiverIp.
	sender2 port: self receiverPort.
	sender2 id: #sender2.
	sender id: #sender1.
	receivedDataSet := Set new.
	receiver withReceivedDataDo: [ :data | receivedDataSet add: data ].
	sentData1 := self get100KBytesOfSourceFile asByteArray.
	sentData2 := self get5KBytesOfSourceFile asByteArray.
	[sender send: sentData1] forkAt: Processor userBackgroundPriority.
	[sender2 send: sentData2] forkAt: Processor userBackgroundPriority.
	self waitWhile: [ receivedDataSet size < 2 ] timeout: 500 milliSeconds.
	self assert: receivedDataSet equals: {sentData1. sentData2} asSet
]
