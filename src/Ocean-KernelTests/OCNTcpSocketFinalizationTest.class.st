Class {
	#name : #OCNTcpSocketFinalizationTest,
	#superclass : #OCNSocketFinalizationTest,
	#category : #'Ocean-KernelTests'
}

{ #category : #accessing }
OCNTcpSocketFinalizationTest >> stateTestingSelectors [ 
	^#(isClean isBound isConnected isDestroyed)
]

{ #category : #testing }
OCNTcpSocketFinalizationTest >> testBoundSocketFinalization [
	socket bindToLocalHostPort: 12345.
	self assertSocket: socket state:  #isBound.
	self assertSocketFinalized
]
