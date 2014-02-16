Extension { #name : #BlockClosure }

{ #category : #'*TaskITFork' }
BlockClosure >> forkIt [
	^ self asTask forkIt.
]
