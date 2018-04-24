Class {
	#name : #VMVector2d,
	#superclass : #DhbVector,
	#type : #variable,
	#category : #'VectorMaps-LinAlgebra'
}

{ #category : #'as yet unclassified' }
VMVector2d class >> point: aPoint [
	^(self new: 2)
		at: 1 put: (aPoint x);
		at: 2 put: (aPoint y);
		yourself.
]
