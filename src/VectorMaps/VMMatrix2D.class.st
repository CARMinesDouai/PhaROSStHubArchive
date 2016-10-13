Class {
	#name : #VMMatrix2D,
	#superclass : #DhbMatrix,
	#category : #'VectorMaps-LinAlgebra'
}

{ #category : #creation }
VMMatrix2D class >> identity [
	^(self new)
		rows: {  {1.  0}.  {0.  1}  };
		yourself.
]

{ #category : #creation }
VMMatrix2D class >> zeros [
	^(self new)
		rows: {  {0.  0}.  {0.  0}  };
		yourself.
]
