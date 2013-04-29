Extension { #name : #Class }

{ #category : #'*PhaROS' }
Class >> adaptToAdapter [ 
	^ PhaROSConverter convertTo: self .
]
