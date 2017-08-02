Class {
	#name : #NeUnicastUdpSocketTest,
	#superclass : #TestCase,
	#traits : 'NeTWait',
	#classTraits : 'NeTWait classTrait',
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
NeUnicastUdpSocketTest >> testCloseWhileReceiving [
	| done errorSignaled |
	done := false.
	errorSignaled := false.
	[ 
		[ [receiver receiveTimeout: 1] ensure: [ done := true ] ] on: Error do: [errorSignaled := true]. 
	] forkAt: Processor userInterruptPriority.
	receiver closeAndDestroy.
	self waitUntil: [ done ] timeout: 1 second.
	self deny: errorSignaled.
]

{ #category : #Running }
NeUnicastUdpSocketTest >> testReceiveSend [
	| sentData receivedData |
	sentData := 'Hello World!'.
	[self shouldnt: [receivedData := receiver receiveTimeout: 1] raise: Error] forkAt: Processor userInterruptPriority.
	sender send: sentData.	
	self waitWhile: [ receivedData isNil ].
	self assert: receivedData asString equals: sentData.
]

{ #category : #Running }
NeUnicastUdpSocketTest >> testReceiveTimeout [
	| timeoutSignaled |
	timeoutSignaled := false.
	[ 
		[ receiver receiveTimeout: 1 ] on: ConnectionTimedOut do: [timeoutSignaled := true]. 
	] forkAt: Processor userInterruptPriority.
	self waitUntil: [ timeoutSignaled ] timeout: 1 second.

]

{ #category : #Running }
NeUnicastUdpSocketTest >> testSendReceive [
	sender send: 'Hello'.
	self assert: (receiver receiveTimeout: 1) asString equals: 'Hello'
]
