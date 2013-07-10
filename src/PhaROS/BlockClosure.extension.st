Extension { #name : #BlockClosure }

{ #category : #'*PhaROS' }
BlockClosure >> hasAttribute: anAttribute [
	^ false. "just for testing"
]

{ #category : #'*PhaROS' }
BlockClosure >> receive: aMessage from: aChannel [ 
	^ self cull: aMessage cull: aChannel.
]

{ #category : #'*PhaROS' }
BlockClosure >> receive: aMessage from: aChannel  at: aStamp [
	^ self cull: aMessage cull: aChannel cull: aStamp.
]
