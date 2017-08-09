"
I am an UDP socket dedicated to sending. I store the IP and the Port so I make it easy to send different datagrams to the same receiver. 

 Instance Variables
	receiverIp:		<ByteArray> Ip of the receiver
	receiverPort:		<Integer> port of the receiver

"
Class {
	#name : #NeUnicastUdpSocket,
	#superclass : #NeUdpSocket,
	#instVars : [
		'receiverIp',
		'receiverPort'
	],
	#category : #'NetworkExtras-UDP-Kernel'
}

{ #category : #'instance creation' }
NeUnicastUdpSocket class >> receiverIp: ip port: portNumber [
	^self newUDP
		receiverIp: ip;
		receiverPort: portNumber;
		yourself
]

{ #category : #accessing }
NeUnicastUdpSocket >> receiverIp [
	^ receiverIp
]

{ #category : #accessing }
NeUnicastUdpSocket >> receiverIp: anObject [
	receiverIp := anObject asIpAddress

]

{ #category : #accessing }
NeUnicastUdpSocket >> receiverPort [
	^ receiverPort
]

{ #category : #accessing }
NeUnicastUdpSocket >> receiverPort: anObject [
	receiverPort := anObject
]

{ #category : #sending }
NeUnicastUdpSocket >> send: anObject [
	self sendData: anObject asByteArray toHost: self receiverIp port: self receiverPort
]

{ #category : #sending }
NeUnicastUdpSocket >> send: anObject receiverIp: hostAddress port: portNumber [
	self sendData: anObject asByteArray toHost: self receiverIp port: self receiverPort
]
