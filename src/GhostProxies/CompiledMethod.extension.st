Extension { #name : #CompiledMethod }

{ #category : #'*GhostProxies' }
CompiledMethod >> ghostPrintString [ 
	^ self methodClass name asString ,  '>>', self selector
]
