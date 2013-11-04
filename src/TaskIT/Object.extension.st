Extension { #name : #Object }

{ #category : #'*TaskIT' }
Object >> asStickyReference [ 
	^ TKTStickyReference for: self.
]

{ #category : #'*TaskIT' }
Object >> asThreadsafeReference [
	^ TKTVariable for: self.
]

{ #category : #'*TaskIT' }
Object >> paralellize [
	^ TKTParalellizer createProxyFor: self handler: TKTParalellizerHandler  new.
]

{ #category : #'*TaskIT' }
Object >> scheddule [ 
	^ TKTTasker createProxyFor: self handler: TKTTaskerHandler  new.
	
]
