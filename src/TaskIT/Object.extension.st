Extension { #name : #Object }

{ #category : #'*TaskIT' }
Object >> paralellized [
	^ TKTTasker for: self.
]
