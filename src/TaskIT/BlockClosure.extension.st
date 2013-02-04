Extension { #name : #BlockClosure }

{ #category : #'*TaskIT' }
BlockClosure >> asTask [
	^ TKTTask for: self.
]
