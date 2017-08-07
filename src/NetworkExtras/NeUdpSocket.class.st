"
I am an UDP socket. 
I am an abstract class, use my subclasses
"
Class {
	#name : #NeUdpSocket,
	#superclass : #Socket,
	#category : #'NetworkExtras-UDP-Kernel'
}

{ #category : #'instance creation' }
NeUdpSocket class >> new [
	^self udpCreateIfFail: [
		UIManager default 
			abort: 'Either network is not available, or no resources left to create another socket'
			title: self name, ' creation failed!' ]
]
