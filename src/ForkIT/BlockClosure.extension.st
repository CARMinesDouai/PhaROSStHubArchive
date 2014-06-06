Extension { #name : #BlockClosure }

{ #category : #'*ForkIT' }
BlockClosure >> forkIt [
	^ self asTask forkIt.
]
