Extension { #name : #BlockClosure }

{ #category : #'*TaskIT' }
BlockClosure >> asTask [
	^ TKTTask for: self.
]

{ #category : #'*TaskIT' }
BlockClosure >> asTaskAt: aPriority [
	^ TKTTask for: self at: aPriority.
]

{ #category : #'*TaskIT' }
BlockClosure >> shootIt [
	^ self asTask shootIt.
]
