Class {
	#name : #NeSendUdpSocket,
	#superclass : #NeUdpSocket,
	#instVars : [
		'ip',
		'port'
	],
	#category : #'NetworkExtras-UDP-Unicast'
}

{ #category : #'instance creation' }
NeSendUdpSocket class >> ip: ipStringOrByteArray port: portNumber [
	^self newUDP
		ip: ipStringOrByteArray;
		port: portNumber;
		yourself
]

{ #category : #accessing }
NeSendUdpSocket >> byteArrayIpFrom: byteArrayOrString [
	(byteArrayOrString isKindOf: ByteArray) ifTrue: [ ^byteArrayOrString ].
	^NetNameResolver addressFromString: byteArrayOrString 
]

{ #category : #accessing }
NeSendUdpSocket >> ip [
	^ ip
]

{ #category : #accessing }
NeSendUdpSocket >> ip: byteArrayOrString [
	ip := self byteArrayIpFrom: byteArrayOrString.
]

{ #category : #accessing }
NeSendUdpSocket >> port [
	^ port
]

{ #category : #accessing }
NeSendUdpSocket >> port: anInteger [
	port := anInteger
]

{ #category : #communicating }
NeSendUdpSocket >> send: stringOrByteArray [
	self sendData: stringOrByteArray toHost: self ip port: self port
	
]
