Class {
	#name : #PhaROSTopicMock,
	#superclass : #Object,
	#instVars : [
		'messages'
	],
	#category : #'PhaROSNodeletsMerger-Test'
}

{ #category : #'as yet unclassified' }
PhaROSTopicMock >> hasCreated: aMessage [
	^ messages includes: aMessage 
]

{ #category : #'as yet unclassified' }
PhaROSTopicMock >> initialize [ 
	messages := Set new.
]

{ #category : #'as yet unclassified' }
PhaROSTopicMock >> newMessage [ 
	| msg |
	msg := 'geometry_msgs/PoseStamped' asPhaROSTypeClass new. 
	messages add: msg. 
	^ msg.
]
