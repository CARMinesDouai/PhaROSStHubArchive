Extension { #name : #String }

{ #category : #'*NetworkExtras-converting' }
String >> asIpAddress [
	^NeIpAddress fromString: self
]
