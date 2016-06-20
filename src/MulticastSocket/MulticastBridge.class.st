Class {
	#name : #MulticastBridge,
	#superclass : #Object,
	#instVars : [
		'ipAddress',
		'port',
		'sendSocket',
		'receptionHandlerBlock',
		'receptionThread',
		'socket'
	],
	#category : #MulticastSocket
}

{ #category : #'instance creation' }
MulticastBridge class >> group: ipString port: portInt onReceptionDo: singleArgBlock [
	^self new 
		group: ipString port: portInt onReceptionDo: singleArgBlock;
		yourself
]

{ #category : #'activity - private' }
MulticastBridge >> closeSockets [
	socket closeAndDestroy
]

{ #category : #'initialize-release' }
MulticastBridge >> group: ipString port: portInt onReceptionDo: singleArgBlock [
	ipAddress :=  IpAddress fromString: ipString.
	port := portInt.
	socket := MulticastSocket 
					group: ipAddress
					port: port.
	socket setLoopbackModeTo: false.
	receptionHandlerBlock := singleArgBlock.
	receptionThread := ActiveObject 
		repeat: [ self receptionLoop ]
		ensure: [ self closeSockets ].
	receptionThread priority: self receptionPriority
]

{ #category : #'activity - private' }
MulticastBridge >> receptionLoop [
	[receptionHandlerBlock value: socket receive] repeat
]

{ #category : #'initialize-release' }
MulticastBridge >> receptionPriority [
	^Processor highIOPriority
]

{ #category : #'activity - public' }
MulticastBridge >> send: bytes [
	socket send: bytes
]

{ #category : #'activity - public' }
MulticastBridge >> start [
	receptionThread start
]

{ #category : #'activity - public' }
MulticastBridge >> stop [
	receptionThread stop
]
