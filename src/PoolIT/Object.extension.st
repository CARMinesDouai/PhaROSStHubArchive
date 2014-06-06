Extension { #name : #Object }

{ #category : #'*PoolIT' }
Object >> schedule [ 
	^ PITTasker createProxyFor: self handler: PITTaskerHandler  new.
	
]
