Class {
	#name : #NeUdpSocketWrapper,
	#superclass : #Object,
	#instVars : [
		'socket',
		'port'
	],
	#category : #'NetworkExtras-UDP-SendReceiveLargeData'
}

{ #category : #'initialize-release' }
NeUdpSocketWrapper >> defaultMaxChunkSize [
	^1500
]

{ #category : #'initialize-release' }
NeUdpSocketWrapper >> destroy [
	socket closeAndDestroy
]

{ #category : #'initialize-release' }
NeUdpSocketWrapper >> finalize [
	self destroy.
]

{ #category : #'initialize-release' }
NeUdpSocketWrapper >> initialize [
	super initialize.
	socket := Socket newUDP.
	self maxChunkSize: self defaultMaxChunkSize.
	self finalizationRegistry add: self.
]

{ #category : #'initialize-release' }
NeUdpSocketWrapper >> maxChunkSize: anInteger [
	self subclassResponsibility
]

{ #category : #accessing }
NeUdpSocketWrapper >> port [
	^ port
]

{ #category : #accessing }
NeUdpSocketWrapper >> port: anObject [
	port := anObject
]
