Class {
	#name : #NeUdpServerTest,
	#superclass : #TestCase,
	#traits : 'NeTWait',
	#classTraits : 'NeTWait classTrait',
	#instVars : [
		'server',
		'sender',
		'allReceivedData'
	],
	#category : #'NetworkExtras-UDP-Kernel'
}

{ #category : #testing }
NeUdpServerTest >> setUp [
	super setUp.
	allReceivedData := OrderedCollection new.
	server := NeUdpServer port: 1234.
	server onReceptionDo: [ :data | allReceivedData add: data asString ].
	server priority: Processor userInterruptPriority.

]

{ #category : #testing }
NeUdpServerTest >> tearDown [
	super tearDown.
	sender closeAndDestroy.
	server stop
]

{ #category : #testing }
NeUdpServerTest >> testBroadcastSendReceive [
	| allSentData |
	allSentData := #('Hello' 'World' 'Pharo').
	server start.
	sender := NeBroadcastSocket port: server port.
	allSentData withIndexDo: [ :each :index | 
		sender send: each.
		self waitUntil: [ allReceivedData size = index ].
	].
	self assert: allReceivedData asArray equals: allSentData
]

{ #category : #testing }
NeUdpServerTest >> testUnicastSendReceive [
	| allSentData |
	allSentData := #('Hello' 'World' 'Pharo').
	server start.
	sender := NeUnicastUdpSocket receiverIp: '127.0.0.1' port: server port.
	allSentData withIndexDo: [ :each :index | 
		sender send: each.
		self waitUntil: [ allReceivedData size = index ].
	].
	self assert: allReceivedData asArray equals: allSentData
]
