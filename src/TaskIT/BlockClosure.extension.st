Extension { #name : #BlockClosure }

{ #category : #'*TaskIT' }
BlockClosure >> asTask [
	^ TKTTask for: self.
]

{ #category : #'*TaskIT' }
BlockClosure >> taskIt [
	^ Task it: self asTask.
]
