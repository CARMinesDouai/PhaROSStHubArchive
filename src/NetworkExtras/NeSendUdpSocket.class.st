"
I am an UDP socket dedicated to sending. I store the IP and the Port so I make it easy to send different datagrams to the same receiver. 

 Instance Variables
	receiverIp:		<ByteArray> Ip of the receiver
	receiverPort:		<Integer> port of the receiver

"
Class {
	#name : #NeSendUdpSocket,
	#superclass : #NeUdpSocket,
	#instVars : [
		'receiverIp',
		'receiverPort'
	],
	#category : #'NetworkExtras-UDP-Kernel'
}

{ #category : #'instance creation' }
NeSendUdpSocket class >> broadcastPort: portNumber [
	^self receiverIp: self defaultBroadcastIp port: portNumber.
]

{ #category : #'instance creation' }
NeSendUdpSocket class >> defaultBroadcastIp [
	^#[255 255 255 255]
]

{ #category : #'instance creation' }
NeSendUdpSocket class >> receiverIp: ipStringOrByteArray port: portNumber [
	^self newUDP
		receiverIp: ipStringOrByteArray;
		receiverPort: portNumber;
		yourself
]

{ #category : #accessing }
NeSendUdpSocket >> byteArrayIpFrom: byteArrayOrString [
	(byteArrayOrString isKindOf: ByteArray) ifTrue: [ ^byteArrayOrString ].
	^NetNameResolver addressFromString: byteArrayOrString 
]

{ #category : #accessing }
NeSendUdpSocket >> receiverIp [
	^ receiverIp
]

{ #category : #accessing }
NeSendUdpSocket >> receiverIp: anObject [
	receiverIp := (self byteArrayIpFrom: anObject).
	receiverIp last = 255 ifFalse: [^self].
	self setOption: 'SO_BROADCAST' value: true
]

{ #category : #accessing }
NeSendUdpSocket >> receiverPort [
	^ receiverPort
]

{ #category : #accessing }
NeSendUdpSocket >> receiverPort: anObject [
	receiverPort := anObject
]

{ #category : #communicating }
NeSendUdpSocket >> send: anObject [
	self sendData: anObject asByteArray toHost: self receiverIp port: self receiverPort
]
