Class {
	#name : #ActionlibTestFeedback,
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
ActionlibTestFeedback class >> rosMd5Sum [ 
^'49ceb5b32ea3af22073ede4a0328249e'
]

{ #category : #'as yet unclassified' }
ActionlibTestFeedback class >> rosTypeDefinition [ 
^' int32 feedback
'
]

{ #category : #'as yet unclassified' }
ActionlibTestFeedback class >> rosTypeName [ 
^'actionlib/TestFeedback'
]

{ #category : #'as yet unclassified' }
ActionlibTestFeedback class >> typeCreationOrder [ 
^7
]

{ #category : #'as yet unclassified' }
ActionlibTestFeedback >> feedback [
	^ self getAt: #feedback. 

]

{ #category : #'as yet unclassified' }
ActionlibTestFeedback >> feedback: aValue [
	^ self at: #feedback put: aValue. 

]

{ #category : #'as yet unclassified' }
ActionlibTestFeedback >> initialize [
	super initialize.
	 self feedback: 0. 

]
