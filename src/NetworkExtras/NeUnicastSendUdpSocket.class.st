"
I am an UDP socket dedicated to sending. I store the IP and the Port so I make it easy to send different datagrams to the same receiver. 

 Instance Variables
	receiverIp:		<ByteArray> Ip of the receiver
	receiverPort:		<Integer> port of the receiver

"
Class {
	#name : #NeUnicastSendUdpSocket,
	#superclass : #NeUdpSocket,
	#instVars : [
		'receiverIp',
		'receiverPort'
	],
	#category : #'NetworkExtras-UDP-Kernel'
}

{ #category : #'instance creation' }
NeUnicastSendUdpSocket class >> receiverIp: ip port: portNumber [
	^self newUDP
		receiverIp: ip;
		receiverPort: portNumber;
		yourself
]

{ #category : #accessing }
NeUnicastSendUdpSocket >> receiverIp [
	^ receiverIp
]

{ #category : #accessing }
NeUnicastSendUdpSocket >> receiverIp: anObject [
	receiverIp := anObject asIpAddress

]

{ #category : #accessing }
NeUnicastSendUdpSocket >> receiverPort [
	^ receiverPort
]

{ #category : #accessing }
NeUnicastSendUdpSocket >> receiverPort: anObject [
	receiverPort := anObject
]

{ #category : #communicating }
NeUnicastSendUdpSocket >> send: anObject [
	self sendData: anObject asByteArray toHost: self receiverIp port: self receiverPort
]
