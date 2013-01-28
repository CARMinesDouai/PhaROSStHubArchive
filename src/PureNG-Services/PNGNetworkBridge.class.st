"
o := Object new.
WeakRegistry default add: o. ""a shallow copy of o is registered""
o := nil.
Smalltalk garbageCollect.
""the shallow copy of o will receive the finalize message""

"
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

{ #category : #'process creation block' }
PNGNetworkBridge class >> createProcessSocket: socket resutlBuffer: resultBuffer responseQueue: responseQueue [ 
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
PNGNetworkBridge class >> finalizationBlock [
	^ [ :processBridge :socketBridge | 
		processBridge 	ifNotNil: [ processBridge terminate.].
		socketBridge ifNotNil: [ socketBridge closeAndDestroy ] ]
]

{ #category : #'instance creation' }
PNGNetworkBridge class >> forRobot: aRobot [
	^self new
		robot: aRobot;
		start;
		yourself 
]

{ #category : #'initialize-release' }
PNGNetworkBridge >> initialize [ 
	super  initialize.
	self resultBuffer: (ByteArray new: 1024).
	self responseQueue: SharedQueue new.


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

{ #category : #finalization }
PNGNetworkBridge >> registerForFinalization [
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
PNGNetworkBridge >> stop [
	self class finalizationBlock cull: self process cull: self socket

]
