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
