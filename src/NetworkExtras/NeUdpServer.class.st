"
I am a UDP server. I handle incoming UDP data repeatedly in a dedicated thread.

    Instance Variables
	actionBlock:		<BlockClosure> block to handle incoming data
	port:		<Integer> port on which I receive UDP data
	socket:		<NeReceiverUdpSocket> socket listening on the UDP port
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
		'actionBlock',
		'port'
	],
	#category : #'NetworkExtras-UDP-Kernel'
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
	thread := ActiveObject repeat: [ self receiveData ] ensure: [socket closeAndDestroy].
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
	^port
]

{ #category : #accessing }
NeUdpServer >> port: portNumber [
	port := portNumber.

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
	receivedData := socket receive.
	receivedData ifEmpty: [ ^ self ].
	actionBlock cull: receivedData
]

{ #category : #activity }
NeUdpServer >> start [
	self isStarted ifTrue: [ ^self ].
	socket := NeUdpSocket receptionPort: self port.
	thread name: 'UDP server on port ', self port asString.
	thread start.
]

{ #category : #activity }
NeUdpServer >> stop [
	thread stop
]
