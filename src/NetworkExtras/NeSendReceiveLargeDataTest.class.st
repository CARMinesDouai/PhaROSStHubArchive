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
NeSendReceiveLargeDataTest >> setUp [
	super setUp.
	receiver := NeUdpReceiver new.
	receiver port: 12345.
	receiver start.
	sender := NeUdpSender new.
	sender ip: #[127 0 0 1].
	sender port: receiver port.
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
