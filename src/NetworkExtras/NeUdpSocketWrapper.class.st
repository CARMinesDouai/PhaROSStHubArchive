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
NeUdpSocketWrapper >> destroy [
	socket closeAndDestroy
]

{ #category : #'initialize-release' }
NeUdpSocketWrapper >> initialize [
	super initialize.
	socket := Socket newUDP.

]

{ #category : #accessing }
NeUdpSocketWrapper >> port [
	^ port
]

{ #category : #accessing }
NeUdpSocketWrapper >> port: anObject [
	port := anObject
]
