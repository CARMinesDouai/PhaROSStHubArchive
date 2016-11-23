Class {
	#name : #NeUdpServer,
	#superclass : #Object,
	#instVars : [
		'thread',
		'socket',
		'actionBlock'
	],
	#category : #'NetworkExtras-UDP-Unicast'
}

{ #category : #'instance creation' }
NeUdpServer class >> port: portNumber [
	^ self new
		port: portNumber;
		yourself
]

{ #category : #'initialize-release' }
NeUdpServer >> initialize [
	super initialize.
	socket := NeReceiveUdpSocket new.
	thread := ActiveObject repeat: [ self receiveData ].
	actionBlock := [ :data | data asString logCr ]
]

{ #category : #activity }
NeUdpServer >> isStarted [
	^ thread isStopped
]

{ #category : #activity }
NeUdpServer >> isStopped [
	^ thread isStopped
]

{ #category : #accessing }
NeUdpServer >> onReceptionDo: aBlock [
	actionBlock := aBlock
]

{ #category : #accessing }
NeUdpServer >> port: portNumber [
	socket listenOn: portNumber
]

{ #category : #accessing }
NeUdpServer >> priority: aPriority [
	thread priority: aPriority
]

{ #category : #activity }
NeUdpServer >> receiveData [
	| receivedData |
	receivedData := socket receive.
	receivedData ifEmpty: [ ^self ].
	actionBlock cull: receivedData.
]

{ #category : #activity }
NeUdpServer >> start [
	thread start
]

{ #category : #activity }
NeUdpServer >> stop [
	thread stop
]
