Class {
	#name : #NeUdpSocket,
	#superclass : #Object,
	#instVars : [
		'ip',
		'port',
		'socket'
	],
	#category : #'NetworkExtras-UDP-SendReceiveLargeData'
}

{ #category : #'initialize-release' }
NeUdpSocket >> finalize [
	socket closeAndDestroy
]

{ #category : #'initialize-release' }
NeUdpSocket >> initialize [
	super initialize.
	socket := Socket newUDP.
	self finalizationRegistry add: self.
]

{ #category : #accessing }
NeUdpSocket >> ip [
	^ ip
]

{ #category : #accessing }
NeUdpSocket >> ip: anObject [
	ip := anObject
]

{ #category : #accessing }
NeUdpSocket >> port [
	^ port
]

{ #category : #accessing }
NeUdpSocket >> port: anObject [
	port := anObject
]

{ #category : #sending }
NeUdpSocket >> send: stringOrByteArray [
	socket sendData: stringOrByteArray toHost: self ip port: self port
	
]
