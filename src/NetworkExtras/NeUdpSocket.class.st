"
I am an UDP socket. I store the IP and the Port so I make it easy to send different datagrams to the same receiver. I also ensure OS resources I use are cleanup upon garbage collection. 

 Instance Variables
	ip:		<ByteArray> Ip of the receiver
	port:		<Integer> port of the receiver

"
Class {
	#name : #NeUdpSocket,
	#superclass : #Socket,
	#category : #'NetworkExtras-UDP-Unicast'
}

{ #category : #'initialize-release' }
NeUdpSocket >> finalize [
	self closeAndDestroy
]

{ #category : #'initialize-release' }
NeUdpSocket >> initialize [
	super initialize.
	self finalizationRegistry add: self.

]
