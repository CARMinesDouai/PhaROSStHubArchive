Class {
	#name : #PhaROSExternalNode,
	#superclass : #Object,
	#instVars : [
		'name',
		'topic',
		'socket',
		'message',
		'isConnected',
		'nodeDataSender'
	],
	#category : #'PhaROS-Kernel'
}

{ #category : #'as yet unclassified' }
PhaROSExternalNode class >> named: aCallerId subscriberOf: aTopicName with: aSocket [
	^self new 	name: aCallerId; 
				topic: aTopicName; 
				socket: aSocket; 
				yourself.
]

{ #category : #'message handling' }
PhaROSExternalNode >> addToMessagesQueue: aBinaryMessage [
[
	nodeDataSender addToMessagesQueue: aBinaryMessage.
]	on: Error do: [
	topic stop.	
]

]

{ #category : #service }
PhaROSExternalNode >> destroy [
	self stop.
]

{ #category : #'message handling' }
PhaROSExternalNode >> initialize [ 
	nodeDataSender := PhaROSDataSender for: self.
	
]

{ #category : #accessing }
PhaROSExternalNode >> name: aName [
	name := aName.
	
]

{ #category : #'message handling' }
PhaROSExternalNode >> receive: aMessage from: aChannel [ 
	self addToMessagesQueue: aMessage dump.
	


]

{ #category : #bla }
PhaROSExternalNode >> receiveDataTimeout: aSmallInteger into: aByteString [ 
	self flag:#putitInOrder.
	
	^ socket receiveDataTimeout: aSmallInteger into: aByteString .
]

{ #category : #accessing }
PhaROSExternalNode >> socket [ 
	^ socket.
]

{ #category : #accessing }
PhaROSExternalNode >> socket: aSocket [
	socket := aSocket. 
]

{ #category : #service }
PhaROSExternalNode >> stop [
	socket close.
]

{ #category : #'message handling' }
PhaROSExternalNode >> subscribedTo: aChannel [	
	
	message := PhaROSHSMessage newPublisherWith: [ :msg |
		msg callerId: aChannel owner name.
		msg md5Sum: topic md5Sum.
		msg type: topic type.
		msg latching: aChannel isLatchedChannel.
	].
	message sendTo: socket.
	
]

{ #category : #accessing }
PhaROSExternalNode >> topic: aTopicName [ 
	topic := aTopicName.
	
]

{ #category : #service }
PhaROSExternalNode >> unregisterPublisher: aNode [
	[socket close] on: Error do: [
		Transcript show: 'error closing socket'.
	].
]
