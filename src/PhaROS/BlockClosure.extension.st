Extension { #name : #BlockClosure }

{ #category : #'*PhaROS' }
BlockClosure >> receive: aMessage from: aChannel [ 
	^ self cull: aMessage cull: aChannel.
]
