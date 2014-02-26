Class {
	#name : #PhaROSTopicMock,
	#superclass : #Object,
	#instVars : [
		'messages'
	],
	#category : #'PhaROS-Nodelets-Merger-Test'
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
	msg := Geometry_msgsPoseStamped new. 
	messages add: msg. 
	^ msg.
]
