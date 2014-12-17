Class {
	#name : #OldLinkEvent,
	#superclass : #PhaROSEvent,
	#category : #'PhaROSDashBoard-Event'
}

{ #category : #'as yet unclassified' }
OldLinkEvent >> link [

	^ element
]

{ #category : #'as yet unclassified' }
OldLinkEvent >> link: aLink [

	element := aLink
]
