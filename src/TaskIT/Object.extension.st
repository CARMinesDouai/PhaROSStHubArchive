Extension { #name : #Object }

{ #category : #'*TaskIT' }
Object >> asThreadsafeReference [
	^ TKTVariable for: self.
]

{ #category : #'*TaskIT' }
Object >> paralellize [
	^ TKTTasker for: self.
]
