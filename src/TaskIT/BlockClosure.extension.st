Extension { #name : #BlockClosure }

{ #category : #'*TaskIT' }
BlockClosure >> asTKTJob [
	^ TKTJob for: self.
]

{ #category : #'*TaskIT' }
BlockClosure >> asTaskAt: aPriority [
	^ TKTJob for: self at: aPriority.
]

{ #category : #'*TaskIT' }
BlockClosure >> shootIt [
	^ self asTKTJob shootIt.
]
