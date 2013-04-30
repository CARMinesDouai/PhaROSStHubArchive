Extension { #name : #PNGController }

{ #category : #'*PureROS' }
PNGController >> finalize [ 
	super finalize.
	robot := nil.
]
