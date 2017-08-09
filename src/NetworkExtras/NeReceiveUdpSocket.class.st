"
I am an UDP socket dedicated to reception. I provide a buffer for storing incoming data. 

I am useful for oneshot receptions. For repeated reception, use the higher lever class NeUdpServer.

The reception buffer is small by default (see defaultBufferSize method), but it can be increased.
Its content is overwritten upon each reception.

Instance Variables
	receptionBuffer		<ByteArray> reception buffer

"
Class {
	#name : #NeReceiveUdpSocket,
	#superclass : #NeUdpSocket,
	#classInstVars : [
		'usedPorts'
	],
	#category : #'NetworkExtras-UDP-Kernel'
}

{ #category : #'used ports tracking' }
NeReceiveUdpSocket class >> isUsedPort: portNumber [
	^self usedPorts includes: portNumber
]

{ #category : #'used ports tracking' }
NeReceiveUdpSocket class >> registerUsedPort: portNumber [
	self usedPorts add: portNumber
]

{ #category : #'used ports tracking' }
NeReceiveUdpSocket class >> resetUsedPorts [
	^usedPorts := Set new
]

{ #category : #'used ports tracking' }
NeReceiveUdpSocket class >> unregisterUsedPort: portNumber [
	self usedPorts remove: portNumber ifAbsent: [  ]
]

{ #category : #'used ports tracking' }
NeReceiveUdpSocket class >> usedPorts [
	usedPorts ifNil: [ self resetUsedPorts ].
	^usedPorts
]
