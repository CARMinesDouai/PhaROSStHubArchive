Class {
	#name : #PNGNetworkBridge,
	#superclass : #Object,
	#instVars : [
		'robot',
		'socket',
		'process',
		'responseQueue',
		'resultBuffer'
	],
	#category : #'PureNG-Kernel'
}

{ #category : #'instance creation' }
PNGNetworkBridge class >> forRobot: aRobot [
	^self new
		robot: aRobot;
		start;
		yourself 
]

{ #category : #'initialize-release' }
PNGNetworkBridge >> finalize [
	super finalize.
	self stop.
	Transcript cr; show: 'Bridge finalized !!!'
]

{ #category : #'initialize-release' }
PNGNetworkBridge >> initialize [ 
	super  initialize.
	self resultBuffer: (ByteArray new: 1024).
	self responseQueue: SharedQueue new.
	self finalizationRegistry add: self 
]

{ #category : #accessing }
PNGNetworkBridge >> ip [
	^self robot ip
]

{ #category : #testing }
PNGNetworkBridge >> isStarted [ 
	^self process notNil
]

{ #category : #accessing }
PNGNetworkBridge >> port [
	^self robot port
]

{ #category : #accessing }
PNGNetworkBridge >> process [
	^ process
]

{ #category : #accessing }
PNGNetworkBridge >> process: anObject [
	process := anObject
]

{ #category : #communicating }
PNGNetworkBridge >> receive [
	| receptionInformation receivedByteCount |
	socket waitForData.
	receptionInformation :=  socket receiveWithTimeOutUDPDataInto: resultBuffer.
	receivedByteCount := receptionInformation at: 1.
	^self resultBuffer copyFrom: 1 to: receivedByteCount
]

{ #category : #accessing }
PNGNetworkBridge >> responseQueue [
	^ responseQueue
]

{ #category : #accessing }
PNGNetworkBridge >> responseQueue: anObject [
	responseQueue := anObject
]

{ #category : #accessing }
PNGNetworkBridge >> resultBuffer [
	^ resultBuffer
]

{ #category : #accessing }
PNGNetworkBridge >> resultBuffer: anObject [
	resultBuffer := anObject
]

{ #category : #accessing }
PNGNetworkBridge >> robot [
	^ robot
]

{ #category : #accessing }
PNGNetworkBridge >> robot: anObject [
	robot := anObject
]

{ #category : #communicating }
PNGNetworkBridge >> send: commandString [
	self socket sendData: (ByteArray readHexFrom: commandString)
		toHost: self ip
		port: self port.

]

{ #category : #accessing }
PNGNetworkBridge >> socket [
	^ socket
]

{ #category : #accessing }
PNGNetworkBridge >> socket: anObject [
	socket := anObject
]

{ #category : #activity }
PNGNetworkBridge >> start [
	self isStarted ifTrue: [^self]. 
	self socket: Socket newUDP.
	self process: [[self responseQueue nextPut: self receive] repeat] newProcess.
	self process 
			priority: Processor highIOPriority;
			resume
]

{ #category : #activity }
PNGNetworkBridge >> stop [
	self process ifNotNil: [
		self process terminate.
		self process: nil].
	self socket ifNotNil: [
		self socket closeAndDestroy.
		self socket: nil]

]
