Extension { #name : #Class }

{ #category : #'*PhaROS' }
Class >> adapToAdapter [ 
	^ PhaROSConverter convertTo: self .
]
