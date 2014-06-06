Extension { #name : #Object }

{ #category : #'*TaskIT' }
Object >> asArguments [
	^ { self }
]

{ #category : #'*TaskIT' }
Object >> asResult [ 
	^ self.
]

{ #category : #'*TaskIT' }
Object >> asStickyReference [ 
	^ TKTStickyReference for: self.
]

{ #category : #'*TaskIT' }
Object >> asThreadsafeReference [
	^ TKTExclusiveAccessVariable initialValue: self.
]

{ #category : #'*TaskIT' }
Object >> paralellize [
	^ TKTParalellizer createProxyFor: self handler: TKTParalellizerHandler  new.
]
