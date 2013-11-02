Extension { #name : #String }

{ #category : #'*MulticastSocket-converting' }
String >> asIpAddress [
	^IpAddress fromString: self
]
