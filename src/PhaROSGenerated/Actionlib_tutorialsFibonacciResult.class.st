Class {
	#name : #'Actionlib_tutorialsFibonacciResult',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Actionlib_tutorialsFibonacciResult class >> rosMd5Sum [ 
^'b81e37d2a31925a0e8ae261a8699cb79'
]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsFibonacciResult class >> rosTypeDefinition [ 
^' int32[] sequence
'
]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsFibonacciResult class >> rosTypeName [ 
^'actionlib_tutorials/FibonacciResult'
]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsFibonacciResult class >> typeCreationOrder [ 
^34
]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsFibonacciResult >> initialize [
	super initialize.
	 self sequence: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsFibonacciResult >> sequence [
	^ self getAt: #sequence. 

]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsFibonacciResult >> sequence: aValue [
	^ self at: #sequence put: aValue. 

]
