"
I am an UDP socket dedicated to sending. I store the target IP and the Port so I make it easy to send different datagrams to the same target. 

 Instance Variables
	targetIp:		<NeIpAddress> Ip of the socket to which I send data
 	targetPort	<Integer>  port of the socket to which I send data

"
Class {
	#name : #NeUnicastUdpSocket,
	#superclass : #NeUdpSocket,
	#instVars : [
		'targetIp',
		'targetPort'
	],
	#category : #'NetworkExtras-UDP-Kernel'
}

{ #category : #'instance creation' }
NeUnicastUdpSocket class >> targetIp: ip port: portNumber [
	^self newUDP
		targetIp: ip;
		targetPort: portNumber;
		yourself
]

{ #category : #sending }
NeUnicastUdpSocket >> send: anObject [
	^self sendData: anObject asByteArray toHost: self targetIp port: self targetPort
]

{ #category : #sending }
NeUnicastUdpSocket >> send: anObject targetIp: ipAddress port: portNumber [
	self targetIp: ipAddress.
	self targetPort: portNumber.
	^self send: anObject
]

{ #category : #accessing }
NeUnicastUdpSocket >> targetIp [
	^ targetIp
]

{ #category : #accessing }
NeUnicastUdpSocket >> targetIp: anObject [
	targetIp := anObject asIpAddress

]

{ #category : #accessing }
NeUnicastUdpSocket >> targetPort [
	^ targetPort
]

{ #category : #accessing }
NeUnicastUdpSocket >> targetPort: anObject [
	targetPort := anObject
]
