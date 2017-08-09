"
I am an abstract class that provides behavior to track ports  used for reception to avoid having 2 sockets listening on the same port.

Use  one of my subclases.
"
Class {
	#name : #NeUsedPortsTracker,
	#superclass : #Object,
	#classInstVars : [
		'usedPorts'
	],
	#category : #'NetworkExtras-UDP-Kernel'
}

{ #category : #'initialize-release' }
NeUsedPortsTracker class >> initUsedPorts [
	usedPorts := Set new
]

{ #category : #testing }
NeUsedPortsTracker class >> isUsedPort: portNumber [
	^self usedPorts includes: portNumber
]

{ #category : #tracking }
NeUsedPortsTracker class >> registerUsedPort: portNumber [
	self usedPorts add: portNumber
]

{ #category : #'initialize-release' }
NeUsedPortsTracker class >> resetUsedPorts [
	usedPorts := nil
]

{ #category : #tracking }
NeUsedPortsTracker class >> unregisterUsedPort: portNumber [
	self usedPorts remove: portNumber ifAbsent: [  ]
]

{ #category : #accessing }
NeUsedPortsTracker class >> usedPorts [
	usedPorts ifNil: [ self initUsedPorts ].
	^usedPorts
]
