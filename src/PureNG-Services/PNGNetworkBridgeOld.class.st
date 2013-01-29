Class {
	#name : #PNGNetworkBridgeOld,
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

{ #category : #'process creation block' }
PNGNetworkBridgeOld class >> createProcessSocket: socket resutlBuffer: resultBuffer responseQueue: responseQueue [ 
	^ [ 
		[ 
			[
				| receptionInformation receivedByteCount |
				receptionInformation := socket receiveWithTimeOutUDPDataInto: resultBuffer.
				receivedByteCount := receptionInformation at: 1.
				responseQueue nextPut: (resultBuffer copyFrom: 1 to: receivedByteCount) 
			] on: ConnectionTimedOut do: [].
		] repeat 
	] newProcess
]

{ #category : #'finalization callback' }
PNGNetworkBridgeOld class >> finalizationBlock [
	^ [ :processBridge :socketBridge | 
		processBridge 	ifNotNil: [ processBridge terminate.].
		socketBridge ifNotNil: [ socketBridge closeAndDestroy ] ]
]

{ #category : #'instance creation' }
PNGNetworkBridgeOld class >> forRobot: aRobot [
	^self new
		robot: aRobot;
		start;
		yourself 
]

{ #category : #'initialize-release' }
PNGNetworkBridgeOld >> initialize [ 
	super  initialize.
	self resultBuffer: (ByteArray new: 1024).
	self responseQueue: SharedQueue new.


]

{ #category : #accessing }
PNGNetworkBridgeOld >> ip [
	^self robot ip
]

{ #category : #testing }
PNGNetworkBridgeOld >> isStarted [ 
	^self process notNil
]

{ #category : #accessing }
PNGNetworkBridgeOld >> port [
	^self robot port
]

{ #category : #accessing }
PNGNetworkBridgeOld >> process [
	^ process
]

{ #category : #accessing }
PNGNetworkBridgeOld >> process: anObject [
	process := anObject
]

{ #category : #finalization }
PNGNetworkBridgeOld >> registerForFinalization [
	self finalizationRegistry
		add: self
		executor:
			(ObjectFinalizer
				receiver: self class finalizationBlock
				selector: #cull:cull:
				arguments:
					{(self process).
					(self socket)})
]

{ #category : #accessing }
PNGNetworkBridgeOld >> responseQueue [
	^ responseQueue
]

{ #category : #accessing }
PNGNetworkBridgeOld >> responseQueue: anObject [
	responseQueue := anObject
]

{ #category : #accessing }
PNGNetworkBridgeOld >> resultBuffer [
	^ resultBuffer
]

{ #category : #accessing }
PNGNetworkBridgeOld >> resultBuffer: anObject [
	resultBuffer := anObject
]

{ #category : #accessing }
PNGNetworkBridgeOld >> robot [
	^ robot
]

{ #category : #accessing }
PNGNetworkBridgeOld >> robot: anObject [
	robot := anObject
]

{ #category : #communicating }
PNGNetworkBridgeOld >> send: commandString [
	self socket sendData: (ByteArray readHexFrom: commandString)
		toHost: self ip
		port: self port.

]

{ #category : #accessing }
PNGNetworkBridgeOld >> socket [
	^ socket
]

{ #category : #accessing }
PNGNetworkBridgeOld >> socket: anObject [
	socket := anObject
]

{ #category : #activity }
PNGNetworkBridgeOld >> start [
	self isStarted
		ifTrue: [ ^ self ].
	self socket: Socket newUDP.
	self
		process:
			(self class createProcessSocket: self socket resutlBuffer: self resultBuffer responseQueue: self responseQueue).
	self process
		priority: Processor highIOPriority;
		resume.
	self registerForFinalization
]

{ #category : #activity }
PNGNetworkBridgeOld >> stop [
	self class finalizationBlock cull: self process cull: self socket

]
