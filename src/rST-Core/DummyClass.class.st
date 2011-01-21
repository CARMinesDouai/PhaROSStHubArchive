Class {
	#name : #DummyClass,
	#superclass : #Object,
	#category : #'rST-Tests'
}

{ #category : #'as yet unclassified' }
DummyClass >> decrement: count with: aClass [
	Transcript show: count; cr.
	(count = 0) ifTrue:[^ count] ifFalse: [^ (aClass decrement: (count - 1) with: self class new)].
]

{ #category : #'as yet unclassified' }
DummyClass >> decrement: count withArray: anArray [
	Transcript show: count; cr.
	(count = 0) ifTrue:[^ count] ifFalse: [^ (anArray collect: [:each | each decrement: (count - 1) withArray: {self class new}]) at: 1].
]
