Class {
	#name : #NewTopicEvent,
	#superclass : #PhaROSEvent,
	#category : #'PhaROSDashBoard-Event'
}

{ #category : #'as yet unclassified' }
NewTopicEvent >> topic [

	^element
]

{ #category : #'as yet unclassified' }
NewTopicEvent >> topic: aTopic [

	element := aTopic
]
