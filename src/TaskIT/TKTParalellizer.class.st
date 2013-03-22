Class {
	#name : #TKTParalellizer,
	#superclass : #TKTProxy,
	#category : #'TaskIT-Worker'
}

{ #category : #'as yet unclassified' }
TKTParalellizer >> paralellize [
	 ^ self.
]

{ #category : #'as yet unclassified' }
TKTParalellizer >> spawn: aBlock [ 
	^ aBlock doIt.
]
