Class {
	#name : #NeUnicastUdpSocketTest,
	#superclass : #TestCase,
	#instVars : [
		'port',
		'receiver',
		'sender'
	],
	#category : #'NetworkExtras-UDP-Unicast'
}

{ #category : #'initialize-release' }
NeUnicastUdpSocketTest >> setUp [
	super setUp.
	port := 1234.
	receiver := NeReceiveUdpSocket port: port.
	sender := NeSendUdpSocket ip: '127.0.0.1' port: port.

]

{ #category : #'initialize-release' }
NeUnicastUdpSocketTest >> tearDown [
	super tearDown.
	sender closeAndDestroy.
	receiver closeAndDestroy
]

{ #category : #Running }
NeUnicastUdpSocketTest >> testSendReceive [
	sender send: 'Hello'.
	self assert: (receiver receiveTimeout: 1) asString equals: 'Hello'
]
