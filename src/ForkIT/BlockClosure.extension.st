Extension { #name : #BlockClosure }

{ #category : #'*ForkIT' }
BlockClosure >> forkIt [
	^ self asTKTJob forkIt.
]
