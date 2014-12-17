Class {
	#name : #OldTopicEvent,
	#superclass : #PhaROSEvent,
	#category : #'PhaROSDashBoard-Event'
}

{ #category : #'as yet unclassified' }
OldTopicEvent >> topic [

	^element
]

{ #category : #'as yet unclassified' }
OldTopicEvent >> topic: aTopic [

	element := aTopic
]
