Class {
	#name : #OldNodeEvent,
	#superclass : #PhaROSEvent,
	#category : #'PhaROSDashBoard-Event'
}

{ #category : #'as yet unclassified' }
OldNodeEvent >> node [
	
	^ element
]

{ #category : #'as yet unclassified' }
OldNodeEvent >> node: aNode [

	element := aNode	
]
