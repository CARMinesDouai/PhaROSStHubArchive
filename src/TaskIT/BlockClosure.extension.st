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
BlockClosure >> taskIt [
	^ Task it: self asTask.
]

{ #category : #'*TaskIT' }
BlockClosure >> taskItAt: aPriority [
	^ Task it: (self asTaskAt: aPriority).
]
