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
		'responseQueue',
		'resultBuffer',
		'activeObject'
	],
	#category : #'PureNG-Kernel'
}

{ #category : #'process creation block' }
PNGNetworkBridge class >> createProcessSocket: socket resutlBuffer: resultBuffer responseQueue: responseQueue [ 
	^ ActiveObject 
	do: [ 
			[ 
				[
					| receptionInformation receivedByteCount |
					receptionInformation := socket receiveWithTimeOutUDPDataInto: resultBuffer.
					receivedByteCount := receptionInformation at: 1.
					responseQueue nextPut: (resultBuffer copyFrom: 1 to: receivedByteCount) 
				] on: ConnectionTimedOut do: [].
			] repeat 
		] 
	ensure: [socket closeAndDestroy]
]

{ #category : #'instance creation' }
PNGNetworkBridge class >> forRobot: aRobot [
	^self new
		robot: aRobot;
		start;
		yourself 
]

{ #category : #accessing }
PNGNetworkBridge >> activeObject [
	^ activeObject
]

{ #category : #accessing }
PNGNetworkBridge >> activeObject: anObject [
	activeObject := anObject
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
	self activeObject ifNil: [^false].
	^self activeObject isStarted 
]

{ #category : #accessing }
PNGNetworkBridge >> port [
	^self robot port
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
		activeObject:
			(self class createProcessSocket: self socket resutlBuffer: self resultBuffer responseQueue: self responseQueue).
	self activeObject
		priority: Processor highIOPriority;
		start
]

{ #category : #activity }
PNGNetworkBridge >> stop [
	self activeObject stop
]
