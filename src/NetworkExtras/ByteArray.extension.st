Extension { #name : #ByteArray }

{ #category : #'*NetworkExtras-converting' }
ByteArray >> asIpAddress [
	NeIpAddress adoptInstance: self.
	^self
]
