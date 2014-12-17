Class {
	#name : #NewLinkEvent,
	#superclass : #PhaROSEvent,
	#category : #'PhaROSDashBoard-Event'
}

{ #category : #'as yet unclassified' }
NewLinkEvent >> link [

	^ element
]

{ #category : #'as yet unclassified' }
NewLinkEvent >> link: aLink [

	element := aLink
]
