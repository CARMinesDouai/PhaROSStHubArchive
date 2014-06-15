Extension { #name : #BlockClosure }

{ #category : #'*PoolIT' }
BlockClosure >> doItOnceWhen: aConditionalBlock [
	^ (PITConsumableEventualTask for: self when: aConditionalBlock for: 1) scheduleIt.
]

{ #category : #'*PoolIT' }
BlockClosure >> doItWhen: aConditionalBlock [ 
	| eventualTask |
	eventualTask := PITEventualTask for: self when: aConditionalBlock.
	eventualTask scheduleIt.
	^ eventualTask.
]

{ #category : #'*PoolIT' }
BlockClosure >> scheduleIt [
	^ PITWorkersPool it: self asTKTJob.
]

{ #category : #'*PoolIT' }
BlockClosure >> taskItAt: aPriority [
	^ PITWorkersPool it: (self asTaskAt: aPriority).
]

{ #category : #'*PoolIT' }
BlockClosure >> when: aConditionalBlock [ 
	^ aConditionalBlock doItWhen:self.
]
