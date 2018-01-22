Class {
	#name : #'Actionlib_tutorialsFibonacciResult',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

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
