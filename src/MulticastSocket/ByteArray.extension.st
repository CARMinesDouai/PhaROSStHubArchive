Extension { #name : #ByteArray }

{ #category : #'*MulticastSocket-converting' }
ByteArray >> asIpAddress [
	IpAddress adoptInstance: self.
	^self
]
