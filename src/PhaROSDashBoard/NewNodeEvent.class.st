Class {
	#name : #NewNodeEvent,
	#superclass : #PhaROSEvent,
	#category : #'PhaROSDashBoard-Event'
}

{ #category : #'as yet unclassified' }
NewNodeEvent >> node [
	
	^ element
]

{ #category : #'as yet unclassified' }
NewNodeEvent >> node: aNode [

	element := aNode	
]
