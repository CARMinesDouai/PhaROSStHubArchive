Extension { #name : #Object }

{ #category : #'*TaskIT' }
Object >> paralellize [
	^ TKTTasker for: self.
]
