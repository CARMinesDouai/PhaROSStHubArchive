Class {
	#name : #NeUnicastUdpServerTest,
	#superclass : #TestCase,
	#traits : 'NeTWait',
	#classTraits : 'NeTWait classTrait',
	#instVars : [
		'port',
		'server',
		'sender',
		'allReceivedData'
	],
	#category : #'NetworkExtras-UDP-Unicast'
}

{ #category : #'initialize-release' }
NeUnicastUdpServerTest >> setUp [
	super setUp.
	allReceivedData := OrderedCollection new.
	port := 1234.
	server := NeUdpServer port: port.
	server onReceptionDo: [ :data | allReceivedData add: data asString ].
	server priority: Processor userInterruptPriority.
	sender := NeSendUdpSocket ip: '127.0.0.1' port: port
]

{ #category : #'initialize-release' }
NeUnicastUdpServerTest >> tearDown [
	super tearDown.
	sender closeAndDestroy.
	server stop
]

{ #category : #Running }
NeUnicastUdpServerTest >> testSendReceive [
	| allSentData |
	allSentData := #('Hello' 'World' 'Pharo').
	server start.
	allSentData withIndexDo: [ :each :index | 
		sender send: each.
		self waitUntil: [ allReceivedData size = index ].
	].
	self assert: allReceivedData asArray equals: allSentData
]
