Extension { #name : #BlockClosure }

{ #category : #'*PlanIT' }
BlockClosure >> & otherPlannable [ 
	^ self asPlanned & otherPlannable
]

{ #category : #'*PlanIT' }
BlockClosure >> => otherPlannable [ 
	^ self asPlanned => otherPlannable
]

{ #category : #'*PlanIT' }
BlockClosure >> asPlanned [
	^ TKTPlannedClosure of: self 
]
