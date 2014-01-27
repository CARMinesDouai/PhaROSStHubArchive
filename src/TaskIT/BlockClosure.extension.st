Extension { #name : #BlockClosure }

{ #category : #'*TaskIT' }
BlockClosure >> & otherPlannable [ 
	^ self asPlanned & otherPlannable
]

{ #category : #'*TaskIT' }
BlockClosure >> => otherPlannable [ 
	^ self asPlanned => otherPlannable
]

{ #category : #'*TaskIT' }
BlockClosure >> asPlanned [
	^ TKTPlannedClosure of: self 
]

{ #category : #'*TaskIT' }
BlockClosure >> asTask [
	^ TKTTask for: self.
]

{ #category : #'*TaskIT' }
BlockClosure >> asTaskAt: aPriority [
	^ TKTTask for: self at: aPriority.
]

{ #category : #'*TaskIT' }
BlockClosure >> doItOnceWhen: aConditionalBlock [
	^ (TKTConsumableEventualTask for: self when: aConditionalBlock for: 1) scheduleIt.
]

{ #category : #'*TaskIT' }
BlockClosure >> doItWhen: aConditionalBlock [ 
	| eventualTask |
	eventualTask := TKTEventualTask for: self when: aConditionalBlock.
	eventualTask scheduleIt.
	^ eventualTask.
]

{ #category : #'*TaskIT' }
BlockClosure >> scheduleIt [
	^ TKTTaskDispatcher it: self asTask.
]

{ #category : #'*TaskIT' }
BlockClosure >> shootIt [
	^ self asTask shootIt.
]

{ #category : #'*TaskIT' }
BlockClosure >> taskItAt: aPriority [
	^ TKTTaskDispatcher it: (self asTaskAt: aPriority).
]

{ #category : #'*TaskIT' }
BlockClosure >> when: aConditionalBlock [ 
	^ aConditionalBlock doItWhen:self.
]
