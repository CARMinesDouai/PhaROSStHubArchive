Extension { #name : #DhbVector }

{ #category : #'*VectorMaps' }
DhbVector >> asPoint [
	^Point x: (self at: 1) y: (self at: 2).
]
