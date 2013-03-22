Extension { #name : #Object }

{ #category : #'*TaskIT' }
Object >> asThreadsafeReference [
	^ TKTVariable for: self.
]

{ #category : #'*TaskIT' }
Object >> paralellize [
	^ TKTParalellizer for: self.
]

{ #category : #'*TaskIT' }
Object >> scheddule [ 
	^ TKTTasker for: self.
]
