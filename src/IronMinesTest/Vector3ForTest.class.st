Class {
	#name : #Vector3ForTest,
	#superclass : #Object,
	#instVars : [
		'x',
		'y',
		'z'
	],
	#category : #IronMinesTest
}

{ #category : #'as yet unclassified' }
Vector3ForTest >> initialize [
	super initialize.
	x := y:= z := 0
]

{ #category : #'as yet unclassified' }
Vector3ForTest >> x [
	^ x
]

{ #category : #'as yet unclassified' }
Vector3ForTest >> x: aNumber [ 
	x := aNumber
]

{ #category : #'as yet unclassified' }
Vector3ForTest >> z [
	^ z
]

{ #category : #'as yet unclassified' }
Vector3ForTest >> z: anInteger [ 
	z := anInteger
]
