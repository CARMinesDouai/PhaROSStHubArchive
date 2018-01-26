Class {
	#name : #'Actionlib_tutorialsFibonacciGoal',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Actionlib_tutorialsFibonacciGoal class >> rosMd5Sum [ 
^'6889063349a00b249bd1661df429d822'
]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsFibonacciGoal class >> rosTypeDefinition [ 
^' int32 order
'
]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsFibonacciGoal class >> rosTypeName [ 
^'actionlib_tutorials/FibonacciGoal'
]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsFibonacciGoal class >> typeCreationOrder [ 
^32
]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsFibonacciGoal >> initialize [
	super initialize.
	 self order: 0. 

]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsFibonacciGoal >> order [
	^ self getAt: #order. 

]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsFibonacciGoal >> order: aValue [
	^ self at: #order put: aValue. 

]
