Class {
	#name : #'Actionlib_tutorialsFibonacciFeedback',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Actionlib_tutorialsFibonacciFeedback class >> rosMd5Sum [ 
^'b81e37d2a31925a0e8ae261a8699cb79'
]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsFibonacciFeedback class >> rosTypeDefinition [ 
^' int32[] sequence
'
]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsFibonacciFeedback class >> rosTypeName [ 
^'actionlib_tutorials/FibonacciFeedback'
]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsFibonacciFeedback class >> typeCreationOrder [ 
^36
]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsFibonacciFeedback >> initialize [
	super initialize.
	 self sequence: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsFibonacciFeedback >> sequence [
	^ self getAt: #sequence. 

]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsFibonacciFeedback >> sequence: aValue [
	^ self at: #sequence put: aValue. 

]
