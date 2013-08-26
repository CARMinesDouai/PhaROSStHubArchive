"
PhaROSChannel is a thread-safe object that represent a one-direction communication in between one node that publish and n nodes that are interested in this publishing. This object also keep tranking of the last maxSize (default 100) sent messages. to be able to send them to a new subscriber if is needed.


There are two flavors of PhaROSChannel:

	1- PhaROSInPutChannel 
		This channel is used when the publisher that owns the channel is a node external to the image, and its in charge of the communcation and also for the xml-rpc handshake with this external node.
	
	2- PhaROSOutPutChannel 
		This channel is used when the publisher that owns the channel is a node local to the image. Its in charge of the handshake process for external nodes that wants to subscribe to, send old messages to latched new nodes, and also its in charge to resolve the message instantiation and configuration before sending. 
		
	


"
Class {
	#name : #PhaROSChannel,
	#superclass : #Object,
	#instVars : [
		'owner',
		'topic'
	],
	#category : #'PhaROS-Kernel'
}

{ #category : #service }
PhaROSChannel >> finalize [
	self shouldBeImplemented.
]

{ #category : #accessing }
PhaROSChannel >> isOutput [
	^ self isInput not.
]

{ #category : #accessing }
PhaROSChannel >> owner [
	^ owner.
	
]

{ #category : #accessing }
PhaROSChannel >> owner: aNode [
	owner := aNode.
]

{ #category : #'message handling' }
PhaROSChannel >> send: aMessage [
	self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
PhaROSChannel >> send: aMessage to: aNode [
	aNode receive: aMessage from: self
]

{ #category : #accessing }
PhaROSChannel >> topic [ 
	^topic.
]

{ #category : #accessing }
PhaROSChannel >> topic: aTopic [
	topic := aTopic.
]
