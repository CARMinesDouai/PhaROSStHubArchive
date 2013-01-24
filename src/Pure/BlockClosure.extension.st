Extension { #name : #BlockClosure }

{ #category : #'*Pure' }
BlockClosure >> asWork [ 
	^ PureWorkUnit do: self.
]

{ #category : #'*Pure' }
BlockClosure >> asWorkAt: aPriority [ 
	^ PureWorkUnit do: self at: aPriority .
]
