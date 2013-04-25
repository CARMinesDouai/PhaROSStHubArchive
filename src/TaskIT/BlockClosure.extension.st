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
BlockClosure >> doIt [
	^ self asTask doIt.
]

{ #category : #'*TaskIT' }
BlockClosure >> doItOnceWhen: aConditionalBlock [
	^ (TKTConsumableEventualTask for: self when: aConditionalBlock for: 1) taskIt.
]

{ #category : #'*TaskIT' }
BlockClosure >> doItWhen: aConditionalBlock [ 
	| eventualTask |
	eventualTask := TKTEventualTask for: self when: aConditionalBlock.
	eventualTask taskIt.
	^ eventualTask.
]

{ #category : #'*TaskIT' }
BlockClosure >> taskIt [
	^ TKTTaskDispatcher it: self asTask.
]

{ #category : #'*TaskIT' }
BlockClosure >> taskItAt: aPriority [
	^ TKTTaskDispatcher it: (self asTaskAt: aPriority).
]

{ #category : #'*TaskIT' }
BlockClosure >> when: aConditionalBlock [ 
	^ aConditionalBlock doItWhen:self.
]
