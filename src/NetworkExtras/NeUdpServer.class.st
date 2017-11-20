"
I am a UDP server. I handle incoming UDP data repeatedly in a dedicated thread.

    Instance Variables
	actionBlock:		<BlockClosure> block to handle incoming data
	socket:		<NeUdpSocket> socket listening on the UDP port
	thread:		<ActiveObject>  handles the repeated action. 
			
Since we realy on ActiveObjects, the thread is garbage collected if it's not referenced any more.		
Upon termination, it closes the socket ensuring releasing related resources.


"
Class {
	#name : #NeUdpServer,
	#superclass : #Object,
	#instVars : [
		'thread',
		'socket',
		'actionBlock'
	],
	#category : #'NetworkExtras-UDP-Kernel'
}

{ #category : #'instance creation' }
NeUdpServer class >> receptionPort: portNumber [
	^self socket: (NeUnicastUdpSocket receptionPort: portNumber)

]

{ #category : #'instance creation' }
NeUdpServer class >> socket: udpSocket [
	^self new
		socket: udpSocket;
		yourself
]

{ #category : #'initialize-release' }
NeUdpServer >> initialize [
	super initialize.
	thread := ActiveObject repeat: [ self receiveData ] ensure: [self socket closeAndDestroy].
	actionBlock := [ :data | data asString logCr ]
]

{ #category : #activity }
NeUdpServer >> isStarted [
	^ thread isStarted
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
NeUdpServer >> port [
	^self socket receptionPort
]

{ #category : #accessing }
NeUdpServer >> priority [
	^thread priority
]

{ #category : #accessing }
NeUdpServer >> priority: aPriority [
	thread priority: aPriority
]

{ #category : #activity }
NeUdpServer >> receiveData [
	| receivedData |
	receivedData := self socket receive.
	receivedData ifEmpty: [ ^ self ].
	actionBlock cull: receivedData
]

{ #category : #accessing }
NeUdpServer >> socket [
	^ socket
]

{ #category : #accessing }
NeUdpServer >> socket: anObject [
	socket := anObject
]

{ #category : #activity }
NeUdpServer >> start [
	self isStarted ifTrue: [ ^self ].
	thread name: 'UDP server on socket ', self socket asString.
	thread start.
]

{ #category : #activity }
NeUdpServer >> stop [
	thread stop
]
