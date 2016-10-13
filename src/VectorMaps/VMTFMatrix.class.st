Class {
	#name : #VMTFMatrix,
	#superclass : #DhbMatrix,
	#category : #'VectorMaps-LinAlgebra'
}

{ #category : #'as yet unclassified' }
VMTFMatrix class >> identity [
	^(self rows: {
		{1.0.  0.0.  0.0}.
		{0.0.  1.0.  0.0}.
		{0.0.  0.0.  1.0}
	})

]

{ #category : #'as yet unclassified' }
VMTFMatrix class >> new [
	^(super new)
		initialize: 3;
		yourself.
]

{ #category : #'as yet unclassified' }
VMTFMatrix class >> zeros [
	^(self rows: {
		{0.0.  0.0.  0.0}.
		{0.0.  0.0.  0.0}.
		{0.0.  0.0.  0.0}
	})

]

{ #category : #'as yet unclassified' }
VMTFMatrix >> angle: aNumber [
	"sets the rotation sub-matrix according to the provided value. the value is interpreted as radians"
	| sin cos |
	sin := aNumber sin.
	cos := aNumber cos.
	
	self at: 1 at: 1 put: cos.
	self at: 1 at: 2 put: (sin negated).
	self at: 2 at: 2 put: cos.
	self at: 2 at: 1 put: sin.
	
]

{ #category : #'as yet unclassified' }
VMTFMatrix >> translate [
	^(DhbVector new: 2)
		at: 1 put: (self at: 1 at: 3);
		at: 2 put: (self at: 2 at: 3).
]

{ #category : #'as yet unclassified' }
VMTFMatrix >> translate: aVector [
	self at: 1 at: 3 put: (aVector at: 1).
	self at: 2 at: 3 put: (aVector at: 2).

]
