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
		'sent',
		'owner',
		'topic',
		'mutex',
		'subscribers'
	],
	#category : #'PhaROS-Kernel'
}

{ #category : #construction }
PhaROSChannel class >> inputChannelfor: aRoStNode into: aRoStTopic to: aByteString [ 
	^PhaROSInPutChannel for: aRoStNode into: aRoStTopic to: aByteString 
]

{ #category : #construction }
PhaROSChannel class >> outPutChannelfor: aRoStNode into: aRoStTopic [ 
	^PhaROSOutPutChannel for: aRoStNode into: aRoStTopic
]

{ #category : #service }
PhaROSChannel >> close [
	self shouldBeImplemented.
]

{ #category : #accessing }
PhaROSChannel >> initialize [ 
	subscribers := Set new.
	mutex := Mutex new.
	sent := OrderedCollection new: self maxSize.
]

{ #category : #accessing }
PhaROSChannel >> lookupTopic: aTopicName [
	owner lookupTopic: aTopicName.
]

{ #category : #accessing }
PhaROSChannel >> maxSize [
	^100
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
	
	self storeSent: aMessage.
	
	self subscribers do: [
		:aNode |
		aNode receive: aMessage from: self.
	].
]

{ #category : #'as yet unclassified' }
PhaROSChannel >> send: aMessage to: aNode [
	aNode receive: aMessage from: self
]

{ #category : #service }
PhaROSChannel >> startUp [
	self subclassResponsibility.
]

{ #category : #accessing }
PhaROSChannel >> storeSent: aMessageBlock [ 
	sent add: aMessageBlock.
	[ sent size = self maxSize ] whileTrue: [
		sent remove: (sent at:1)
	].
	
	
]

{ #category : #accessing }
PhaROSChannel >> subscribe: aSubscriber [ 
	mutex critical: [
		subscribers add: aSubscriber.
	]
]

{ #category : #accessing }
PhaROSChannel >> subscribers [ 
	| copy | 
	mutex critical: [
		copy := subscribers copy.
	].
	^copy
]

{ #category : #accessing }
PhaROSChannel >> topic [ 
	^topic.
]

{ #category : #accessing }
PhaROSChannel >> topic: aTopic [
	topic := aTopic.
]

{ #category : #accessing }
PhaROSChannel >> unsubscribe: aPublisher [ 
	self owner == aPublisher ifTrue: [
		^ self close.
	].
	mutex critical:[
		subscribers remove: aPublisher ifAbsent: [].
	].
	

]
