Class {
	#name : #NeBroadcastSocket,
	#superclass : #NeUdpSocket,
	#instVars : [
		'ip',
		'port'
	],
	#category : #'NetworkExtras-UDP-Kernel'
}

{ #category : #'instance creation' }
NeBroadcastSocket class >> ip: ip port: portNumber [
	^self new 
		ip: ip port: portNumber;
		yourself
]

{ #category : #'instance creation' }
NeBroadcastSocket class >> port: portNumber [
	^self new 
		port: portNumber;
		yourself
]

{ #category : #'initialize-release' }
NeBroadcastSocket >> defaultBroadcastIp [
	^#[255 255 255 255]
]

{ #category : #accessing }
NeBroadcastSocket >> ip [
	^ip
]

{ #category : #'initialize-release' }
NeBroadcastSocket >> ip: ipAddressOrString  port: portNumber [
	ip := ipAddressOrString asIpAddress.
	port := portNumber.
	self setOption: 'SO_BROADCAST' value: true
]

{ #category : #accessing }
NeBroadcastSocket >> port [
	^port
]

{ #category : #'initialize-release' }
NeBroadcastSocket >> port: portNumber [
	self ip: self defaultBroadcastIp port: portNumber
]

{ #category : #communicating }
NeBroadcastSocket >> send: anObject [
	self sendData: anObject asByteArray toHost: ip port: port
]
