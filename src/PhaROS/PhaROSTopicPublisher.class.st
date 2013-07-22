"
PhaROSTopicPublisher is a simple object that hide the complexity of knowing the node and name/type of a topic in order to be able to send a message. 

The main message is 
	
	#send: aBlock
	
that receives a block of the shape of [ :msg | ""message configuratio ""]. 

And it sends a message in name of the configured node, throught the given topic. 
"
Class {
	#name : #PhaROSTopicPublisher,
	#superclass : #Object,
	#instVars : [
		'node',
		'topic'
	],
	#category : #'PhaROS-TopicHandlers'
}

{ #category : #'as yet unclassified' }
PhaROSTopicPublisher class >> node: aNode topic: aTopic [
	^ self new node: aNode; topic: aTopic; yourself.
]

{ #category : #'as yet unclassified' }
PhaROSTopicPublisher >> node: aNode [
	node:= aNode.
]

{ #category : #'as yet unclassified' }
PhaROSTopicPublisher >> send: aBlock [
	^ node sendTo: topic name typedAs: topic type a: aBlock.
]

{ #category : #'as yet unclassified' }
PhaROSTopicPublisher >> topic [
	 ^ topic. 
]

{ #category : #'as yet unclassified' }
PhaROSTopicPublisher >> topic: aTopic [
	topic := aTopic
]
