Class {
	#name : #ATSemanticAnalyzer,
	#superclass : #OCASTSemanticAnalyzer,
	#category : #'ActIT-Kernel'
}

{ #category : #'as yet unclassified' }
ATSemanticAnalyzer >> currentActorNode [

	^ RBMessageNode
		receiver: (RBVariableNode named: #ATCurrentActor)
		selector: #value
]

{ #category : #'as yet unclassified' }
ATSemanticAnalyzer >> visitVariableNode: aVariableNode [ 

	aVariableNode isSelf ifTrue: [ | newNode |
		newNode := self currentActorNode.
		aVariableNode replaceWith: newNode.
		newNode acceptVisitor: self.
	] ifFalse: [ super visitVariableNode: aVariableNode ].	
]
